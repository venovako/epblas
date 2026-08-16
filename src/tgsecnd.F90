!> \brief \b TGSECND
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
!> \ingroup test_second
!
!  =====================================================================
PROGRAM TGSECND
#ifdef USE_IEEE_INTRINSIC
  USE, INTRINSIC :: IEEE_ARITHMETIC, ONLY: IEEE_FMA
#define GFMA IEEE_FMA
#endif
  USE, INTRINSIC :: ISO_FORTRAN_ENV, ONLY: OUTPUT_UNIT
  IMPLICIT NONE
#ifndef USE_IEEE_INTRINSIC
#if ((BLAS_REAL_KIND == 4) && ((HAVE_FMA & 1) == 0))
  INTERFACE
     PURE FUNCTION GFMA(A, B, C) BIND(C,NAME='fmaf')
       IMPLICIT NONE
       REAL(KIND=BLAS_REAL_KIND), INTENT(IN), VALUE :: A, B, C
       REAL(KIND=BLAS_REAL_KIND) :: GFMA
     END FUNCTION GFMA
  END INTERFACE
#elif ((BLAS_REAL_KIND == 8) && ((HAVE_FMA & 2) == 0))
  INTERFACE
     PURE FUNCTION GFMA(A, B, C) BIND(C,NAME='fma')
       IMPLICIT NONE
       REAL(KIND=BLAS_REAL_KIND), INTENT(IN), VALUE :: A, B, C
       REAL(KIND=BLAS_REAL_KIND) :: GFMA
     END FUNCTION GFMA
  END INTERFACE
#elif ((BLAS_REAL_KIND == 10) && ((HAVE_FMA & 4) == 0))
  INTERFACE
     PURE FUNCTION GFMA(A, B, C) BIND(C,NAME='fmal')
       IMPLICIT NONE
       REAL(KIND=BLAS_REAL_KIND), INTENT(IN), VALUE :: A, B, C
       REAL(KIND=BLAS_REAL_KIND) :: GFMA
     END FUNCTION GFMA
  END INTERFACE
#elif ((BLAS_REAL_KIND == 16) && ((HAVE_FMA & 8) == 0))
  INTERFACE
#ifdef __GFORTRAN__
     PURE FUNCTION GFMA(A, B, C) BIND(C,NAME='fmaq')
#else
     PURE FUNCTION GFMA(A, B, C) BIND(C,NAME='__fmaq')
#endif
       IMPLICIT NONE
       REAL(KIND=BLAS_REAL_KIND), INTENT(IN), VALUE :: A, B, C
       REAL(KIND=BLAS_REAL_KIND) :: GFMA
     END FUNCTION GFMA
  END INTERFACE
#else
#define GFMA(A,B,C) ((A)*(B)+(C))
#endif
#endif
!
!  -- LAPACK test routine --
!
!  -- LAPACK computational routine --
!  -- LAPACK is a software package provided by Univ. of Tennessee,    --
!  -- Univ. of California Berkeley, Univ. of Colorado Denver and NAG Ltd..--
!
! =====================================================================
!
!     .. Parameters ..
  INTEGER, PARAMETER :: NMAX = 100000, ITS = 50000, KILO = 1000, MEGA = 1000000
  REAL(KIND=BLAS_REAL_KIND), PARAMETER :: ZERO = 0.0, A = 0.315
!     ..
!     .. Local Scalars ..
  INTEGER :: I, J
  REAL(KIND=BLAS_REAL_KIND) :: ALPHA, AVG, T1, T2, TNOSEC, TOTAL
!     ..
!     .. Arrays ..
  REAL(KIND=BLAS_REAL_KIND), SAVE :: X(NMAX), Y(NMAX)
!     ..
!     .. External Functions ..
  REAL(KIND=BLAS_REAL_KIND), EXTERNAL :: GSECND
!     ..
!     .. Executable Statements ..
!
!    .. Figure TOTAL flops ..
  AVG = REAL(ITS, BLAS_REAL_KIND)
  TOTAL = REAL(NMAX, BLAS_REAL_KIND) * AVG
#ifndef USE_IEEE_INTRINSIC
#if ((BLAS_REAL_KIND == 10) && defined(GFMA))
  TOTAL = TOTAL + TOTAL
#endif
#endif
!
!     Initialize X and Y
!
  DO I = 1, NMAX
     X(I) = REAL(1, BLAS_REAL_KIND) / REAL(I, BLAS_REAL_KIND)
     Y(I) = REAL((NMAX - I), BLAS_REAL_KIND) / REAL(NMAX, BLAS_REAL_KIND)
  END DO
  ALPHA = A
!
!     Time TOTAL GAXPY operations
!
  T1 = GSECND()
  DO J = 1, ITS
     DO I = 1, NMAX
        Y(I) = GFMA(ALPHA, X(I), Y(I))
     END DO
     ALPHA = -ALPHA
  END DO
  T2 = GSECND()
  TNOSEC = T2 - T1
  WRITE (OUTPUT_UNIT, 9999) TOTAL, TNOSEC
  IF (TNOSEC .GT. ZERO) THEN
     WRITE (OUTPUT_UNIT, 9998) (TOTAL / MEGA) / TNOSEC
  ELSE
     WRITE (OUTPUT_UNIT, 9994)
  END IF
!
!     Time TOTAL GAXPY operations with GSECND in the outer loop
!
  T1 = GSECND()
  DO J = 1, ITS
     DO I = 1, NMAX
        Y(I) = GFMA(ALPHA, X(I), Y(I))
     END DO
     ALPHA = -ALPHA
     T2 = GSECND()
  END DO
!
!     Compute the time used in milliseconds used by an average call
!     to GSECND.
!
  ALPHA = T2 - T1
  WRITE (OUTPUT_UNIT, 9997) ALPHA
  AVG = (ALPHA - TNOSEC) * KILO / AVG
  IF (AVG .GT. ZERO) WRITE (OUTPUT_UNIT, 9996) AVG
!
!     Compute the equivalent number of floating point operations used
!     by an average call to GSECND.
!
  IF ((AVG .GT. ZERO) .AND. (TNOSEC .GT. ZERO)) WRITE (OUTPUT_UNIT, 9995) (AVG / KILO) * TOTAL / TNOSEC
!
 9999 FORMAT(' Time for ',G10.3, ' GAXPY ops = ', G10.3, ' seconds')
 9998 FORMAT(' GAXPY performance rate        = ', G10.3, ' mflops')
 9997 FORMAT(' Including GSECND, time        = ', G10.3, ' seconds')
 9996 FORMAT(' Average time for GSECND       = ', G10.3, ' milliseconds')
 9995 FORMAT(' Equivalent floating point ops = ', G10.3, ' ops')
 9994 FORMAT(' *** Warning: Time for operations was less or equal than zero => timing in TESTING might be dubious')
END PROGRAM TGSECND
