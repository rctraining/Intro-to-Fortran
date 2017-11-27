
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

!  compiles with
!  gfortran -c -std=f2008 -Wall -fcheck=all -finit-real=nan Speaker.f90

! ***********************************************************************

!  names the module
!  it will be accessed via use :: speaker

module speaker

implicit none

private

! ----------------------------------------------------------------------

integer, parameter :: speak_len = 100

!  one who speaks a message

type, public :: speaker_t

   character( len= speak_len) :: message = 'Hello, world!'

contains

   procedure :: speak

end type speaker_t

! ----------------------------------------------------------------------

!  module procedures defined in submodules

interface

   module subroutine speak( s)

!  use class as the type of the pass object argument of the type-bound procedure

      class( speaker_t), intent( in) :: s

   end subroutine speak

end interface

! ----------------------------------------------------------------------

end module speaker

! ***********************************************************************

