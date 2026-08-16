!> \brief \b GCABS1
!
!  =========== DOCUMENTATION ===========
!
! Online html documentation available at
!            http://www.netlib.org/lapack/explore-html/
!
!  Definition:
!  ===========
!
!       REAL FUNCTION GCABS1(Z)
!
!       .. Scalar Arguments ..
!       COMPLEX Z
!       ..
!
!
!> \par Purpose:
!  =============
!>
!> \verbatim
!>
!> GCABS1 computes |Re(.)| + |Im(.)| of a complex number
!> \endverbatim
!
!  Arguments:
!  ==========
!
!> \param[in] Z
!> \verbatim
!>          Z is COMPLEX
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
!> \ingroup abs1
!
!  =====================================================================
PURE FUNCTION GCABS1(Z)
  IMPLICIT NONE
!
!  -- Reference BLAS level1 routine --
!  -- Reference BLAS is a software package provided by Univ. of Tennessee,    --
!  -- Univ. of California Berkeley, Univ. of Colorado Denver and NAG Ltd..--
!
!     .. Scalar Arguments ..
  COMPLEX(KIND=BLAS_REAL_KIND), INTENT(IN) :: Z
!     ..
!
!  =====================================================================
  REAL(KIND=BLAS_REAL_KIND) :: GCABS1
!     ..
  GCABS1 = ABS(REAL(Z)) + ABS(AIMAG(Z))
!
!     End of GCABS1
!
END FUNCTION GCABS1
