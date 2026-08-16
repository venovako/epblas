!> \brief \b IGAMAX
!
!  =========== DOCUMENTATION ===========
!
! Online html documentation available at
!            http://www.netlib.org/lapack/explore-html/
!
!  Definition:
!  ===========
!
!       INTEGER FUNCTION IGAMAX(N,SX,INCX)
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
!>    IGAMAX finds the index of the first element having maximum absolute value.
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
PURE FUNCTION IGAMAX(N, SX, INCX)
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
  REAL(KIND=BLAS_REAL_KIND), INTENT(IN) :: SX(*)
!     ..
  INTEGER :: IGAMAX
!
!  =====================================================================
!
!     .. Local Scalars ..
  REAL(KIND=BLAS_REAL_KIND) :: SMAX, A
  INTEGER :: I, IX
!     ..
  IGAMAX = 0
  IF (N .LT. 1) RETURN
  IGAMAX = 1
  IF (N .EQ. 1) RETURN
  IF (INCX .EQ. 1) THEN
!
!        code for increment equal to 1
!
     SMAX = ABS(SX(1))
     DO I = 2, N
        A = ABS(SX(I))
        IF (A .GT. SMAX) THEN
           IGAMAX = I
           SMAX = A
        END IF
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
     SMAX = ABS(SX(IX))
     IX = IX + INCX
     DO I = 2, N
        A = ABS(SX(IX))
        IF (A .GT. SMAX) THEN
           IGAMAX = I
           SMAX = A
        END IF
        IX = IX + INCX
     END DO
  END IF
!
!     End of IGAMAX
!
END FUNCTION IGAMAX
