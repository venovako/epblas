!> \brief \b IHMAX2
!!
!  Definition:
!  ===========
!
!       INTEGER FUNCTION IHMAX2(N,CX,INCX)
!
!       .. Scalar Arguments ..
!       INTEGER INCX,N
!       ..
!       .. Array Arguments ..
!       COMPLEX CX(*)
!       ..
!
!
!> \par Purpose:
!  =============
!>
!> \verbatim
!>
!>    IHMAX2 finds the index of the first element having maximum absolute value.
!> \endverbatim
!
!  Arguments:
!  ==========
!
!> \param[in] N
!> \verbatim
!>          N is INTEGER
!>         number of elements in input vector(s)
!> \endverbatim
!>
!> \param[in] CX
!> \verbatim
!>          CX is COMPLEX array, dimension ( 1 + ( N - 1 )*abs( INCX ) )
!> \endverbatim
!>
!> \param[in] INCX
!> \verbatim
!>          INCX is INTEGER
!>         storage spacing between elements of CX
!> \endverbatim
!
!  Authors:
!  ========
!
!> \author venovako
!
!  =====================================================================
PURE FUNCTION IHMAX2(N, CX, INCX)
  IMPLICIT NONE
#ifdef PVN_CR_MATH
#if (BLAS_REAL_KIND == 4)
  INTERFACE
     PURE FUNCTION CR_HYPOTF(X, Y) BIND(C,NAME='cr_hypotf')
       IMPLICIT NONE
       REAL(KIND=BLAS_REAL_KIND), INTENT(IN), VALUE :: X, Y
       REAL(KIND=BLAS_REAL_KIND) :: CR_HYPOTF
     END FUNCTION CR_HYPOTF
  END INTERFACE
#define HYPOT CR_HYPOTF
#elif (BLAS_REAL_KIND == 8)
  INTERFACE
     PURE FUNCTION CR_HYPOTD(X, Y) BIND(C,NAME='cr_hypot')
       IMPLICIT NONE
       REAL(KIND=BLAS_REAL_KIND), INTENT(IN), VALUE :: X, Y
       REAL(KIND=BLAS_REAL_KIND) :: CR_HYPOTD
     END FUNCTION CR_HYPOTD
  END INTERFACE
#define HYPOT CR_HYPOTD
#elif (BLAS_REAL_KIND == 10)
  INTERFACE
     PURE FUNCTION CR_HYPOTL(X, Y) BIND(C,NAME='cr_hypotl')
       IMPLICIT NONE
       REAL(KIND=BLAS_REAL_KIND), INTENT(IN), VALUE :: X, Y
       REAL(KIND=BLAS_REAL_KIND) :: CR_HYPOTL
     END FUNCTION CR_HYPOTL
  END INTERFACE
#define HYPOT CR_HYPOTL
#elif (BLAS_REAL_KIND == 16)
#if (HAVE_FMA == 15)
#warning IEEE quad not yet available
#else
  INTERFACE
     PURE FUNCTION CR_HYPOTQ(X, Y) BIND(C,NAME='cr_hypotq')
       IMPLICIT NONE
       REAL(KIND=BLAS_REAL_KIND), INTENT(IN), VALUE :: X, Y
       REAL(KIND=BLAS_REAL_KIND) :: CR_HYPOTQ
     END FUNCTION CR_HYPOTQ
  END INTERFACE
#define HYPOT CR_HYPOTQ
#endif
#else
#error CR_HYPOT not defined
#endif
#endif
!
!     .. Scalar Arguments ..
  INTEGER, INTENT(IN) :: INCX, N
!     ..
!     .. Array Arguments ..
  COMPLEX(KIND=BLAS_REAL_KIND), INTENT(IN) :: CX(*)
!     ..
  INTEGER :: IHMAX2
!
!  =====================================================================
!
  REAL(KIND=BLAS_REAL_KIND), PARAMETER :: ZERO = 0.0, HALF = 0.5, ONE = 1.0
!     .. Local Scalars ..
  COMPLEX(KIND=BLAS_REAL_KIND) :: X
  REAL(KIND=BLAS_REAL_KIND) :: SMAX, SCLM, A, XR, XI
  INTEGER :: I, IX, L
!     ..
  IHMAX2 = 0
  IF (N .LE. 0) RETURN
  IHMAX2 = 1
  IF (N .EQ. 1) RETURN
  SMAX = ZERO
  SCLM = ONE
  L = 0
  IF (INCX .LT. 0) THEN
     IX = 1 + (1-N)*INCX
  ELSE
     IX = 1
  END IF
  DO I = 1, N
     X = CX(IX)
     XR = ABS(REAL(X))
     XI = ABS(AIMAG(X))
     IF (.NOT. (XR .LE. HUGE(XR))) THEN
        IHMAX2 = I
        RETURN
     END IF
     IF (.NOT. (XI .LE. HUGE(XI))) THEN
        IHMAX2 = I
        RETURN
     END IF
     IF (L .NE. 0) THEN
        XR = XR * SCLM
        XI = XI * SCLM
     END IF
     A = HYPOT(XR, XI)
     DO WHILE (.NOT. (A .LE. HUGE(A)))
        XR = XR * HALF
        XI = XI * HALF
        SCLM = SCLM * HALF
        SMAX = SMAX * HALF
        L = L + 1
        A = HYPOT(XR, XI)
     END DO
     IF (A .GT. SMAX) THEN
        IHMAX2 = I
        SMAX = A
     END IF
     IX = IX + INCX
  END DO
!
!     End of IHMAX2
!
END FUNCTION IHMAX2
