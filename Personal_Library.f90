
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
!  gfortran -c -std=f2008ts -Wall -fcheck=all -finit-real=nan personal_library.f90

! ***********************************************************************

module personal_library

implicit none

private

public :: write_identifier

! ----------------------------------------------------------------------

character( len= *), parameter :: string_fmt = '( a)'

! ----------------------------------------------------------------------

!  module procedures defined in submodules

interface

   module subroutine write_identifier( identifier, unit)

!  string containing the identifier

      character( len= *), intent( in) :: identifier

!  optional unit to receive banner

      integer, intent( in), optional :: unit

   end subroutine write_identifier

end interface

! ----------------------------------------------------------------------

end module personal_library

! ***********************************************************************

