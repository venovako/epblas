!> \brief \b XERBLA_ARRAY
!
!  =========== DOCUMENTATION ===========
!
! Online html documentation available at
!            http://www.netlib.org/lapack/explore-html/
!
!  Definition:
!  ===========
!
!       SUBROUTINE XERBLA_ARRAY(SRNAME_ARRAY, SRNAME_LEN, INFO)
!
!       .. Scalar Arguments ..
!       INTEGER SRNAME_LEN, INFO
!       ..
!       .. Array Arguments ..
!       CHARACTER(1) SRNAME_ARRAY(SRNAME_LEN)
!       ..
!
!
!> \par Purpose:
!  =============
!>
!> \verbatim
!>
!> XERBLA_ARRAY assists other languages in calling XERBLA, the LAPACK
!> and BLAS error handler.  Rather than taking a Fortran string argument
!> as the function's name, XERBLA_ARRAY takes an array of single
!> characters along with the array's length.  XERBLA_ARRAY then copies
!> up to 32 characters of that array into a Fortran string and passes
!> that to XERBLA.  If called with a non-positive SRNAME_LEN,
!> XERBLA_ARRAY will call XERBLA with a string of all blank characters.
!>
!> Say some macro or other device makes XERBLA_ARRAY available to C99
!> by a name lapack_xerbla and with a common Fortran calling convention.
!> Then a C99 program could invoke XERBLA via:
!>    {
!>      int flen = strlen(__func__);
!>      lapack_xerbla(__func__, &flen, &info);
!>    }
!>
!> Providing XERBLA_ARRAY is not necessary for intercepting LAPACK
!> errors.  XERBLA_ARRAY calls XERBLA.
!> \endverbatim
!
!  Arguments:
!  ==========
!
!> \param[in] SRNAME_ARRAY
!> \verbatim
!>          SRNAME_ARRAY is CHARACTER(1) array, dimension (SRNAME_LEN)
!>          The name of the routine which called XERBLA_ARRAY.
!> \endverbatim
!>
!> \param[in] SRNAME_LEN
!> \verbatim
!>          SRNAME_LEN is INTEGER
!>          The length of the name in SRNAME_ARRAY.
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
!> \ingroup xerbla_array
!
!  =====================================================================
! HACK(venovako): do NOT stop the process.
! Instead, "hijack" errno and set it to a negative value.
! PVN_GET_ERRNO can be used to check for errors afterwards.
! This way no dependency on the Fortran runtime is introduced.
SUBROUTINE XERBLA_ARRAY(SRNAME_ARRAY, SRNAME_LEN, INFO)
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
  INTEGER, INTENT(IN) :: SRNAME_LEN, INFO
!     ..
!     .. Array Arguments ..
  CHARACTER, INTENT(IN) :: SRNAME_ARRAY(SRNAME_LEN)
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
!     End of XERBLA_ARRAY
!
END SUBROUTINE XERBLA_ARRAY
