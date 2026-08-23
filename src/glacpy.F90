!> \brief \b GLACPY copies all or part of one two-dimensional array to another.
!
!  =========== DOCUMENTATION ===========
!
! Online html documentation available at
!            http://www.netlib.org/lapack/explore-html/
!
!> Download GLACPY + dependencies
!> <a href="http://www.netlib.org/cgi-bin/netlibfiles.tgz?format=tgz&filename=/lapack/lapack_routine/slacpy.f">
!> [TGZ]</a>
!> <a href="http://www.netlib.org/cgi-bin/netlibfiles.zip?format=zip&filename=/lapack/lapack_routine/slacpy.f">
!> [ZIP]</a>
!> <a href="http://www.netlib.org/cgi-bin/netlibfiles.txt?format=txt&filename=/lapack/lapack_routine/slacpy.f">
!> [TXT]</a>
!
!  Definition:
!  ===========
!
!       SUBROUTINE GLACPY( UPLO, M, N, A, LDA, B, LDB )
!
!       .. Scalar Arguments ..
!       CHARACTER          UPLO
!       INTEGER            LDA, LDB, M, N
!       ..
!       .. Array Arguments ..
!       REAL               A( LDA, * ), B( LDB, * )
!       ..
!
!
!> \par Purpose:
!  =============
!>
!> \verbatim
!>
!> GLACPY copies all or part of a two-dimensional matrix A to another
!> matrix B.
!> \endverbatim
!
!  Arguments:
!  ==========
!
!> \param[in] UPLO
!> \verbatim
!>          UPLO is CHARACTER*1
!>          Specifies the part of the matrix A to be copied to B.
!>          = 'U':      Upper triangular part
!>          = 'L':      Lower triangular part
!>          Otherwise:  All of the matrix A
!> \endverbatim
!>
!> \param[in] M
!> \verbatim
!>          M is INTEGER
!>          The number of rows of the matrix A.  M >= 0.
!> \endverbatim
!>
!> \param[in] N
!> \verbatim
!>          N is INTEGER
!>          The number of columns of the matrix A.  N >= 0.
!> \endverbatim
!>
!> \param[in] A
!> \verbatim
!>          A is REAL array, dimension (LDA,N)
!>          The m by n matrix A.  If UPLO = 'U', only the upper triangle
!>          or trapezoid is accessed; if UPLO = 'L', only the lower
!>          triangle or trapezoid is accessed.
!> \endverbatim
!>
!> \param[in] LDA
!> \verbatim
!>          LDA is INTEGER
!>          The leading dimension of the array A.  LDA >= max(1,M).
!> \endverbatim
!>
!> \param[out] B
!> \verbatim
!>          B is REAL array, dimension (LDB,N)
!>          On exit, B = A in the locations specified by UPLO.
!> \endverbatim
!>
!> \param[in] LDB
!> \verbatim
!>          LDB is INTEGER
!>          The leading dimension of the array B.  LDB >= max(1,M).
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
!> \ingroup lacpy
!
!  =====================================================================
PURE SUBROUTINE GLACPY(UPLO, M, N, A, LDA, B, LDB)
  IMPLICIT NONE
  INTERFACE
     PURE FUNCTION LSAME(CA, CB)
       IMPLICIT NONE
       CHARACTER, INTENT(IN) :: CA, CB
       LOGICAL :: LSAME
     END FUNCTION LSAME
  END INTERFACE
!
!  -- LAPACK auxiliary routine --
!  -- LAPACK is a software package provided by Univ. of Tennessee,    --
!  -- Univ. of California Berkeley, Univ. of Colorado Denver and NAG Ltd..--
!
!     .. Scalar Arguments ..
  CHARACTER, INTENT(IN) :: UPLO
  INTEGER, INTENT(IN) :: M, N, LDA, LDB
!     ..
!     .. Array Arguments ..
  REAL(KIND=BLAS_REAL_KIND), INTENT(IN) :: A(LDA,*)
  REAL(KIND=BLAS_REAL_KIND), INTENT(OUT) :: B(LDB,*)
!     ..
!
!  =====================================================================
!
!     .. Local Scalars ..
  INTEGER :: I, J
!     ..
!     .. Executable Statements ..
!
  IF (LSAME(UPLO, 'U')) THEN
     DO J = 1, N
        DO I = 1, MIN(J, M)
           B(I,J) = A(I,J)
        END DO
     END DO
  ELSE IF (LSAME(UPLO, 'L')) THEN
     DO J = 1, MIN(M, N)
        DO I = J, M
           B(I,J) = A(I,J)
        END DO
     END DO
  ELSE
     DO J = 1, N
        DO I = 1, M
           B(I,J) = A(I,J)
        END DO
     END DO
  END IF
!
!     End of GLACPY
!
END SUBROUTINE GLACPY
