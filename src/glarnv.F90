!> \brief \b GLARNV returns a vector of random numbers from a uniform or normal distribution.
!
!  =========== DOCUMENTATION ===========
!
! Online html documentation available at
!            http://www.netlib.org/lapack/explore-html/
!
!> Download GLARNV + dependencies
!> <a href="http://www.netlib.org/cgi-bin/netlibfiles.tgz?format=tgz&filename=/lapack/lapack_routine/slarnv.f">
!> [TGZ]</a>
!> <a href="http://www.netlib.org/cgi-bin/netlibfiles.zip?format=zip&filename=/lapack/lapack_routine/slarnv.f">
!> [ZIP]</a>
!> <a href="http://www.netlib.org/cgi-bin/netlibfiles.txt?format=txt&filename=/lapack/lapack_routine/slarnv.f">
!> [TXT]</a>
!
!  Definition:
!  ===========
!
!       SUBROUTINE GLARNV( IDIST, ISEED, N, X )
!
!       .. Scalar Arguments ..
!       INTEGER            IDIST, N
!       ..
!       .. Array Arguments ..
!       INTEGER            ISEED( 4 )
!       REAL               X( * )
!       ..
!
!
!> \par Purpose:
!  =============
!>
!> \verbatim
!>
!> GLARNV returns a vector of n random real numbers from a uniform or
!> normal distribution.
!> \endverbatim
!
!  Arguments:
!  ==========
!
!> \param[in] IDIST
!> \verbatim
!>          IDIST is INTEGER
!>          Specifies the distribution of the random numbers:
!>          = 1:  uniform (0,1)
!>          = 2:  uniform (-1,1)
!>          = 3:  normal (0,1)
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
!>
!> \param[in] N
!> \verbatim
!>          N is INTEGER
!>          The number of random numbers to be generated.
!> \endverbatim
!>
!> \param[out] X
!> \verbatim
!>          X is REAL array, dimension (N)
!>          The generated random numbers.
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
!> \ingroup larnv
!
!> \par Further Details:
!  =====================
!>
!> \verbatim
!>
!>  This routine calls the auxiliary routine GLARUV to generate random
!>  real numbers from a uniform (0,1) distribution, in batches of up to
!>  128 using vectorisable code. The Box-Muller method is used to
!>  transform numbers from a uniform to a normal distribution.
!> \endverbatim
!>
!  =====================================================================
PURE SUBROUTINE GLARNV(IDIST, ISEED, N, X)
  IMPLICIT NONE
#ifdef PVN_CR_MATH
#if ((BLAS_REAL_KIND == 16) && (HAVE_FMA < 11))
  INTERFACE
     PURE FUNCTION CR_SQRTQ(X) BIND(C,NAME='cr_sqrtq')
       IMPLICIT NONE
       REAL(KIND=BLAS_REAL_KIND), INTENT(IN), VALUE :: X
       REAL(KIND=BLAS_REAL_KIND) :: CR_SQRTQ
     END FUNCTION CR_SQRTQ
  END INTERFACE
#define SQRT CR_SQRTQ
#endif
#endif
  INTERFACE
     PURE SUBROUTINE GLARUV(ISEED, N, X)
       IMPLICIT NONE
       INTEGER, INTENT(INOUT) :: ISEED(4)
       INTEGER, INTENT(IN) :: N
       REAL(KIND=BLAS_REAL_KIND), INTENT(OUT) :: X(N)
     END SUBROUTINE GLARUV
  END INTERFACE
!
!  -- LAPACK auxiliary routine --
!  -- LAPACK is a software package provided by Univ. of Tennessee,    --
!  -- Univ. of California Berkeley, Univ. of Colorado Denver and NAG Ltd..--
!
!     .. Scalar Arguments ..
  INTEGER, INTENT(IN) :: IDIST, N
!     ..
!     .. Array Arguments ..
  INTEGER, INTENT(INOUT) :: ISEED(4)
  REAL(KIND=BLAS_REAL_KIND), INTENT(OUT) :: X(*)
!     ..
!
!  =====================================================================
!
!     .. Parameters ..
  REAL(KIND=BLAS_REAL_KIND), PARAMETER :: ZERO = 0.0, ONE = 1.0, TWO = 2.0, MTWO = -2.0
  INTEGER, PARAMETER :: LV = 128
#ifdef __NVCOMPILER
  REAL(KIND=BLAS_REAL_KIND), PARAMETER :: TWOPI = 6.28318530717958647692528676655900576839
#endif
!     ..
!     .. Local Scalars ..
  INTEGER :: I, IL, IL2, IV
!     ..
!     .. Local Arrays ..
  REAL(KIND=BLAS_REAL_KIND) :: U(LV)
!     ..
!     .. Executable Statements ..
!
  DO IV = 1, N, LV/2
     IL = MIN(LV/2, N-IV+1)
     IF (IDIST .EQ. 3) THEN
        IL2 = 2*IL
     ELSE
        IL2 = IL
     END IF
!
!        Call GLARUV to generate IL2 numbers from a uniform (0,1)
!        distribution (IL2 <= LV)
!
     CALL GLARUV(ISEED, IL2, U)
!
     IF (IDIST .EQ. 1) THEN
!
!           Copy generated numbers
!
        DO I = 1, IL
           X(IV+I-1) = U(I)
        END DO
     ELSE IF (IDIST .EQ. 2) THEN
!
!           Convert generated numbers to uniform (-1,1) distribution
!
        DO I = 1, IL
           X(IV+I-1) = TWO*U(I) - ONE
        END DO
     ELSE IF (IDIST .EQ. 3) THEN
!
!           Convert generated numbers to normal (0,1) distribution
!
        DO I = 1, IL
#ifdef __NVCOMPILER
           X(IV+I-1) = COS(TWOPI * U(2*I))
#else
           X(IV+I-1) = COSPI(TWO * U(2*I))
#endif
           X(IV+I-1) = SQRT(MTWO * LOG(U(2*I-1))) * X(IV+I-1)
        END DO
     ELSE ! ERROR
        DO I = 1, IL
           X(IV+I-1) = ZERO
        END DO
     END IF
  END DO
!
!     End of GLARNV
!
END SUBROUTINE GLARNV
