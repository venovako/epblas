!> \brief \b GHASUM
!
!  =========== DOCUMENTATION ===========
!
! Online html documentation available at
!            http://www.netlib.org/lapack/explore-html/
!
!  Definition:
!  ===========
!
!       REAL FUNCTION GHASUM(N,CX,INCX)
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
!>    GHASUM takes the sum of the (|Re(.)| + |Im(.)|)'s of a complex vector.
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
!> \param[in,out] CX
!> \verbatim
!>          CX is COMPLEX array, dimension ( 1 + ( N - 1 )*abs( INCX ) )
!> \endverbatim
!>
!> \param[in] INCX
!> \verbatim
!>          INCX is INTEGER
!>         storage spacing between elements of SX
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
!> \ingroup asum
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
PURE FUNCTION GHASUM(N, CX, INCX)
  IMPLICIT NONE
!
!  -- Reference BLAS level1 routine --
!  -- Reference BLAS is a software package provided by Univ. of Tennessee,    --
!  -- Univ. of California Berkeley, Univ. of Colorado Denver and NAG Ltd..--
!
!     .. Scalar Arguments ..
  INTEGER, INTENT(IN) :: N, INCX
!     ..
!     .. Array Arguments ..
  COMPLEX(KIND=BLAS_REAL_KIND), INTENT(IN) :: CX(*)
!     ..
!
!  =====================================================================
!     ..
  REAL(KIND=BLAS_REAL_KIND), PARAMETER :: ZERO = 0.0
  REAL(KIND=BLAS_REAL_KIND) :: GHASUM
!
!     .. Local Scalars ..
  INTEGER :: I, IX
!     ..
  GHASUM = ZERO
  IF (N .LE. 0) RETURN
  IF (INCX .EQ. 1) THEN
!
!        code for increment equal to 1
!
     DO I = 1, N
        GHASUM = GHASUM + ABS(REAL(CX(I))) + ABS(AIMAG(CX(I)))
     END DO
  ELSE
!
!        code for increment not equal to 1
!
!
     IF (INCX .LT. 0) THEN
        IX = 1 + (1-N)*INCX
     ELSE
        IX = 1
     END IF
     DO I = 1, N
        GHASUM = GHASUM + ABS(REAL(CX(IX))) + ABS(AIMAG(CX(IX)))
        IX = IX + INCX
     END DO
  END IF
!
!     End of GHASUM
!
END FUNCTION GHASUM
