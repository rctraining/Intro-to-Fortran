
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
!  gfortran -c -std=f2008ts -Wall -fcheck=all -finit-real=nan Speak.f90

! ***********************************************************************

!  this submodule implements the write_identifier procedure

submodule( speaker) implement_speak

implicit none

! ----------------------------------------------------------------------

contains

! ----------------------------------------------------------------------

!  implement write_banner

module subroutine speak( s)

use, intrinsic :: iso_fortran_env, only: output_unit

! ----------------------------------------------------------------------

!  object containing the message to be written

class( speaker_t), intent( in) :: s

! ----------------------------------------------------------------------

continue

!  write the message sans any trailing blanks

   write( unit= output_unit, fmt= '( a)') trim( s% message)

return

! ----------------------------------------------------------------------

end subroutine speak

! ----------------------------------------------------------------------

end submodule implement_speak

! ***********************************************************************

