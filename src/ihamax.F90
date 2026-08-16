!> \brief \b IHAMAX
!
!  =========== DOCUMENTATION ===========
!
! Online html documentation available at
!            http://www.netlib.org/lapack/explore-html/
!
!  Definition:
!  ===========
!
!       INTEGER FUNCTION IHAMAX(N,CX,INCX)
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
!>    IHAMAX finds the index of the first element having maximum absolute value.
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
!> \author Univ. of Tennessee
!> \author Univ. of California Berkeley
!> \author Univ. of Colorado Denver
!> \author NAG Ltd.
!> \author modified by venovako
!
!> \ingroup iamax
!
!> \par Further Details:
!  =====================
!>
!> \verbatim
!>
!>     jack dongarra, linpack, 3/11/78.
!>     modified 12/3/93, array(1) declarations changed to array(*)
!> \endverbatim
!>
!  =====================================================================
PURE FUNCTION IHAMAX(N, CX, INCX)
  IMPLICIT NONE
!
!  -- Reference BLAS level1 routine --
!  -- Reference BLAS is a software package provided by Univ. of Tennessee,    --
!  -- Univ. of California Berkeley, Univ. of Colorado Denver and NAG Ltd..--
!
!     .. Scalar Arguments ..
  INTEGER, INTENT(IN) :: INCX, N
!     ..
!     .. Array Arguments ..
  COMPLEX(KIND=BLAS_REAL_KIND), INTENT(IN) :: CX(*)
!     ..
  INTEGER :: IHAMAX
!
!  =====================================================================
!
  REAL(KIND=BLAS_REAL_KIND), PARAMETER :: ZERO = 0.0, HALF = 0.5, ONE = 1.0
!     .. Local Scalars ..
  COMPLEX(KIND=BLAS_REAL_KIND) :: X
  REAL(KIND=BLAS_REAL_KIND) :: SMAX, SCLM, A, XR, XI
  INTEGER :: I, IX, L
!     ..
  IHAMAX = 0
  IF (N .LE. 0) RETURN
  IHAMAX = 1
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
        IHAMAX = I
        RETURN
     END IF
     IF (.NOT. (XI .LE. HUGE(XI))) THEN
        IHAMAX = I
        RETURN
     END IF
     IF (L .NE. 0) THEN
        XR = XR * SCLM
        XI = XI * SCLM
     END IF
     A = XR + XI
     DO WHILE (.NOT. (A .LE. HUGE(A)))
        XR = XR * HALF
        XI = XI * HALF
        SCLM = SCLM * HALF
        SMAX = SMAX * HALF
        L = L + 1
        A = XR + XI
     END DO
     IF (A .GT. SMAX) THEN
        IHAMAX = I
        SMAX = A
     END IF
     IX = IX + INCX
  END DO
!
!     End of IHAMAX
!
END FUNCTION IHAMAX
