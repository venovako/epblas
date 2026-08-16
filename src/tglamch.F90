!> \brief \b TGLAMCH
!
!  =========== DOCUMENTATION ===========
!
! Online html documentation available at
!            http://www.netlib.org/lapack/explore-html/
!
!
!  Authors:
!  ========
!
!> \author Univ. of Tennessee
!> \author Univ. of California Berkeley
!> \author Univ. of Colorado Denver
!> \author NAG Ltd.
!> \author modified by venovako
!
!> \ingroup auxOTHERcomputational
!
!  =====================================================================      PROGRAM TGLAMCH
!
!  -- LAPACK test routine --
!  -- LAPACK is a software package provided by Univ. of Tennessee,    --
!  -- Univ. of California Berkeley, Univ. of Colorado Denver and NAG Ltd..--
!
! =====================================================================
PROGRAM TGLAMCH
  USE, INTRINSIC :: ISO_FORTRAN_ENV, ONLY: OUTPUT_UNIT
  IMPLICIT NONE
!
!     .. Local Scalars ..
  REAL(KIND=BLAS_REAL_KIND) :: BASE, EMAX, EMIN, EPS, RMAX, RMIN, RND, SFMIN, T, PREC
!     ..
!     .. External Functions ..
  REAL(KIND=BLAS_REAL_KIND), EXTERNAL :: GLAMCH
!     ..
!     .. Executable Statements ..
!
  EPS   = GLAMCH('E')
  SFMIN = GLAMCH('S')
  BASE  = GLAMCH('B')
  PREC  = GLAMCH('P')
  T     = GLAMCH('N')
  RND   = GLAMCH('R')
  EMIN  = GLAMCH('M')
  RMIN  = GLAMCH('U')
  EMAX  = GLAMCH('L')
  RMAX  = GLAMCH('O')
!
  WRITE (OUTPUT_UNIT,*) ' Epsilon                      = ', EPS
  WRITE (OUTPUT_UNIT,*) ' Safe minimum                 = ', SFMIN
  WRITE (OUTPUT_UNIT,*) ' Base                         = ', BASE
  WRITE (OUTPUT_UNIT,*) ' Precision                    = ', PREC
  WRITE (OUTPUT_UNIT,*) ' Number of digits in mantissa = ', T
  WRITE (OUTPUT_UNIT,*) ' Rounding mode                = ', RND
  WRITE (OUTPUT_UNIT,*) ' Minimum exponent             = ', EMIN
  WRITE (OUTPUT_UNIT,*) ' Underflow threshold          = ', RMIN
  WRITE (OUTPUT_UNIT,*) ' Largest exponent             = ', EMAX
  WRITE (OUTPUT_UNIT,*) ' Overflow threshold           = ', RMAX
  WRITE (OUTPUT_UNIT,*) ' Reciprocal of safe minimum   = ', 1 / SFMIN
!
END PROGRAM TGLAMCH
