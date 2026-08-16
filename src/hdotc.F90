!> \brief \b HDOTC
!
!  =========== DOCUMENTATION ===========
!
! Online html documentation available at
!            http://www.netlib.org/lapack/explore-html/
!
!  Definition:
!  ===========
!
!       COMPLEX FUNCTION HDOTC(N,CX,INCX,CY,INCY)
!
!       .. Scalar Arguments ..
!       INTEGER INCX,INCY,N
!       ..
!       .. Array Arguments ..
!       COMPLEX CX(*),CY(*)
!       ..
!
!
!> \par Purpose:
!  =============
!>
!> \verbatim
!>
!> HDOTC forms the dot product of two complex vectors
!>      HDOTC = X^H * Y
!>
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
!>
!> \param[in] CY
!> \verbatim
!>          CY is COMPLEX array, dimension ( 1 + ( N - 1 )*abs( INCY ) )
!> \endverbatim
!>
!> \param[in] INCY
!> \verbatim
!>          INCY is INTEGER
!>         storage spacing between elements of CY
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
!> \ingroup dot
!
!> \par Further Details:
!  =====================
!>
!> \verbatim
!>
!>     jack dongarra, linpack,  3/11/78.
!>     modified 12/3/93, array(1) declarations changed to array(*)
!> \endverbatim
!>
!  =====================================================================
PURE FUNCTION HDOTC(N, CX, INCX, CY, INCY)
#define HFMA(A,B,C) ((A)*(B)+(C))
  IMPLICIT NONE
!
!  -- Reference BLAS level1 routine --
!  -- Reference BLAS is a software package provided by Univ. of Tennessee,    --
!  -- Univ. of California Berkeley, Univ. of Colorado Denver and NAG Ltd..--
!
!     .. Scalar Arguments ..
  INTEGER, INTENT(IN) :: INCX, INCY, N
!     ..
!     .. Array Arguments ..
  COMPLEX(KIND=BLAS_REAL_KIND), INTENT(IN) :: CX(*), CY(*)
!     ..
!
!  =====================================================================
  COMPLEX(KIND=BLAS_REAL_KIND), PARAMETER :: ZERO = CMPLX(0.0, 0.0, BLAS_REAL_KIND)
  COMPLEX(KIND=BLAS_REAL_KIND) :: HDOTC
!     .. Local Scalars ..
  INTEGER :: I, IX, IY
!     ..
  HDOTC = ZERO
  IF (N .LE. 0) RETURN
  IF ((INCX .EQ. 1) .AND. (INCY .EQ. 1)) THEN
!
!        code for both increments equal to 1
!
     DO I = 1, N
        HDOTC = HFMA(CONJG(CX(I)), CY(I), HDOTC)
     END DO
  ELSE
!
!        code for unequal increments or equal increments
!          not equal to 1
!
     IF (INCX .LT. 0) THEN
        IX = (1-N)*INCX + 1
     ELSE
        IX = 1
     END IF
     IF (INCY .LT. 0) THEN
        IY = (1-N)*INCY + 1
     ELSE
        IY = 1
     END IF
     DO I = 1, N
        HDOTC = HFMA(CONJG(CX(IX)), CY(IY), HDOTC)
        IX = IX + INCX
        IY = IY + INCY
     END DO
  END IF
!
!     End of HDOTC
!
END FUNCTION HDOTC
