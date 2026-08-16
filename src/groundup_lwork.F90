!> \brief \b GROUNDUP_LWORK
!
!  =========== DOCUMENTATION ===========
!
! Online html documentation available at
!            http://www.netlib.org/lapack/explore-html/
!
!  Definition:
!  ===========
!
!      REAL             FUNCTION GROUNDUP_LWORK( LWORK )
!
!     .. Scalar Arguments ..
!      INTEGER          LWORK
!     ..
!
!
!> \par Purpose:
!  =============
!>
!> \verbatim
!>
!> GROUNDUP_LWORK deals with a subtle bug with returning LWORK as a Float.
!> This routine guarantees it is rounded up instead of down by
!> multiplying LWORK by 1+eps when it is necessary, where eps is the relative machine precision.
!> E.g.,
!>
!>        float( 16777217            ) == 16777216
!>        float( 16777217 ) * (1.+eps) == 16777218
!>
!> \return GROUNDUP_LWORK
!> \verbatim
!>         GROUNDUP_LWORK >= LWORK.
!>         GROUNDUP_LWORK is guaranteed to have zero decimal part.
!> \endverbatim
!
!  Arguments:
!  ==========
!
!> \param[in] LWORK Workspace size.
!
!  Authors:
!  ========
!
!> \author Weslley Pereira, University of Colorado Denver, USA
!> \author modified by venovako
!
!> \ingroup roundup_lwork
!
!> \par Further Details:
!  =====================
!>
!> \verbatim
!>  This routine was inspired in the method `magma_zmake_lwork` from MAGMA.
!>  \see https://bitbucket.org/icl/magma/src/master/control/magma_zauxiliary.cpp
!> \endverbatim
!
!  =====================================================================
PURE FUNCTION GROUNDUP_LWORK(LWORK)
  IMPLICIT NONE
!
!  -- LAPACK auxiliary routine --
!  -- LAPACK is a software package provided by Univ. of Tennessee,    --
!  -- Univ. of California Berkeley, Univ. of Colorado Denver and NAG Ltd..--
!
!     .. Scalar Arguments ..
  INTEGER, INTENT(IN) :: LWORK
!     ..
!
! =====================================================================
  REAL(KIND=BLAS_REAL_KIND) :: GROUNDUP_LWORK
  REAL(KIND=BLAS_REAL_KIND), PARAMETER :: ONE = 1.0
!     ..
!     .. Executable Statements ..
!     ..
  GROUNDUP_LWORK = REAL(LWORK, BLAS_REAL_KIND)
!
!         Force round up of LWORK
  IF (INT(GROUNDUP_LWORK) .LT. LWORK) GROUNDUP_LWORK = GROUNDUP_LWORK * (ONE + EPSILON(ONE))
!
!     End of GROUNDUP_LWORK
!
END FUNCTION GROUNDUP_LWORK
