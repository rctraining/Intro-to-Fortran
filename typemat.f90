! bof
! **********************************************************************
!  copyright 2013 Dan Nagle

!   This library is free software; you can redistribute it and/or
!   modify it under the terms of the GNU General Public
!   License as published by the Free Software Foundation; either
!   version 3 of the License, or (at your option) any later version.

!   This library is distributed in the hope that it will be useful,
!   but WITHOUT ANY WARRANTY; without even the implied warranty of
!   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
!   Library General Public License for more details.

!   You should have received a copy of the GNU Library General Public
!   License along with this library; if not, write to the Free
!   Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

! To report bugs, suggest enhancements, etc. to the Authors,
! Contact:
!    Purple Sage Computing Solutions, Inc.
!                               send email to dannagle@verizon.net
!                                  or mail to 731 Spruce St.
!                                             Boulder CO 80302 USA

! **********************************************************************
! Fortran module type_matrix

! **********************************************************************
! a matrix that always has the correct dimensions

! **********************************************************************
! use iso_fortran_env

! **********************************************************************

!  type_matrix types

!     matrix_t a matrix with self-adjusting dimensions


! **********************************************************************

!  type_matrix

! **********************************************************************

module type_matrix

! **********************************************************************

!  description of processor

!use, intrinsic :: iso_fortran_env

! **********************************************************************

!  declare all variables

implicit none

! **********************************************************************

!  declare all exports

private

! **********************************************************************

!  type_matrix rcs strings

character( len= *), public, parameter :: type_matrix_rcs_id = &
   '$Id: typemat.fpp 1.3 2003/10/03 02:53:54Z Dan Release $'

integer, parameter :: real64 = selected_real_kind( p= 14)

! **********************************************************************

!  type_matrix

type, public :: matrix_t( r_l, c_l)

   integer, len :: r_l = 1
   integer, len :: c_l = 1

   private

   real( real64), dimension( r_l, c_l) :: elements

end type matrix_t

! **********************************************************************

!  library

! **********************************************************************

!  overload matmul for type matrix_t

intrinsic :: matmul

public :: matmul

interface matmul
   module procedure matmul
end interface

! **********************************************************************

!  module procedures

! **********************************************************************

contains

! **********************************************************************

! ----------------------------------------------------------------------

!  matmul(): multiply two matrixs

function matmul( a, b) result( mxm)

type( matrix_t) :: mxm

type( matrix_t), intent( in out) :: a, b

!  local data

   real( real64), dimension( :, :), allocatable :: tmp

!  matmul()

continue

   if( a% c_l < b% r_l )then

      allocate( tmp( a% r_l, b% r_l) )

      tmp( 1: a% r_l, 1: a% c_l) = a% elements

      tmp( 1: a% r_l, a% c_l + 1: ) = 0.0_real64

      mxm% elements = matmul( tmp, ( b% elements))

   else if( a% c_l > b% r_l )then

      allocate( tmp( a% c_l, b% c_l) )

      tmp( 1: b% r_l, 1: b% c_l) = b% elements

      tmp( 1: b% r_l + 1, 1: b% c_l ) = 0.0_real64

      mxm% elements = matmul( ( a% elements), tmp)

   end if

   mxm% r_l = a% r_l
   mxm% c_l = b% c_l

return

!  matmul()

end function matmul

! **********************************************************************

!  type_matrix

! $Id: typerat.fpp 1.3 2003/10/03 02:53:54Z Dan Release $
! **********************************************************************

end module type_matrix
