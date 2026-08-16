!> \brief \b XERBLA
!
!  =========== DOCUMENTATION ===========
!
! Online html documentation available at
!            http://www.netlib.org/lapack/explore-html/
!
!  Definition:
!  ===========
!
!       SUBROUTINE XERBLA( SRNAME, INFO )
!
!       .. Scalar Arguments ..
!       CHARACTER*(*)      SRNAME
!       INTEGER            INFO
!       ..
!
!
!> \par Purpose:
!  =============
!>
!> \verbatim
!>
!> XERBLA  is an error handler for the LAPACK routines.
!> It is called by an LAPACK routine if an input parameter has an
!> invalid value.  A message is printed and execution stops.
!>
!> Installers may consider modifying the STOP statement in order to
!> call system-specific exception-handling facilities.
!> \endverbatim
!
!  Arguments:
!  ==========
!
!> \param[in] SRNAME
!> \verbatim
!>          SRNAME is CHARACTER*(*)
!>          The name of the routine which called XERBLA.
!> \endverbatim
!>
!> \param[in] INFO
!> \verbatim
!>          INFO is INTEGER
!>          The position of the invalid parameter in the parameter list
!>          of the calling routine.
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
!> \ingroup xerbla
!
!  =====================================================================
! HACK(venovako): do NOT stop the process.
! Instead, "hijack" errno and set it to a negative value.
! PVN_GET_ERRNO can be used to check for errors afterwards.
! This way no dependency on the Fortran runtime is introduced.
SUBROUTINE XERBLA(SRNAME, INFO)
  USE, INTRINSIC :: ISO_FORTRAN_ENV, ONLY: INT32
  IMPLICIT NONE
  INTERFACE
     SUBROUTINE PVN_SET_ERRNO(E)
       USE, INTRINSIC :: ISO_FORTRAN_ENV, ONLY: INT32
       IMPLICIT NONE
       INTEGER(KIND=INT32), INTENT(IN) :: E
     END SUBROUTINE PVN_SET_ERRNO
  END INTERFACE
!
!  -- Reference BLAS level1 routine --
!  -- Reference BLAS is a software package provided by Univ. of Tennessee,    --
!  -- Univ. of California Berkeley, Univ. of Colorado Denver and NAG Ltd..--
!
!     .. Scalar Arguments ..
  CHARACTER(LEN=*), INTENT(IN) :: SRNAME
  INTEGER, INTENT(IN) :: INFO
!     ..
!
! =====================================================================
!
!     ..
!     .. Local Scalars ..
  INTEGER(KIND=INT32) :: E
!     ..
!     .. Executable Statements ..
!
  IF (INFO .GT. 0) THEN
     E = -INT(INFO, INT32)
  ELSE ! should never happen
     E = -HUGE(E) - 1_INT32
  END IF
  CALL PVN_SET_ERRNO(E)
!
!     End of XERBLA
!
END SUBROUTINE XERBLA
