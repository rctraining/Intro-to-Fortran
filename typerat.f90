
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

! **********************************************************************
! a rational number is the ratio of two integers

! **********************************************************************
! use standard_types

! **********************************************************************

!  type_rational types

!     rational_t two int32 integers, numerator & denominator

!  type_rational operators

!     =

!     + unary rational_t
!     - negation

!     + binary compute rational_t
!     -
!     *
!     /

!     .eq. binary compare rational_t
!     .ne.
!     .lt.
!     .le.
!     .ge.
!     .gt.

!     .inverse. exchange numerator & denominator
!     .reduce. reduce to lowest terms

!  type_rational library

!     rat() from int

!     int() from rational_t
!     nint() from rational_t
!     real() from rational_t

!     ceiling()
!     floor()

!     sign() of a rational_t
!     abs()

!     epsilon() for type rational_t
!     huge()
!     tiny()

!     numerator() numerator
!     denominator() denominator

!     is_finite() true if ( x / y), y /= 0
!     is_infinity() true if ( x / 0), x /= 0
!     is_nan() true if ( 0 / 0)

!     inverse() exchange numerator & denominator
!     reduce() reduce to lowest terms

!     bit_size() extend bit_size() to type rational_t
!     swap() extend swap() to type rational_t

! **********************************************************************

!  type_rational

! **********************************************************************

module type_rational

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

!  type_rational rcs strings

character( len= *), public, parameter :: type_rational_rcs_id = &
   '$Id: typerat.fpp 1.3 2003/10/03 02:53:54Z Dan Release $'

integer, parameter :: int8 = selected_int_kind( r= 2)
integer, parameter :: int16 = selected_int_kind( r= 4)
integer, parameter :: int32 = selected_int_kind( r= 9)
integer, parameter :: int64 = selected_int_kind( r= 18)

integer, parameter :: real64 = selected_real_kind( p= 14)

! **********************************************************************

!  type_rational

type, public :: rational_t( r_k)

   integer, kind :: r_k = int32

   private

   integer( r_k) :: n
   integer( r_k) :: d

end type rational_t

! **********************************************************************

!  library

! **********************************************************************

!  assignment for type rational_t

public :: assignment( =)

interface assignment( =)
   module procedure rational_to_int
end interface

interface assignment( =)
   module procedure int_to_rational
end interface

! **********************************************************************

!  +, -, unary operators for rational_t

public :: operator( +)

interface operator( +)
   module procedure rational_plus
end interface

public :: operator( -)

interface operator( -)
   module procedure rational_minus
end interface

! **********************************************************************

!  +, -, *, / binary operators for rational_t

interface operator( +)
   module procedure rational_add
end interface

interface operator( -)
   module procedure rational_sub
end interface

public :: operator( *)

interface operator( *)
   module procedure rational_mul
end interface

public :: operator( /)

interface operator( /)
   module procedure rational_div
end interface

! **********************************************************************

!  ==, /=, <=, <, >, >= operators for rational_t

public :: operator( ==)

interface operator( ==)
   module procedure rational_eq
end interface

public :: operator ( /=)

interface operator( /=)
   module procedure rational_ne
end interface

public :: operator( <)

interface operator( <)
   module procedure rational_lt
end interface

public :: operator( <=)

interface operator( <=)
   module procedure rational_le
end interface

public :: operator( >=)

interface operator( >=)
   module procedure rational_ge
end interface

public :: operator( >)

interface operator( >)
   module procedure rational_gt
end interface

! **********************************************************************

!  rat() for type rational_t

public :: rat

interface rat
   module procedure int8_rat
   module procedure int16_rat
   module procedure int32_rat
   module procedure int64_rat
end interface

! **********************************************************************

!  int() for type rational_t

intrinsic :: int

public :: int

interface int
   module procedure rational_int
end interface

! **********************************************************************

!  nint() for type rational_t

intrinsic :: nint

public :: nint

interface nint
   module procedure rational_nint
end interface

! **********************************************************************

!  real() for type rational_t

intrinsic :: real

public :: real

interface real
   module procedure rational_real
end interface

! **********************************************************************

!  sign() for type rational_t

intrinsic :: sign

public :: sign

interface sign
   module procedure rational_sign
end interface

! **********************************************************************

!  abs() for type rational_t

intrinsic :: abs

public :: abs

interface abs
   module procedure rational_abs
end interface

! **********************************************************************

!  huge() for type rational_t

intrinsic :: huge

public :: huge

interface huge
   module procedure rational_huge
end interface

! **********************************************************************

!  tiny() for type rational_t

intrinsic :: tiny

public :: tiny

interface tiny
   module procedure rational_tiny
end interface

! **********************************************************************

!  epsilon() for type rational_t

intrinsic :: epsilon

public :: epsilon

interface epsilon
   module procedure rational_epsilon
end interface

! **********************************************************************

!  numerator() for type rational_t

public :: numerator

interface numerator
   module procedure rational_numerator
end interface

!  denominator() for type rational_t

public :: denominator

interface denominator
   module procedure rational_denominator
end interface

! **********************************************************************

!  is_finite() for type rational_t

public :: is_finite

interface is_finite
   module procedure rational_is_finite
end interface

! **********************************************************************

!  is_infinity() for type rational_t

public :: is_infinity

interface is_infinity
   module procedure rational_is_infinity
end interface

! **********************************************************************

!  is_nan() for type rational_t

public :: is_nan

interface is_nan
   module procedure rational_is_nan
end interface

! **********************************************************************

!  inverse() for type rational_t

public :: operator( .inverse.)

interface operator( .inverse.)
   module procedure rational_inverse
end interface

public :: inverse

interface inverse
   module procedure rational_inverse
end interface

! **********************************************************************

!  reduce() for type rational_t

public :: operator( .reduce.)

interface operator( .reduce.)
   module procedure rational_reduce
end interface

public :: reduce

interface reduce
   module procedure rational_reduce
end interface

! **********************************************************************

!  bit_size() for type rational_t

intrinsic :: bit_size

public :: bit_size

interface bit_size
   module procedure rational_bit_size
end interface

! **********************************************************************

!  swap() for type rational_t

public :: swap

interface swap
   module procedure rational_swap
end interface

interface

   pure function gcd( i, j) result( g)
      integer, intent( in) :: i, j
      integer :: g
   end function gcd

end interface

! **********************************************************************

!  module procedures

! **********************************************************************

contains

! **********************************************************************

!  rational_to_int(): assign i( 1: 2) = r

subroutine rational_to_int( b, a)

type( rational_t), intent( in) :: a

integer, dimension( 2), intent( out) :: b

!  rational_to_int()

continue

   b = (/ a% n, a% d /)

return

!  rational_to_int()

end subroutine rational_to_int

! ----------------------------------------------------------------------

!  int_to_rational(): assign r = i( 1: 2)

subroutine int_to_rational( b, a)

integer, dimension( 2), intent( in) :: a

type( rational_t), intent( out) :: b

!  int_to_rational()

continue

   b = rational_t( a( 1), a( 2) )

return

!  int_to_rational()

end subroutine int_to_rational

! **********************************************************************

!  rational_plus(): unary + rational

elemental type( rational_t) function rational_plus( a)

type( rational_t), intent( in) :: a

!  rational_plus()

continue

   rational_plus = rational_t( a% n, a% d)

return

!  rational_plus()

end function rational_plus

! ----------------------------------------------------------------------

!  rational_minus(): unary - rational

elemental type( rational_t) function rational_minus( a)

type( rational_t), intent( in) :: a

!  rational_minus()

continue

   rational_minus = rational_t( -a% n , a% d)

return

!  rational_minus()

end function rational_minus

! **********************************************************************

!  rational_add(): add two rationals

elemental type( rational_t) function rational_add( a, b)

type( rational_t), intent( in) :: a, b

!  rational_add()

continue

   rational_add = rational_t( ( a% n * b% d) + ( b% n * a% d), a% d * b% d)

return

!  rational_add()

end function rational_add

! ----------------------------------------------------------------------

!  rational_sub(): subtract two rationals

elemental type( rational_t) function rational_sub( a, b)

type( rational_t), intent( in) :: a, b

!  rational_sub()

continue

   rational_sub = rational_t( ( a% n * b% d) - ( b% n * a% d), a% d * b% d)

return

!  rational_sub()

end function rational_sub

! ----------------------------------------------------------------------

!  rational_mul(): multiply two rationals

elemental type( rational_t) function rational_mul( a, b)

type( rational_t), intent( in) :: a, b

!  rational_mul()

continue

   rational_mul = rational_t( a% n * b% n, a% d * b% d)

return

!  rational_mul()

end function rational_mul

! ----------------------------------------------------------------------

!  rational_div(): divide two rationals

elemental type( rational_t) function rational_div( a, b)

type( rational_t), intent( in) :: a, b

!  rational_div()

continue

   rational_div = rational_t( a% n * b% d, a% d * b% n)

return

!  rational_div()

end function rational_div

! **********************************************************************

!  rational_eq(): eq two rationals

elemental logical function rational_eq( a, b)

type( rational_t), intent( in) :: a, b

!  rational_eq() local

   type( rational_t) :: ra, rb

!  rational_eq()

continue

   ra = reduce( a)

   rb = reduce( b)

   rational_eq = ( ra% n == rb% n) .and. ( ra% d == rb% d)

return

!  rational_eq()

end function rational_eq

! ----------------------------------------------------------------------

!  rational_ne(): ne two rationals

elemental logical function rational_ne( a, b)

type( rational_t), intent( in) :: a, b

!  rational_ne() local

   type( rational_t) :: ra, rb

!  rational_ne()

continue

   ra = reduce( a)

   rb = reduce( b)

   rational_ne = ( ra% n /= rb% n) .or. ( ra% d /= rb% d)

return

!  rational_ne()

end function rational_ne

! ----------------------------------------------------------------------

!  rational_lt(): lt two rationals

elemental logical function rational_lt( a, b)

type( rational_t), intent( in) :: a, b

!  rational_lt()

continue

   rational_lt = sign( 1_int32, a - b) < 0

return

!  rational_lt()

end function rational_lt

! ----------------------------------------------------------------------

!  rational_le(): le two rationals

elemental logical function rational_le( a, b)

type( rational_t), intent( in) :: a, b

!  rational_le()

continue

   rational_le = sign( 1_int32, a - b) < 0 &
                 .or. a .eq. b

return

!  rational_le()

end function rational_le

! ----------------------------------------------------------------------

!  rational_ge(): ge two rationals

elemental logical function rational_ge( a, b)

type( rational_t), intent( in) :: a, b

!  rational_ge()

continue

   rational_ge = sign( 1_int32, a - b) > 0 &
                 .or. a .eq. b

return

!  rational_ge()

end function rational_ge

! ----------------------------------------------------------------------

!  rational_gt(): gt two rationals

elemental logical function rational_gt( a, b)

type( rational_t), intent( in) :: a, b

!  rational_gt()

continue

   rational_gt = sign( 1_int32, a - b) > 0

return

!  rational_gt()

end function rational_gt

! **********************************************************************

!  int8_rat(): rational_t from integer

elemental type( rational_t) function int8_rat( i, j)

integer( kind= int8), intent( in) :: i

integer( kind= int8), optional, intent( in) :: j

!  int8_rat()

continue

   number_of_args: if( present( j) )then

      int8_rat = rational_t( int( i, kind= int32), int( j, kind= int32))

   else number_of_args

      int8_rat = rational_t( int( i, kind= int32), 1_int32)

   endif number_of_args

return

!  int8_rat()

end function int8_rat

! **********************************************************************

!  int16_rat(): rational_t from integer

elemental type( rational_t) function int16_rat( i, j)

integer( kind= int16), intent( in) :: i

integer( kind= int16), optional, intent( in) :: j

!  int16_rat()

continue

   number_of_args: if( present( j) )then

      int16_rat = rational_t( int( i, kind= int32), int( j, kind= int32))

   else number_of_args

      int16_rat = rational_t( int( i, kind= int32), 1_int32)

   endif number_of_args

return

!  int16_rat()

end function int16_rat

! **********************************************************************

!  int32_rat(): rational_t from integer

elemental type( rational_t) function int32_rat( i, j)

integer( kind= int32), intent( in) :: i

integer( kind= int32), optional, intent( in) :: j

!  int32_rat()

continue

   number_of_args: if( present( j) )then

      int32_rat = rational_t( int( i, kind= int32), int( j, kind= int32))

   else number_of_args

      int32_rat = rational_t( int( i, kind= int32), 1_int32)

   endif number_of_args

return

!  int32_rat()

end function int32_rat

! **********************************************************************

!  int64_rat(): rational_t from integer

elemental type( rational_t) function int64_rat( i, j)

integer( kind= int64), intent( in) :: i

integer( kind= int64), optional, intent( in) :: j

!  int64_rat()

continue

   number_of_args: if( present( j) )then

      int64_rat = rational_t( int( i, kind= int32), int( j, kind= int32))

   else number_of_args

      int64_rat = rational_t( int( i, kind= int32), 1_int32)

   endif number_of_args

return

!  int64_rat()

end function int64_rat

! **********************************************************************

!  rational_int(): integer from rational_t

elemental integer( kind= int32) function rational_int( r)

type( rational_t), intent( in) :: r

!  rational_int()

continue

   rational_int = int( real( r% n, kind= real64) / real( r% d, kind= real64) )

return

!  rational_int()

end function rational_int

! ----------------------------------------------------------------------

!  rational_nint(): integer from rational_t

elemental integer( kind= int32) function rational_nint( r)

type( rational_t), intent( in) :: r

!  rational_nint()

continue

   rational_nint = nint( real( r% n, kind= real64) / real( r% d, kind= real64) )

return

!  rational_nint()

end function rational_nint

! ----------------------------------------------------------------------

!  rational_real(): integer from rational_t

elemental real( kind= real64) function rational_real( r)

type( rational_t), intent( in) :: r

!  rational_real()

continue

   rational_real = real( r% n, kind= real64) / real( r% d, kind= real64)

return

!  rational_real()

end function rational_real

! **********************************************************************

!  rational_sign(): integer from rational_t

elemental integer function rational_sign( i, r)

integer, intent( in) :: i

type( rational_t), intent( in) :: r

!  rational_sign()

continue

   plus_minus: if( sign( 1, r% n) * sign( 1, r% d) > 0 )then

      rational_sign = abs( i)

   else plus_minus

      rational_sign = -abs( i)

   endif plus_minus

return

!  rational_sign()

end function rational_sign

! **********************************************************************

!  rational_abs(): extend abs() to type rational

elemental type( rational_t) function rational_abs( r)

type( rational_t), intent( in) :: r

!  rational_abs()

continue

   rational_abs = rational_t( abs( r% n), abs( r% d))

return

!  rational_abs()

end function rational_abs

! **********************************************************************

!  rational_huge(): integer from rational_t

elemental type( rational_t) function rational_huge( r)

type( rational_t), intent( in) :: r

!  rational_huge()

continue

   rational_huge = rational_t( huge( 0), 1)

return

!  rational_huge()

end function rational_huge

! **********************************************************************

!  rational_tiny(): extend tiny() to type rational

elemental type( rational_t) function rational_tiny( r)

type( rational_t), intent( in) :: r

!  rational_tiny()

continue

   rational_tiny = rational_t( 1, huge( 0))

return

!  rational_tiny()

end function rational_tiny

! **********************************************************************

!  rational_epsilon(): extend epsilon() to type rational

elemental type( rational_t) function rational_epsilon( r)

type( rational_t), intent( in) :: r

!  rational_epsilon()

continue

   rational_epsilon = rational_t( 1, ( huge( 0) - 1))

return

!  rational_epsilon()

end function rational_epsilon

! **********************************************************************

!  rational_numerator(): return numerator

elemental integer( kind= int32) function rational_numerator( r)

type( rational_t), intent( in) :: r

!  rational_numerator()

continue

   rational_numerator = r% n

return

!  rational_numerator()

end function rational_numerator

! **********************************************************************

!  rational_denominator(): return denominator

elemental integer( kind= int32) function rational_denominator( r)

type( rational_t), intent( in) :: r

!  rational_denominator()

continue

   rational_denominator = r% d

return

!  rational_denominator()

end function rational_denominator

! **********************************************************************

!  rational_is_finite(): true if its argument is x/0, x/=0

elemental logical function rational_is_finite( r)

type( rational_t), intent( in) :: r

!  rational_is_finite()

continue

   rational_is_finite = r% d /= 0

return

!  rational_is_finite()

end function rational_is_finite

! **********************************************************************

!  rational_is_infinity(): true if its argument is x/0, x/=0

elemental logical function rational_is_infinity( r)

type( rational_t), intent( in) :: r

!  rational_is_infinity()

continue

   rational_is_infinity = ( r% n /= 0) .and. ( r% d == 0)

return

!  rational_is_infinity()

end function rational_is_infinity

! **********************************************************************

!  rational_is_nan(): true if its argument is 0/0

elemental logical function rational_is_nan( r)

type( rational_t), intent( in) :: r

!  rational_is_nan()

continue

   rational_is_nan = ( r% n == 0) .and. ( r% d == 0)

return

!  rational_is_nan()

end function rational_is_nan

! **********************************************************************

!  rational_inverse(): extend inverse() to type rational

elemental type( rational_t) function rational_inverse( r)

type( rational_t), intent( in) :: r

!  rational_inverse()

continue

   rational_inverse = rational_t( r% d, r% n)

return

!  rational_inverse()

end function rational_inverse

! **********************************************************************

!  rational_reduce(): extend reduce() to type rational

elemental type( rational_t) function rational_reduce( r)

type( rational_t), intent( in) :: r

!  rational_reduce() local

   integer( kind= int32) :: div

!  rational_reduce()

continue

   div = gcd( r% n, r% d)

   rational_reduce = rational_t( r% n / div, r% d / div)

return

!  rational_reduce()

end function rational_reduce

! **********************************************************************

!  rational_bit_size(): extend bit_size() to type rational

elemental integer function rational_bit_size( r)

type( rational_t), intent( in) :: r

!  rational_bit_size()

continue

   rational_bit_size = bit_size( r% n) + bit_size( r% d)

return

!  rational_bit_size()

end function rational_bit_size

! **********************************************************************

!  rational_swap(): extend swap() to type rational

elemental subroutine rational_swap( a, b)

type( rational_t), intent( inout) :: a, b

!  rational_swap() local

   type( rational_t) :: t1, t2

!  rational_swap()

continue

   t1 = a

   t2 = b

   b = t1

   a = t2

return

!  rational_swap()

end subroutine rational_swap

! **********************************************************************

!  type_rational

! $Id: typerat.fpp 1.3 2003/10/03 02:53:54Z Dan Release $
! **********************************************************************

end module type_rational
