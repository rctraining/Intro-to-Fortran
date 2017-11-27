
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

! ----------------------------------------------------------------------

!  the traditional 'Hello, world!' first program
!  to compile
!  gfortran -std=f2008ts -Wall -fcheck=all -finit-real=nan Hello_World.f90 Personal_Library.o Speaker.o -o Hello_World
!  to execute
!  ./Hello_World

! ***********************************************************************

program hello_world

use, intrinsic :: iso_fortran_env, only: output_unit

use :: personal_library, only: write_identifier

use :: speaker, only: speaker_t

implicit none

! ----------------------------------------------------------------------

!  the object to speak the message

type( speaker_t) :: greeter

! ----------------------------------------------------------------------

continue

!  execute the procedure to write the identifying banner

   call write_identifier( '06-Hello_World')

!  writes the string to the output unit

   call greeter% speak()

! ----------------------------------------------------------------------

end program hello_world

! ***********************************************************************

