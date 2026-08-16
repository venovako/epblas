!> \brief \b HGSCAL
!
!  =========== DOCUMENTATION ===========
!
! Online html documentation available at
!            http://www.netlib.org/lapack/explore-html/
!
!  Definition:
!  ===========
!
!       SUBROUTINE HGSCAL(N,SA,CX,INCX)
!
!       .. Scalar Arguments ..
!       REAL SA
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
!>    HGSCAL scales a complex vector by a real constant.
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
!> \param[in] SA
!> \verbatim
!>          SA is REAL
!>           On entry, SA specifies the scalar alpha.
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
!> \ingroup scal
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
PURE SUBROUTINE HGSCAL(N, SA, CX, INCX)
  IMPLICIT NONE
!
!  -- Reference BLAS level1 routine --
!  -- Reference BLAS is a software package provided by Univ. of Tennessee,    --
!  -- Univ. of California Berkeley, Univ. of Colorado Denver and NAG Ltd..--
!
!     .. Scalar Arguments ..
  INTEGER, INTENT(IN) :: N, INCX
  REAL(KIND=BLAS_REAL_KIND), INTENT(IN) :: SA
!     ..
!     .. Array Arguments ..
  COMPLEX(KIND=BLAS_REAL_KIND), INTENT(INOUT) :: CX(*)
!     ..
!
!  =====================================================================
!
!     .. Local Scalars ..
  INTEGER I, IX
!     ..
!     .. Parameters ..
  REAL(KIND=BLAS_REAL_KIND), PARAMETER :: ONE = 1.0
!     ..
  IF ((N .LE. 0) .OR. (SA .EQ. ONE)) RETURN
  IF (INCX .EQ. 1) THEN
!
!        code for increment equal to 1
!
     DO I = 1, N
        CX(I) = CMPLX(SA * REAL(CX(I)), SA * AIMAG(CX(I)), BLAS_REAL_KIND)
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
        CX(IX) = CMPLX(SA * REAL(CX(IX)), SA * AIMAG(CX(IX)), BLAS_REAL_KIND)
        IX = IX + INCX
     END DO
  END IF
!
!     End of HGSCAL
!
END SUBROUTINE HGSCAL
