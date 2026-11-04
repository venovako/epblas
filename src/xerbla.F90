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
!> Users can replace the BLAS XERBLA by calling SET_BLAS_XERBLA
!> with a replacement handler. See separate documentation in
!> xerbla_blas.f90.
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
!> \author Ed J (see the original xerbla_blas.f90)
!> \author modified by venovako
!
!> \ingroup xerbla
!
!  =====================================================================
BLOCK DATA XERBLA_INIT
   INTEGER(8) ACT
   COMMON /XERBLA_BLAS/ ACT
   DATA ACT/0_8/
END BLOCK DATA

SUBROUTINE SET_BLAS_XERBLA(CB)
  USE, INTRINSIC :: ISO_C_BINDING
  IMPLICIT NONE
  ABSTRACT INTERFACE
     SUBROUTINE XERBLA_INTERFACE(SRNAME, INFO)
       IMPLICIT NONE
       CHARACTER(LEN=*), INTENT(IN) :: SRNAME
       INTEGER, INTENT(IN) :: INFO
     END SUBROUTINE XERBLA_INTERFACE
  END INTERFACE
!
!     .. Scalar Arguments ..
  PROCEDURE(XERBLA_INTERFACE) :: CB
!     ..
!     .. externals ..
  TYPE(c_funptr) :: ACT
  COMMON /XERBLA_BLAS/ ACT
  EXTERNAL :: XERBLA_INIT
!     ..
!     .. Executable Statements ..
!
  ACT = C_FUNLOC(CB)
END SUBROUTINE SET_BLAS_XERBLA

! HACK(venovako): do NOT stop the process by default.
! Instead, "hijack" errno and set it to a negative value.
! PVN_GET_ERRNO can be used to check for errors afterwards.
SUBROUTINE DEF_BLAS_XERBLA(SRNAME, INFO)
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
!     .. Scalar Arguments ..
  CHARACTER(LEN=*), INTENT(IN) :: SRNAME
  INTEGER, INTENT(IN) :: INFO
!     ..
!     .. Local Scalars ..
  INTEGER(KIND=INT32) :: E
!     ..
!     .. Executable Statements ..
!
  IF (INFO .GT. 0) THEN
     E = -INT(INFO, INT32)
     CALL PVN_SET_ERRNO(E)
  ELSE ! the old default
     WRITE (*,9) SRNAME(1:LEN_TRIM(SRNAME)), -INFO
     STOP
  END IF
9 FORMAT(' ** On entry to ', A, ' parameter number ', I2, ' had an illegal value')
END SUBROUTINE DEF_BLAS_XERBLA

SUBROUTINE GET_BLAS_XERBLA(CB)
  USE, INTRINSIC :: ISO_C_BINDING
  IMPLICIT NONE
  ABSTRACT INTERFACE
     SUBROUTINE XERBLA_INTERFACE(SRNAME, INFO)
       IMPLICIT NONE
       CHARACTER(LEN=*), INTENT(IN) :: SRNAME
       INTEGER, INTENT(IN) :: INFO
     END SUBROUTINE XERBLA_INTERFACE
  END INTERFACE
!
!     .. Scalar Arguments ..
  PROCEDURE(XERBLA_INTERFACE), POINTER :: CB
!     ..
!     .. externals ..
  TYPE(c_funptr) :: ACT
  COMMON /XERBLA_BLAS/ ACT
  EXTERNAL :: XERBLA_INIT, DEF_BLAS_XERBLA
!     ..
!     .. Executable Statements ..
!
  IF (C_ASSOCIATED(ACT)) THEN
    CALL C_F_PROCPOINTER(ACT, CB)
  ELSE ! default
    CALL C_F_PROCPOINTER(C_FUNLOC(DEF_BLAS_XERBLA), CB)
  END IF
END SUBROUTINE GET_BLAS_XERBLA

SUBROUTINE XERBLA(SRNAME, INFO)
  USE, INTRINSIC :: ISO_C_BINDING
  IMPLICIT NONE
  ABSTRACT INTERFACE
     SUBROUTINE XERBLA_INTERFACE(SRNAME, INFO)
       IMPLICIT NONE
       CHARACTER(LEN=*), INTENT(IN) :: SRNAME
       INTEGER, INTENT(IN) :: INFO
     END SUBROUTINE XERBLA_INTERFACE
  END INTERFACE
!
!     .. Scalar Arguments ..
  CHARACTER(LEN=*), INTENT(IN) :: SRNAME
  INTEGER, INTENT(IN) :: INFO
!     ..
!     .. Local Scalars ..
  PROCEDURE(XERBLA_INTERFACE), POINTER :: PACT
!     ..
!     .. externals ..
  TYPE(c_funptr) :: ACT
  COMMON /XERBLA_BLAS/ ACT
  EXTERNAL :: XERBLA_INIT, DEF_BLAS_XERBLA
!     ..
!     .. Executable Statements ..
!
  IF (C_ASSOCIATED(ACT)) THEN
     CALL C_F_PROCPOINTER(ACT, PACT)
     CALL PACT(SRNAME, INFO)
  ELSE ! default
     CALL DEF_BLAS_XERBLA(SRNAME, INFO)
  END IF
!
!     End of XERBLA
!
END SUBROUTINE XERBLA
