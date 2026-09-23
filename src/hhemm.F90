!> \brief \b HHEMM
!
!  =========== DOCUMENTATION ===========
!
! Online html documentation available at
!            http://www.netlib.org/lapack/explore-html/
!
!  Definition:
!  ===========
!
!       SUBROUTINE HHEMM(SIDE,UPLO,M,N,ALPHA,A,LDA,B,LDB,BETA,C,LDC)
!
!       .. Scalar Arguments ..
!       COMPLEX ALPHA,BETA
!       INTEGER LDA,LDB,LDC,M,N
!       CHARACTER SIDE,UPLO
!       ..
!       .. Array Arguments ..
!       COMPLEX A(LDA,*),B(LDB,*),C(LDC,*)
!       ..
!
!
!> \par Purpose:
!  =============
!>
!> \verbatim
!>
!> HHEMM  performs one of the matrix-matrix operations
!>
!>    C := alpha*A*B + beta*C,
!>
!> or
!>
!>    C := alpha*B*A + beta*C,
!>
!> where alpha and beta are scalars, A is an hermitian matrix and  B and
!> C are m by n matrices.
!> \endverbatim
!
!  Arguments:
!  ==========
!
!> \param[in] SIDE
!> \verbatim
!>          SIDE is CHARACTER*1
!>           On entry,  SIDE  specifies whether  the  hermitian matrix  A
!>           appears on the  left or right  in the  operation as follows:
!>
!>              SIDE = 'L' or 'l'   C := alpha*A*B + beta*C,
!>
!>              SIDE = 'R' or 'r'   C := alpha*B*A + beta*C,
!> \endverbatim
!>
!> \param[in] UPLO
!> \verbatim
!>          UPLO is CHARACTER*1
!>           On  entry,   UPLO  specifies  whether  the  upper  or  lower
!>           triangular  part  of  the  hermitian  matrix   A  is  to  be
!>           referenced as follows:
!>
!>              UPLO = 'U' or 'u'   Only the upper triangular part of the
!>                                  hermitian matrix is to be referenced.
!>
!>              UPLO = 'L' or 'l'   Only the lower triangular part of the
!>                                  hermitian matrix is to be referenced.
!> \endverbatim
!>
!> \param[in] M
!> \verbatim
!>          M is INTEGER
!>           On entry,  M  specifies the number of rows of the matrix  C.
!>           M  must be at least zero.
!> \endverbatim
!>
!> \param[in] N
!> \verbatim
!>          N is INTEGER
!>           On entry, N specifies the number of columns of the matrix C.
!>           N  must be at least zero.
!> \endverbatim
!>
!> \param[in] ALPHA
!> \verbatim
!>          ALPHA is COMPLEX
!>           On entry, ALPHA specifies the scalar alpha.
!> \endverbatim
!>
!> \param[in] A
!> \verbatim
!>          A is COMPLEX array, dimension ( LDA, ka ), where ka is
!>           m  when  SIDE = 'L' or 'l'  and is n  otherwise.
!>           Before entry  with  SIDE = 'L' or 'l',  the  m by m  part of
!>           the array  A  must contain the  hermitian matrix,  such that
!>           when  UPLO = 'U' or 'u', the leading m by m upper triangular
!>           part of the array  A  must contain the upper triangular part
!>           of the  hermitian matrix and the  strictly  lower triangular
!>           part of  A  is not referenced,  and when  UPLO = 'L' or 'l',
!>           the leading  m by m  lower triangular part  of the  array  A
!>           must  contain  the  lower triangular part  of the  hermitian
!>           matrix and the  strictly upper triangular part of  A  is not
!>           referenced.
!>           Before entry  with  SIDE = 'R' or 'r',  the  n by n  part of
!>           the array  A  must contain the  hermitian matrix,  such that
!>           when  UPLO = 'U' or 'u', the leading n by n upper triangular
!>           part of the array  A  must contain the upper triangular part
!>           of the  hermitian matrix and the  strictly  lower triangular
!>           part of  A  is not referenced,  and when  UPLO = 'L' or 'l',
!>           the leading  n by n  lower triangular part  of the  array  A
!>           must  contain  the  lower triangular part  of the  hermitian
!>           matrix and the  strictly upper triangular part of  A  is not
!>           referenced.
!>           Note that the imaginary parts  of the diagonal elements need
!>           not be set, they are assumed to be zero.
!> \endverbatim
!>
!> \param[in] LDA
!> \verbatim
!>          LDA is INTEGER
!>           On entry, LDA specifies the first dimension of A as declared
!>           in the  calling (sub) program. When  SIDE = 'L' or 'l'  then
!>           LDA must be at least  max( 1, m ), otherwise  LDA must be at
!>           least max( 1, n ).
!> \endverbatim
!>
!> \param[in] B
!> \verbatim
!>          B is COMPLEX array, dimension ( LDB, N )
!>           Before entry, the leading  m by n part of the array  B  must
!>           contain the matrix B.
!> \endverbatim
!>
!> \param[in] LDB
!> \verbatim
!>          LDB is INTEGER
!>           On entry, LDB specifies the first dimension of B as declared
!>           in  the  calling  (sub)  program.   LDB  must  be  at  least
!>           max( 1, m ).
!> \endverbatim
!>
!> \param[in] BETA
!> \verbatim
!>          BETA is COMPLEX
!>           On entry,  BETA  specifies the scalar  beta.  When  BETA  is
!>           supplied as zero then C need not be set on input.
!> \endverbatim
!>
!> \param[in,out] C
!> \verbatim
!>          C is COMPLEX array, dimension ( LDC, N )
!>           Before entry, the leading  m by n  part of the array  C must
!>           contain the matrix  C,  except when  beta  is zero, in which
!>           case C need not be set on entry.
!>           On exit, the array  C  is overwritten by the  m by n updated
!>           matrix.
!> \endverbatim
!>
!> \param[in] LDC
!> \verbatim
!>          LDC is INTEGER
!>           On entry, LDC specifies the first dimension of C as declared
!>           in  the  calling  (sub)  program.   LDC  must  be  at  least
!>           max( 1, m ).
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
!> \ingroup hemm
!
!> \par Further Details:
!  =====================
!>
!> \verbatim
!>
!>  Level 3 Blas routine.
!>
!>  -- Written on 8-February-1989.
!>     Jack Dongarra, Argonne National Laboratory.
!>     Iain Duff, AERE Harwell.
!>     Jeremy Du Croz, Numerical Algorithms Group Ltd.
!>     Sven Hammarling, Numerical Algorithms Group Ltd.
!> \endverbatim
!>
!  =====================================================================
PURE SUBROUTINE HHEMM(SIDE, UPLO, M, N, ALPHA, A, LDA, B, LDB, BETA, C, LDC)
  IMPLICIT NONE
#ifdef HMUL
  INTERFACE
     ELEMENTAL FUNCTION HMUL(A, B)
       IMPLICIT NONE
       COMPLEX(KIND=BLAS_REAL_KIND), INTENT(IN) :: A, B
       COMPLEX(KIND=BLAS_REAL_KIND) :: HMUL
     END FUNCTION HMUL
  END INTERFACE
#else
#define HMUL(A,B) ((A)*(B))
#endif
#ifdef HFMA
  INTERFACE
     ELEMENTAL FUNCTION HFMA(A, B, C)
       IMPLICIT NONE
       COMPLEX(KIND=BLAS_REAL_KIND), INTENT(IN) :: A, B, C
       COMPLEX(KIND=BLAS_REAL_KIND) :: HFMA
     END FUNCTION HFMA
  END INTERFACE
#else
#define HFMA(A,B,C) ((A)*(B)+(C))
#endif
#ifdef HFMMA
  INTERFACE
     ELEMENTAL FUNCTION HFMMA(A, B, C, D)
       IMPLICIT NONE
       COMPLEX(KIND=BLAS_REAL_KIND), INTENT(IN) :: A, B, C, D
       COMPLEX(KIND=BLAS_REAL_KIND) :: HFMMA
     END FUNCTION HFMMA
  END INTERFACE
#else
#define HFMMA(A,B,C,D) ((A)*(B)+(C)*(D))
#endif
  INTERFACE
     PURE FUNCTION LSAME(CA, CB)
       IMPLICIT NONE
       CHARACTER, INTENT(IN) :: CA, CB
       LOGICAL :: LSAME
     END FUNCTION LSAME
  END INTERFACE
  INTERFACE
     PURE SUBROUTINE XERBLA(SRNAME, INFO)
       IMPLICIT NONE
       CHARACTER(LEN=*), INTENT(IN) :: SRNAME
       INTEGER, INTENT(IN) :: INFO
     END SUBROUTINE XERBLA
  END INTERFACE
!
!  -- Reference BLAS level3 routine --
!  -- Reference BLAS is a software package provided by Univ. of Tennessee,    --
!  -- Univ. of California Berkeley, Univ. of Colorado Denver and NAG Ltd..--
!
!     .. Scalar Arguments ..
  CHARACTER, INTENT(IN) :: SIDE, UPLO
  INTEGER, INTENT(IN) :: M, N, LDA, LDB, LDC
  COMPLEX(KIND=BLAS_REAL_KIND), INTENT(IN) :: ALPHA, BETA
!     ..
!     .. Array Arguments ..
  COMPLEX(KIND=BLAS_REAL_KIND), INTENT(IN) :: A(LDA,*), B(LDB,*)
  COMPLEX(KIND=BLAS_REAL_KIND), INTENT(INOUT) :: C(LDC,*)
!     ..
!
!  =====================================================================
!
!     ..
!     .. Local Scalars ..
  COMPLEX(KIND=BLAS_REAL_KIND) :: TEMP1, TEMP2
  INTEGER :: I, INFO, J, K, NROWA
  LOGICAL :: UPPER
!     ..
!     .. Parameters ..
  COMPLEX(KIND=BLAS_REAL_KIND), PARAMETER :: ONE = CMPLX(1.0, 0.0, BLAS_REAL_KIND), ZERO = CMPLX(0.0, 0.0, BLAS_REAL_KIND)
!     ..
!
!     Set NROWA as the number of rows of A.
!
  IF (LSAME(SIDE, 'L')) THEN
     NROWA = M
  ELSE
     NROWA = N
  END IF
  UPPER = LSAME(UPLO, 'U')
!
!     Test the input parameters.
!
  INFO = 0
  IF ((.NOT. LSAME(SIDE, 'L')) .AND. (.NOT. LSAME(SIDE, 'R'))) THEN
     INFO = 1
  ELSE IF ((.NOT. UPPER) .AND. (.NOT. LSAME(UPLO, 'L'))) THEN
     INFO = 2
  ELSE IF (M .LT. 0) THEN
     INFO = 3
  ELSE IF (N .LT. 0) THEN
     INFO = 4
  ELSE IF (LDA .LT. MAX(1,NROWA)) THEN
     INFO = 7
  ELSE IF (LDB .LT. MAX(1,M)) THEN
     INFO = 9
  ELSE IF (LDC .LT. MAX(1,M)) THEN
     INFO = 12
  END IF
  IF (INFO .NE. 0) THEN
     CALL XERBLA('HHEMM', INFO)
     RETURN
  END IF
!
!     Quick return if possible.
!
  IF ((M .EQ. 0) .OR. (N .EQ. 0) .OR. ((ALPHA .EQ. ZERO) .AND. (BETA .EQ. ONE))) RETURN
!
!     And when  alpha.eq.zero.
!
  IF (ALPHA .EQ. ZERO) THEN
     IF (BETA .EQ. ZERO) THEN
        DO J = 1, N
           DO I = 1, M
              C(I,J) = ZERO
           END DO
        END DO
     ELSE
        DO J = 1, N
           DO I = 1, M
              C(I,J) = HMUL(BETA, C(I,J))
           END DO
        END DO
     END IF
     RETURN
  END IF
!
!     Start the operations.
!
  IF (LSAME(SIDE, 'L')) THEN
!
!        Form  C := alpha*A*B + beta*C.
!
     IF (UPPER) THEN
        DO J = 1, N
           DO I = 1, M
              TEMP1 = HMUL(ALPHA, B(I,J))
              TEMP2 = ZERO
              DO K = 1, I-1
                 C(K,J) = HFMA(TEMP1, A(K,I), C(K,J))
                 TEMP2 = HFMA(B(K,J), CONJG(A(K,I)), TEMP2)
              END DO
              TEMP1 = CMPLX(REAL(TEMP1) * REAL(A(I,I)), AIMAG(TEMP1) * REAL(A(I,I)), BLAS_REAL_KIND)
              IF (BETA .EQ. ZERO) THEN
                 C(I,J) = HFMA(ALPHA, TEMP2, TEMP1)
              ELSE
                 C(I,J) = HFMA(ALPHA, TEMP2, HFMA(BETA, C(I,J), TEMP1))
              END IF
           END DO
        END DO
     ELSE
        DO J = 1, N
           DO I = M, 1, -1
              TEMP1 = HMUL(ALPHA, B(I,J))
              TEMP2 = ZERO
              DO K = I+1, M
                 C(K,J) = HFMA(TEMP1, A(K,I), C(K,J))
                 TEMP2 = HFMA(B(K,J), CONJG(A(K,I)), TEMP2)
              END DO
              TEMP1 = CMPLX(REAL(TEMP1) * REAL(A(I,I)), AIMAG(TEMP1) * REAL(A(I,I)), BLAS_REAL_KIND)
              IF (BETA .EQ. ZERO) THEN
                 C(I,J) = HFMA(ALPHA, TEMP2, TEMP1)
              ELSE
                 C(I,J) = HFMA(ALPHA, TEMP2, HFMA(BETA, C(I,J), TEMP1))
              END IF
           END DO
        END DO
     END IF
  ELSE
!
!        Form  C := alpha*B*A + beta*C.
!
     DO J = 1, N
        TEMP1 = CMPLX(REAL(ALPHA) * REAL(A(J,J)), AIMAG(ALPHA) * REAL(A(J,J)), BLAS_REAL_KIND)
        IF (BETA .EQ. ZERO) THEN
           DO I = 1, M
              C(I,J) = HMUL(TEMP1, B(I,J))
           END DO
        ELSE
           DO I = 1, M
              C(I,J) = HFMMA(BETA, C(I,J), TEMP1, B(I,J))
           END DO
        END IF
        DO K = 1, J-1
           IF (UPPER) THEN
              TEMP1 = HMUL(ALPHA, A(K,J))
           ELSE
              TEMP1 = HMUL(ALPHA, CONJG(A(J,K)))
           END IF
           DO I = 1, M
              C(I,J) = HFMA(TEMP1, B(I,K), C(I,J))
           END DO
        END DO
        DO K = J+1, N
           IF (UPPER) THEN
              TEMP1 = HMUL(ALPHA, CONJG(A(J,K)))
           ELSE
              TEMP1 = HMUL(ALPHA, A(K,J))
           END IF
           DO I = 1, M
              C(I,J) = HFMA(TEMP1, B(I,K), C(I,J))
           END DO
        END DO
     END DO
  END IF
!
!     End of HHEMM
!
END SUBROUTINE HHEMM
