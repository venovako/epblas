!> \brief \b GLAMCH
!
!  =========== DOCUMENTATION ===========
!
! Online html documentation available at
!            http://www.netlib.org/lapack/explore-html/
!
!  Definition:
!  ===========
!
!      REAL             FUNCTION GLAMCH( CMACH )
!
!     .. Scalar Arguments ..
!      CHARACTER          CMACH
!     ..
!
!
!> \par Purpose:
!  =============
!>
!> \verbatim
!>
!> GLAMCH determines machine parameters.
!> \endverbatim
!
!  Arguments:
!  ==========
!
!> \param[in] CMACH
!> \verbatim
!>          CMACH is CHARACTER*1
!>          Specifies the value to be returned by GLAMCH:
!>          = 'E' or 'e',   GLAMCH := eps
!>          = 'S' or 's ,   GLAMCH := sfmin
!>          = 'B' or 'b',   GLAMCH := base
!>          = 'P' or 'p',   GLAMCH := eps*base
!>          = 'N' or 'n',   GLAMCH := t
!>          = 'R' or 'r',   GLAMCH := rnd
!>          = 'M' or 'm',   GLAMCH := emin
!>          = 'U' or 'u',   GLAMCH := rmin
!>          = 'L' or 'l',   GLAMCH := emax
!>          = 'O' or 'o',   GLAMCH := rmax
!>          where
!>          eps   = relative machine precision
!>          sfmin = safe minimum, such that 1/sfmin does not overflow
!>          base  = base of the machine
!>          prec  = eps*base
!>          t     = number of (base) digits in the mantissa
!>          rnd   = 1.0 when rounding occurs in addition, 0.0 otherwise
!>          emin  = minimum exponent before (gradual) underflow
!>          rmin  = underflow threshold - base**(emin-1)
!>          emax  = largest exponent before overflow
!>          rmax  = overflow threshold  - (base**emax)*(1-eps)
!> \endverbatim
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
!> \ingroup lamch
!
!  =====================================================================
PURE FUNCTION GLAMCH(CMACH)
  IMPLICIT NONE
  INTERFACE
     PURE FUNCTION LSAME(CA, CB)
       IMPLICIT NONE
       CHARACTER, INTENT(IN) :: CA, CB
       LOGICAL :: LSAME
     END FUNCTION LSAME
  END INTERFACE
!
!  -- LAPACK auxiliary routine --
!  -- LAPACK is a software package provided by Univ. of Tennessee,    --
!  -- Univ. of California Berkeley, Univ. of Colorado Denver and NAG Ltd..--
!
!     .. Scalar Arguments ..
  CHARACTER, INTENT(IN) :: CMACH
!     ..
!
! =====================================================================
  REAL(KIND=BLAS_REAL_KIND) :: GLAMCH
!     .. Parameters ..
  REAL(KIND=BLAS_REAL_KIND), PARAMETER :: ONE = 1.0, ZERO = 0.0, HALF = 0.5
!     ..
!     .. Local Scalars ..
  REAL(KIND=BLAS_REAL_KIND) :: RND, EPS, SFMIN, SMALL, HUGEVAL, RMACH
!     ..
!     .. Executable Statements ..
!
!     Assume rounding, not chopping. Always.
!
  RND = ONE
!
  IF (ONE .EQ. RND) THEN
     EPS = EPSILON(ZERO) * HALF
  ELSE
     EPS = EPSILON(ZERO)
  END IF
!
  IF (LSAME(CMACH, 'E')) THEN
     RMACH = EPS
  ELSE IF (LSAME(CMACH, 'S')) THEN
     SFMIN = TINY(ZERO)
     HUGEVAL = HUGE(ZERO)
     IF ((HUGEVAL * SFMIN) .LE. ONE) THEN
        SMALL = ONE / HUGEVAL
!
!           Use SMALL plus a bit, to avoid the possibility of rounding
!           causing overflow when computing  1/sfmin.
!
        SFMIN = SMALL * (ONE + EPS)
     END IF
     RMACH = SFMIN
  ELSE IF (LSAME(CMACH, 'B')) THEN
     RMACH = RADIX(ZERO)
  ELSE IF (LSAME(CMACH, 'P')) THEN
     RMACH = EPS * RADIX(ZERO)
  ELSE IF (LSAME(CMACH, 'N')) THEN
     RMACH = DIGITS(ZERO)
  ELSE IF (LSAME(CMACH, 'R')) THEN
     RMACH = RND
  ELSE IF (LSAME(CMACH, 'M')) THEN
     RMACH = MINEXPONENT(ZERO)
  ELSE IF (LSAME(CMACH, 'U')) THEN
     RMACH = TINY(ZERO)
  ELSE IF (LSAME(CMACH, 'L')) THEN
     RMACH = MAXEXPONENT(ZERO)
  ELSE IF (LSAME(CMACH, 'O')) THEN
     RMACH = HUGE(ZERO)
  ELSE
     RMACH = ZERO
  END IF
  GLAMCH = RMACH
!
!     End of GLAMCH
!
END FUNCTION GLAMCH
