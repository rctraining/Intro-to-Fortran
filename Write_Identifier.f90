
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

!  to compile
!  gfortran -c -std=f2008ts -Wall -fcheck=all -finit-real=nan Write_Identifier.f90

! ***********************************************************************

!  this submodule implements the write_identifier procedure

submodule( personal_library) implement_write_identifier

implicit none

! ----------------------------------------------------------------------

contains

! ----------------------------------------------------------------------

!  implement write_banner

module subroutine write_identifier( identifier, unit)

use, intrinsic :: iso_fortran_env, only: error_unit, compiler_version, compiler_options

! ----------------------------------------------------------------------

!  string containing the identifier

character( len= *), intent( in) :: identifier

!  unit to receive banner

integer, intent( in), optional :: unit

! ----------------------------------------------------------------------

!  the unit to receive the identifier

   integer :: u

!  date and time strings from intrinsic procedure

   character( len= 8) :: date
   character( len= 10) :: time

!  character variable to hold assembled date and time plus six more characters

   character( len= len( date) + len( time) + 6) :: now

! ----------------------------------------------------------------------

continue

!  use unit if present on the call statement otherwise use stderr

   if( present( unit) )then
      u = unit
   else
      u = error_unit
   end if

!  get the date and time strings

   call date_and_time( date= date, time= time)

!  define now with the formatted date and time value

   now = ' ' // date( 1: 4) // '/' // date( 5: 6) // '/' // date( 7: 8) &
      // ' ' // time( 1: 2) // ':' // time( 3: 4) // ':' // time( 5: 10)

!  write the identifier date and time of execution

   write( unit= u, fmt= string_fmt) identifier // now

!  write the compiler used to compile this executable

   write( unit= u, fmt= string_fmt) compiler_version()

!  write the compiler options used to compile this executable

   write( unit= u, fmt= string_fmt) compiler_options()

return

! ----------------------------------------------------------------------

end subroutine write_identifier

! ----------------------------------------------------------------------

end submodule implement_write_identifier

! ***********************************************************************

