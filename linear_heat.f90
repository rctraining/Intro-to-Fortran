
! ***********************************************************************

!  Copyright 2016 Dan Nagle

!   This program is free software; you can redistribute it and/or
!   modify it under the terms of the GNU General Public
!   License as published by the Free Software Foundation; either
!   version 3 of the License, or (at your option) any later version.

!   This program is distributed in the hope that it will be useful,
!   but WITHOUT ANY WARRANTY; without even the implied warranty of
!   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
!   General Public License for more details.

!   You should have received a copy of the GNU General Public
!   License along with this program; if not, write to the Free
!   Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

! To report bugs, suggest enhancements, or contact the Authors,
! Contact:
!    Dan Nagle
!                               send email to danlnagle@me.com
!                                  or mail to 6175 Habitat Dr Apt 1070
!                                             Boulder, CO 80301 USA

!  linear_heat

! ----------------------------------------------------------------------

program linear_heat

! ----------------------------------------------------------------------

!  linear_heat uses modules

! ----------------------------------------------------------------------

!  processor description

use iso_fortran_env, only: real64, input_unit, output_unit, event_type, compiler_version, compiler_options

! ----------------------------------------------------------------------

!  all names are declared: require explicit declarations

implicit none

! ----------------------------------------------------------------------

!  linear_heat constants

! ----------------------------------------------------------------------

real( real64), parameter :: half = 0.5_real64

integer, parameter :: segment_size = 100

real( real64), parameter :: tolerance = 1.0e-14_real64

! ----------------------------------------------------------------------

!  linear_heat types

! ----------------------------------------------------------------------

! ----------------------------------------------------------------------

!  linear_heat data

! ----------------------------------------------------------------------

character( len= 20) :: output_file
integer :: data_unit

integer :: me, np, i, lo_i, hi_i

real( real64), dimension( 0: segment_size + 1), codimension[ *] :: heat = 0.0_real64

real( real64), dimension( 1: segment_size) :: old

!  each segment has done "local calculation done" and update "neighbor's ghosts updated"

type( event_type), codimension[ *] :: update, done

real( real64) :: delta, delta_0, delta_np1, old_0, old_np1

! ----------------------------------------------------------------------

!  linear_heat text

! ----------------------------------------------------------------------

continue

!  number of images and which one this one is

   me = this_image()
   np = num_images()

   lo_i = lcobound( heat, 1)
   hi_i = ucobound( heat, 1)

!  image 1 writes the compiler and gets the problem

   if( me == 1 )then

      write( output_unit, '( a)') compiler_version()
      write( output_unit, '( a)') compiler_options()

      write( output_unit, '( a)') 'left side temperature?'

      read( input_unit, *) heat( 0)

   end if

   sync all

!  loop over all images

   parallel: do

      old_0 = heat( 0)
      old_np1 = heat( segment_size + 1)

!  loop on this image

      local: do

         old( 1: segment_size) = heat( 1: segment_size)

         heat( 1: segment_size) = ( heat( 0: segment_size - 1) + heat( 2: segment_size + 1)) * half

         delta = maxval( abs( old( 1: segment_size) - heat( 1: segment_size)))

         if( delta < tolerance ) exit local

      end do local

!  the local iteration is done

      if( me > lo_i ) event post( done[ me - 1])

      if( me < hi_i ) event post( done[ me + 1])

!  end segments have one neighbor, middle segments have two

      if( lo_i < me .and. me < hi_i )then

         event wait( done, until_count= 2)

      else

         event wait( done)

      end if

!  update left [ me - 1]

      left: if( me > lo_i )then

         heat( segment_size + 1)[ me - 1] = heat( 1)

         event post( update[ me - 1])

      end if left

!  update right [ me + 1]

      right: if( me < hi_i )then

         heat( 0)[ me + 1] = heat( segment_size)

         event post( update[ me + 1])

     end if right

!  end segments have one neighbor, middle segments have two

      if( lo_i < me .and. me < hi_i )then

         event wait( update, until_count= 2)

      else

         event wait( update)

      end if

!  find largest update

      delta_0 = abs( heat( 0) - old_0)
      delta_np1 = abs( heat( segment_size + 1) - old_np1)

      delta = max( delta_0, delta_np1)
      call co_max( delta)

      if( delta < tolerance ) exit parallel

   end do parallel

!  end of calculation so construct output file

   data_unit = 20 + me

   output_file = 'image6:8.out'

   write( output_file( 6:8), '( i3.3)') me

!  open, write, close

   open( unit= data_unit, file= output_file, status= 'replace')

   write( unit= data_unit, fmt= '( a, i0)') 'image ', me

   do i = 0, segment_size + 1

      write( unit= data_unit, fmt= '( en28.18)') heat( i)

   end do

   close( unit= data_unit, status= 'keep')

!  exit

stop 'normal exit in linear_heat'

! ----------------------------------------------------------------------

!  linear_heat

! $Id$
! **********************************************************************
! eof
end program linear_heat

