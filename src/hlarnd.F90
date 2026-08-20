!> \brief \b HLARND
!
!  =========== DOCUMENTATION ===========
!
! Online html documentation available at
!            http://www.netlib.org/lapack/explore-html/
!
!  Definition:
!  ===========
!
!       COMPLEX FUNCTION HLARND( IDIST, ISEED )
!
!       .. Scalar Arguments ..
!       INTEGER            IDIST
!       ..
!       .. Array Arguments ..
!       INTEGER            ISEED( 4 )
!       ..
!
!
!> \par Purpose:
!  =============
!>
!> \verbatim
!>
!> HLARND returns a random complex number from a uniform or normal
!> distribution.
!> \endverbatim
!
!  Arguments:
!  ==========
!
!> \param[in] IDIST
!> \verbatim
!>          IDIST is INTEGER
!>          Specifies the distribution of the random numbers:
!>          = 1:  real and imaginary parts each uniform (0,1)
!>          = 2:  real and imaginary parts each uniform (-1,1)
!>          = 3:  real and imaginary parts each normal (0,1)
!>          = 4:  uniformly distributed on the disc abs(z) <= 1
!>          = 5:  uniformly distributed on the circle abs(z) = 1
!> \endverbatim
!>
!> \param[in,out] ISEED
!> \verbatim
!>          ISEED is INTEGER array, dimension (4)
!>          On entry, the seed of the random number generator; the array
!>          elements must be between 0 and 4095, and ISEED(4) must be
!>          odd.
!>          On exit, the seed is updated.
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
!> \ingroup complex_matgen
!
!> \par Further Details:
!  =====================
!>
!> \verbatim
!>
!>  This routine calls the auxiliary routine SLARAN to generate a random
!>  real number from a uniform (0,1) distribution. The Box-Muller method
!>  is used to transform numbers from a uniform to a normal distribution.
!> \endverbatim
!>
!  =====================================================================
FUNCTION HLARND(IDIST, ISEED)
  IMPLICIT NONE
!
!  -- LAPACK auxiliary routine --
!  -- LAPACK is a software package provided by Univ. of Tennessee,    --
!  -- Univ. of California Berkeley, Univ. of Colorado Denver and NAG Ltd..--
!
!     .. Scalar Arguments ..
  INTEGER, INTENT(IN) :: IDIST
!     ..
!     .. Array Arguments ..
  INTEGER, INTENT(INOUT) :: ISEED(4)
!     ..
!
!  =====================================================================
  COMPLEX(KIND=BLAS_REAL_KIND) :: HLARND
!
!     .. Parameters ..
  REAL(KIND=BLAS_REAL_KIND), PARAMETER :: ZERO = 0.0, ONE = 1.0, TWO = 2.0, TWOPI = 6.28318530717958647692528676655900576839
!     ..
!     .. Local Scalars ..
  REAL(KIND=BLAS_REAL_KIND) :: T1, T2
!     ..
!     .. External Functions ..
  REAL(KIND=BLAS_REAL_KIND), EXTERNAL :: GLARAN
!     ..
!     .. Executable Statements ..
!
!     Generate a pair of real random numbers from a uniform (0,1)
!     distribution
!
  T1 = GLARAN(ISEED)
  T2 = GLARAN(ISEED)
!
  IF (IDIST .EQ. 1) THEN
!
!        real and imaginary parts each uniform (0,1)
!
     HLARND = CMPLX(T1, T2)
  ELSE IF (IDIST .EQ. 2) THEN
!
!        real and imaginary parts each uniform (-1,1)
!
     HLARND = CMPLX(TWO*T1 - ONE, TWO*T2 - ONE)
  ELSE IF (IDIST .EQ. 3) THEN
!
!        real and imaginary parts each normal (0,1)
!
     T1 = SQRT(-TWO * LOG(T1))
     T2 = TWO * T2
     HLARND = CMPLX(T1 * COSPI(T2), T1 * SINPI(T2), BLAS_REAL_KIND)
  ELSE IF (IDIST .EQ. 4) THEN
!
!        uniform distribution on the unit disc abs(z) <= 1
!
     T1 = SQRT(T1)
     T2 = TWO * T2
     HLARND = CMPLX(T1 * COSPI(T2), T1 * SINPI(T2), BLAS_REAL_KIND)
  ELSE IF (IDIST .EQ. 5) THEN
!
!        uniform distribution on the unit circle abs(z) = 1
!
     T2 = TWO * T2
     HLARND = CMPLX(COSPI(T2), SINPI(T2), BLAS_REAL_KIND)
  END IF
!
!     End of HLARND
!
END FUNCTION HLARND
