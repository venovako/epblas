!> \brief \b GASUM
!
!  =========== DOCUMENTATION ===========
!
! Online html documentation available at
!            http://www.netlib.org/lapack/explore-html/
!
!  Definition:
!  ===========
!
!       REAL FUNCTION GASUM(N,SX,INCX)
!
!       .. Scalar Arguments ..
!       INTEGER INCX,N
!       ..
!       .. Array Arguments ..
!       REAL SX(*)
!       ..
!
!
!> \par Purpose:
!  =============
!>
!> \verbatim
!>
!>    GASUM takes the sum of the absolute values.
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
!> \param[in] SX
!> \verbatim
!>          SX is REAL array, dimension ( 1 + ( N - 1 )*abs( INCX ) )
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
PURE FUNCTION GASUM(N, SX, INCX)
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
  REAL(KIND=BLAS_REAL_KIND), INTENT(IN) :: SX(*)
!     ..
!
!  =====================================================================
!     ..
  REAL(KIND=BLAS_REAL_KIND), PARAMETER :: ZERO = 0.0
  REAL(KIND=BLAS_REAL_KIND) :: GASUM
!     .. Local Scalars ..
  INTEGER :: I, IX
!     ..
  GASUM = ZERO
  IF (N .LE. 0) RETURN
  IF (INCX .EQ. 1) THEN
!
!        code for increment equal to 1
!     
     DO I = 1, N
        GASUM = GASUM + ABS(SX(I))
     END DO
  ELSE
!
!        code for increment not equal to 1
!
     IF (INCX .LT. 0) THEN
        IX = 1 + (1-N)*INCX
     ELSE
        IX = 1
     END IF
     DO I = 1, N
        GASUM = GASUM + ABS(SX(IX))
        IX = IX + INCX
     END DO
  END IF
!
!     End of GASUM
!
END FUNCTION GASUM
