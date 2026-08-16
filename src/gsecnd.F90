!> \brief \b GSECND Using INTERNAL function CPU_TIME.
!
!  =========== DOCUMENTATION ===========
!
! Online html documentation available at
!            http://www.netlib.org/lapack/explore-html/
!
!  Definition:
!  ===========
!
!      REAL FUNCTION GSECND( )
!
!
!> \par Purpose:
!  =============
!>
!> \verbatim
!>
!>  GSECND returns the user time for a process in seconds.
!>  This version gets the time from the INTERNAL function CPU_TIME.
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
!> \ingroup second
!
!  =====================================================================
FUNCTION GSECND()
  IMPLICIT NONE
  INTERFACE
     FUNCTION PVN_TIME_MONO_FREQ()
       USE, INTRINSIC :: ISO_FORTRAN_ENV, ONLY: INT64
       IMPLICIT NONE
       INTEGER(KIND=INT64) :: PVN_TIME_MONO_FREQ
     END FUNCTION PVN_TIME_MONO_FREQ
  END INTERFACE
  INTERFACE
     FUNCTION PVN_TIME_MONO_TICKS()
       USE, INTRINSIC :: ISO_FORTRAN_ENV, ONLY: INT64
       IMPLICIT NONE
       INTEGER(KIND=INT64) :: PVN_TIME_MONO_TICKS
     END FUNCTION PVN_TIME_MONO_TICKS
  END INTERFACE
!
!  -- LAPACK auxiliary routine --
!  -- LAPACK is a software package provided by Univ. of Tennessee,    --
!  -- Univ. of California Berkeley, Univ. of Colorado Denver and NAG Ltd..--
!
! =====================================================================
  REAL(KIND=BLAS_REAL_KIND) :: GSECND
!
! .. Executable Statements .. *
!
  GSECND = PVN_TIME_MONO_TICKS() / REAL(PVN_TIME_MONO_FREQ(), BLAS_REAL_KIND)
!
!     End of GSECND
!
END FUNCTION GSECND
