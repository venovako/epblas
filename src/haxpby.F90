!> \brief \b HAXPBY
!
!  =========== DOCUMENTATION ===========
!
! Online html documentation available at
!            http://www.netlib.org/lapack/explore-html/
!
!  Definition:
!  ===========
!
!       SUBROUTINE HAXPBY(N,CA,CX,INCX,CB,CY,INCY)
!
!       .. Scalar Arguments ..
!       COMPLEX CA,CB
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
!>    HAXPBY constant times a vector plus constant times a vector.
!>
!>    Y = ALPHA * X + BETA * Y
!>
!> \endverbatim
!
!  Arguments:
!  ==========
!
!> \param[in] N
!> \verbatim
!>          N is INTEGER
!>          number of elements in input vector(s)
!> \endverbatim
!>
!> \param[in] CA
!> \verbatim
!>          CA is COMPLEX
!>          On entry, CA specifies the scalar alpha.
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
!>          storage spacing between elements of CX
!> \endverbatim
!>
!> \param[in] CB
!> \verbatim
!>          CB is COMPLEX
!>          On entry, CB specifies the scalar beta.
!> \endverbatim
!>
!> \param[in,out] CY
!> \verbatim
!>          CY is COMPLEX array, dimension ( 1 + ( N - 1 )*abs( INCY ) )
!> \endverbatim
!>
!> \param[in] INCY
!> \verbatim
!>          INCY is INTEGER
!>          storage spacing between elements of CY
!> \endverbatim
!
!  Authors:
!  ========
!
!> \author Univ. of Tennessee
!> \author Univ. of California Berkeley
!> \author Univ. of Colorado Denver
!> \author NAG Ltd.
!> \author Martin Koehler, MPI Magdeburg
!> \author modified by venovako
!
!> \ingroup axpby
!
!  =====================================================================
PURE SUBROUTINE HAXPBY(N, CA, CX, INCX, CB, CY, INCY)
#define HMUL(A,B) ((A)*(B))
#define HFMA(A,B,C) ((A)*(B)+(C))
#define HFMMA(A,B,C,D) ((A)*(B)+(C)*(D))
  IMPLICIT NONE
!
!  -- Reference BLAS level1 routine --
!  -- Reference BLAS is a software package provided by Univ. of Tennessee,    --
!  -- Univ. of California Berkeley, Univ. of Colorado Denver and NAG Ltd..--
!
!     .. Scalar Arguments ..
  COMPLEX(KIND=BLAS_REAL_KIND), INTENT(IN) :: CA, CB
  INTEGER, INTENT(IN) ::  INCX, INCY, N
!     ..
!     .. Array Arguments ..
  COMPLEX(KIND=BLAS_REAL_KIND), INTENT(IN) :: CX(*)
  COMPLEX(KIND=BLAS_REAL_KIND), INTENT(INOUT) :: CY(*)
!
!  =====================================================================
  COMPLEX(KIND=BLAS_REAL_KIND), PARAMETER :: ZERO = CMPLX(0.0, 0.0, BLAS_REAL_KIND)
  COMPLEX(KIND=BLAS_REAL_KIND), PARAMETER :: ONE = CMPLX(1.0, 0.0, BLAS_REAL_KIND)
!
!     .. Local Scalars ..
  INTEGER :: I, IX, IY
!     ..
  IF (N .LE. 0) RETURN
!
  IF (CA .EQ. ZERO) THEN
     IF (INCY .EQ. 1) THEN
        IF (CB .NE. ONE) THEN
           DO I = 1, N
              CY(I) = HMUL(CB, CY(I))
           END DO
        END IF
     ELSE
        IF (CB .NE. ONE) THEN
           IF (INCY .LT. 0) THEN
              IY = (1-N)*INCY + 1
           ELSE
              IY = 1
           END IF
           DO I = 1, N
              CY(IY) = HMUL(CB, CY(IY))
              IY = IY + INCY
           END DO
        END IF
     END IF
  ELSE IF (CB .EQ. ZERO) THEN
     IF ((INCX .EQ. 1) .AND. (INCY .EQ. 1)) THEN
        DO I = 1, N
           CY(I) = HMUL(CA, CX(I))
        END DO
     ELSE
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
        IF (CA .EQ. ONE) THEN
           DO I = 1, N
              CY(IY) = CX(IX)
              IX = IX + INCX
              IY = IY + INCY
           END DO
        ELSE
           DO I = 1, N
              CY(IY) = HMUL(CA, CX(IX))
              IX = IX + INCX
              IY = IY + INCY
           END DO
        END IF
     END IF
  ELSE
     IF ((INCX .EQ. 1) .AND. (INCY .EQ. 1)) THEN
        IF (CA .EQ. ONE) THEN
           IF (CB .EQ. ONE) THEN
              DO I = 1, N
                 CY(I) = CY(I) + CX(I)
              END DO
           ELSE
              DO I = 1, N
                 CY(I) = HFMA(CB, CY(I), CX(I))
              END DO
           END IF
        ELSE IF (CB .EQ. ONE) THEN
           DO I = 1, N
              CY(I) = HFMA(CA, CX(I), CY(I))
           END DO
        ELSE
           DO I = 1, N
              CY(I) = HFMMA(CB, CY(I), CA, CX(I))
           END DO
        END IF
     ELSE
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
        IF (CA .EQ. ONE) THEN
           IF (CB .EQ. ONE) THEN
              DO I = 1, N
                 CY(IY) = CY(IY) + CX(IX)
                 IX = IX + INCX
                 IY = IY + INCY
              END DO
           ELSE
              DO I = 1, N
                 CY(IY) = HFMA(CB, CY(IY), CX(IX))
                 IX = IX + INCX
                 IY = IY + INCY
              END DO
           END IF
        ELSE IF (CB .EQ. ONE) THEN
           DO I = 1, N
              CY(IY) = HFMA(CA, CX(IX), CY(IY))
              IX = IX + INCX
              IY = IY + INCY
           END DO
        ELSE
           DO I = 1, N
              CY(IY) = HFMMA(CB, CY(IY), CA, CX(IX))
              IX = IX + INCX
              IY = IY + INCY
           END DO
        END IF
     END IF
  END IF
!
!     End of HAXPBY
!
END SUBROUTINE HAXPBY
