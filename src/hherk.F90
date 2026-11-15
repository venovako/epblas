!> \brief \b HHERK
!
!  =========== DOCUMENTATION ===========
!
! Online html documentation available at
!            http://www.netlib.org/lapack/explore-html/
!
!  Definition:
!  ===========
!
!       SUBROUTINE HHERK(UPLO,TRANS,N,K,ALPHA,A,LDA,BETA,C,LDC)
!
!       .. Scalar Arguments ..
!       REAL ALPHA,BETA
!       INTEGER K,LDA,LDC,N
!       CHARACTER TRANS,UPLO
!       ..
!       .. Array Arguments ..
!       COMPLEX A(LDA,*),C(LDC,*)
!       ..
!
!
!> \par Purpose:
!  =============
!>
!> \verbatim
!>
!> HHERK  performs one of the hermitian rank k operations
!>
!>    C := alpha*A*A**H + beta*C,
!>
!> or
!>
!>    C := alpha*A**H*A + beta*C,
!>
!> where  alpha and beta  are  real scalars,  C is an  n by n  hermitian
!> matrix and  A  is an  n by k  matrix in the  first case and a  k by n
!> matrix in the second case.
!> \endverbatim
!
!  Arguments:
!  ==========
!
!> \param[in] UPLO
!> \verbatim
!>          UPLO is CHARACTER*1
!>           On  entry,   UPLO  specifies  whether  the  upper  or  lower
!>           triangular  part  of the  array  C  is to be  referenced  as
!>           follows:
!>
!>              UPLO = 'U' or 'u'   Only the  upper triangular part of  C
!>                                  is to be referenced.
!>
!>              UPLO = 'L' or 'l'   Only the  lower triangular part of  C
!>                                  is to be referenced.
!> \endverbatim
!>
!> \param[in] TRANS
!> \verbatim
!>          TRANS is CHARACTER*1
!>           On entry,  TRANS  specifies the operation to be performed as
!>           follows:
!>
!>              TRANS = 'N' or 'n'   C := alpha*A*A**H + beta*C.
!>
!>              TRANS = 'C' or 'c'   C := alpha*A**H*A + beta*C.
!> \endverbatim
!>
!> \param[in] N
!> \verbatim
!>          N is INTEGER
!>           On entry,  N specifies the order of the matrix C.  N must be
!>           at least zero.
!> \endverbatim
!>
!> \param[in] K
!> \verbatim
!>          K is INTEGER
!>           On entry with  TRANS = 'N' or 'n',  K  specifies  the number
!>           of  columns   of  the   matrix   A,   and  on   entry   with
!>           TRANS = 'C' or 'c',  K  specifies  the number of rows of the
!>           matrix A.  K must be at least zero.
!> \endverbatim
!>
!> \param[in] ALPHA
!> \verbatim
!>          ALPHA is REAL
!>           On entry, ALPHA specifies the scalar alpha.
!> \endverbatim
!>
!> \param[in] A
!> \verbatim
!>          A is COMPLEX array, dimension ( LDA, ka ), where ka is
!>           k  when  TRANS = 'N' or 'n',  and is  n  otherwise.
!>           Before entry with  TRANS = 'N' or 'n',  the  leading  n by k
!>           part of the array  A  must contain the matrix  A,  otherwise
!>           the leading  k by n  part of the array  A  must contain  the
!>           matrix A.
!> \endverbatim
!>
!> \param[in] LDA
!> \verbatim
!>          LDA is INTEGER
!>           On entry, LDA specifies the first dimension of A as declared
!>           in  the  calling  (sub)  program.   When  TRANS = 'N' or 'n'
!>           then  LDA must be at least  max( 1, n ), otherwise  LDA must
!>           be at least  max( 1, k ).
!> \endverbatim
!>
!> \param[in] BETA
!> \verbatim
!>          BETA is REAL
!>           On entry, BETA specifies the scalar beta.
!> \endverbatim
!>
!> \param[in,out] C
!> \verbatim
!>          C is COMPLEX array, dimension ( LDC, N )
!>           Before entry  with  UPLO = 'U' or 'u',  the leading  n by n
!>           upper triangular part of the array C must contain the upper
!>           triangular part  of the  hermitian matrix  and the strictly
!>           lower triangular part of C is not referenced.  On exit, the
!>           upper triangular part of the array  C is overwritten by the
!>           upper triangular part of the updated matrix.
!>           Before entry  with  UPLO = 'L' or 'l',  the leading  n by n
!>           lower triangular part of the array C must contain the lower
!>           triangular part  of the  hermitian matrix  and the strictly
!>           upper triangular part of C is not referenced.  On exit, the
!>           lower triangular part of the array  C is overwritten by the
!>           lower triangular part of the updated matrix.
!>           Note that the imaginary parts of the diagonal elements need
!>           not be set,  they are assumed to be zero,  and on exit they
!>           are set to zero.
!> \endverbatim
!>
!> \param[in] LDC
!> \verbatim
!>          LDC is INTEGER
!>           On entry, LDC specifies the first dimension of C as declared
!>           in  the  calling  (sub)  program.   LDC  must  be  at  least
!>           max( 1, n ).
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
!> \ingroup herk
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
!>
!>  -- Modified 8-Nov-93 to set C(J,J) to REAL( C(J,J) ) when BETA = 1.
!>     Ed Anderson, Cray Research Inc.
!> \endverbatim
!>
!  =====================================================================
PURE SUBROUTINE HHERK(UPLO, TRANS, N, K, ALPHA, A, LDA, BETA, C, LDC)
  IMPLICIT NONE
#ifdef GFMMA
  INTERFACE
     ELEMENTAL FUNCTION GFMMA(A, B, C, D)
       IMPLICIT NONE
       REAL(KIND=BLAS_REAL_KIND), INTENT(IN) :: A, B, C, D
       REAL(KIND=BLAS_REAL_KIND) :: GFMMA
     END FUNCTION GFMMA
  END INTERFACE
#else
#define GFMMA(A,B,C,D) ((A)*(B)+(C)*(D))
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
  CHARACTER, INTENT(IN) :: UPLO, TRANS
  INTEGER, INTENT(IN) :: N, K, LDA, LDC
  REAL(KIND=BLAS_REAL_KIND), INTENT(IN) :: ALPHA, BETA
!     ..
!     .. Array Arguments ..
  COMPLEX(KIND=BLAS_REAL_KIND), INTENT(IN) :: A(LDA,*)
  COMPLEX(KIND=BLAS_REAL_KIND), INTENT(INOUT) :: C(LDC,*)
!     ..
!
!  =====================================================================
!
!     ..
!     .. Local Scalars ..
  COMPLEX(KIND=BLAS_REAL_KIND) :: TEMP
  REAL(KIND=BLAS_REAL_KIND) :: RTEMP
  INTEGER :: I, INFO, J, L, NROWA
  LOGICAL :: UPPER
!     ..
!     .. Parameters ..
  REAL(KIND=BLAS_REAL_KIND), PARAMETER :: ONE = 1.0, ZERO = 0.0
!     ..
!
!     Test the input parameters.
!
  IF (LSAME(TRANS, 'N')) THEN
     NROWA = N
  ELSE
     NROWA = K
  END IF
  UPPER = LSAME(UPLO, 'U')
!
  INFO = 0
  IF ((.NOT. UPPER) .AND. (.NOT. LSAME(UPLO, 'L'))) THEN
     INFO = 1
  ELSE IF ((.NOT. LSAME(TRANS, 'N')) .AND. (.NOT. LSAME(TRANS, 'C'))) THEN
     INFO = 2
  ELSE IF (N .LT. 0) THEN
     INFO = 3
  ELSE IF (K .LT. 0) THEN
     INFO = 4
  ELSE IF (LDA .LT. MAX(1, NROWA)) THEN
     INFO = 7
  ELSE IF (LDC .LT. MAX(1, N)) THEN
     INFO = 10
  END IF
  IF (INFO .NE. 0) THEN
     CALL XERBLA('HHERK', INFO)
     RETURN
  END IF
!
!     Quick return if possible.
!
  IF ((N .EQ. 0) .OR. (((ALPHA .EQ. ZERO) .OR. (K .EQ. 0)) .AND. (BETA .EQ. ONE))) RETURN
!
!     And when  alpha.eq.zero.
!
  IF (ALPHA .EQ. ZERO) THEN
     IF (UPPER) THEN
        IF (BETA .EQ. ZERO) THEN
           DO J = 1, N
              DO I = 1, J
                 C(I,J) = ZERO
              END DO
           END DO
        ELSE
           DO J = 1, N
              DO I = 1, J-1
                 C(I,J) = CMPLX(BETA * REAL(C(I,J)), BETA * AIMAG(C(I,J)), BLAS_REAL_KIND)
              END DO
              C(J,J) = BETA * REAL(C(J,J))
           END DO
        END IF
     ELSE
        IF (BETA .EQ. ZERO) THEN
           DO J = 1, N
              DO I = J, N
                 C(I,J) = ZERO
              END DO
           END DO
        ELSE
           DO J = 1, N
              C(J,J) = BETA * REAL(C(J,J))
              DO I = J+1, N
                 C(I,J) = CMPLX(BETA * REAL(C(I,J)), BETA * AIMAG(C(I,J)), BLAS_REAL_KIND)
              END DO
           END DO
        END IF
     END IF
     RETURN
  END IF
!
!     Start the operations.
!
  IF (LSAME(TRANS, 'N')) THEN
!
!        Form  C := alpha*A*A**H + beta*C.
!
     IF (UPPER) THEN
        DO J = 1, N
           IF (BETA .EQ. ZERO) THEN
              DO I = 1, J
                 C(I,J) = ZERO
              END DO
           ELSE IF (BETA .NE. ONE) THEN
              DO I = 1, J-1
                 C(I,J) = CMPLX(BETA * REAL(C(I,J)), BETA * AIMAG(C(I,J)), BLAS_REAL_KIND)
              END DO
              C(J,J) = BETA * REAL(C(J,J))
           ELSE
              C(J,J) = REAL(C(J,J))
           END IF
           DO L = 1, K
              IF (A(J,L) .NE. CMPLX(ZERO, ZERO, BLAS_REAL_KIND)) THEN
                 TEMP = CMPLX(ALPHA * REAL(A(J,L)), -ALPHA * AIMAG(A(J,L)), BLAS_REAL_KIND)
                 DO I = 1, J-1
                    C(I,J) = HFMA(TEMP, A(I,L), C(I,J))
                 END DO
                 C(J,J) = REAL(HFMA(TEMP, A(I,L), C(J,J)))
              END IF
           END DO
        END DO
     ELSE
        DO J = 1, N
           IF (BETA .EQ. ZERO) THEN
              DO I = J, N
                 C(I,J) = ZERO
              END DO
           ELSE IF (BETA .NE. ONE) THEN
              C(J,J) = BETA * REAL(C(J,J))
              DO I = J+1, N
                 C(I,J) = CMPLX(BETA * REAL(C(I,J)), BETA * AIMAG(C(I,J)), BLAS_REAL_KIND)
              END DO
           ELSE
              C(J,J) = REAL(C(J,J))
           END IF
           DO L = 1, K
              IF (A(J,L) .NE. CMPLX(ZERO, ZERO, BLAS_REAL_KIND)) THEN
                 TEMP = CMPLX(ALPHA * REAL(A(J,L)), -ALPHA * AIMAG(A(J,L)), BLAS_REAL_KIND)
                 C(J,J) = REAL(HFMA(TEMP, A(J,L), C(J,J)))
                 DO I = J+1, N
                    C(I,J) = HFMA(TEMP, A(I,L), C(I,J))
                 END DO
              END IF
           END DO
        END DO
     END IF
  ELSE
!
!        Form  C := alpha*A**H*A + beta*C.
!
     IF (UPPER) THEN
        DO J = 1, N
           DO I = 1, J-1
              TEMP = ZERO
              DO L = 1, K
                 TEMP = HFMA(CONJG(A(L,I)), A(L,J), TEMP)
              END DO
              IF (BETA .EQ. ZERO) THEN
                 C(I,J) = CMPLX(ALPHA * REAL(TEMP), ALPHA * AIMAG(TEMP), BLAS_REAL_KIND)
              ELSE
                 C(I,J) = CMPLX(GFMMA(ALPHA, REAL(TEMP), BETA, REAL(C(I,J))), GFMMA(ALPHA, AIMAG(TEMP), BETA, AIMAG(C(I,J))), BLAS_REAL_KIND)
              END IF
           END DO
           RTEMP = ZERO
           DO L = 1, K
              RTEMP = REAL(HFMA(CONJG(A(L,J)), A(L,J), CMPLX(RTEMP, ZERO, BLAS_REAL_KIND)))
           END DO
           IF (BETA .EQ. ZERO) THEN
              C(J,J) = ALPHA * RTEMP
           ELSE
              C(J,J) = GFMMA(ALPHA, RTEMP, BETA, REAL(C(J,J)))
           END IF
        END DO
     ELSE
        DO J = 1, N
           RTEMP = ZERO
           DO L = 1, K
              RTEMP = REAL(HFMA(CONJG(A(L,J)), A(L,J), CMPLX(RTEMP, ZERO, BLAS_REAL_KIND)))
           END DO
           IF (BETA .EQ. ZERO) THEN
              C(J,J) = ALPHA * RTEMP
           ELSE
              C(J,J) = GFMMA(ALPHA, RTEMP, BETA, REAL(C(J,J)))
           END IF
           DO I = J+1, N
              TEMP = ZERO
              DO L = 1, K
                 TEMP = HFMA(CONJG(A(L,I)), A(L,J), TEMP)
              END DO
              IF (BETA .EQ. ZERO) THEN
                 C(I,J) = ALPHA * TEMP
              ELSE
                 C(I,J) = CMPLX(GFMMA(ALPHA, REAL(TEMP), BETA, REAL(C(I,J))), GFMMA(ALPHA, AIMAG(TEMP), BETA, AIMAG(C(I,J))), BLAS_REAL_KIND)
              END IF
           END DO
        END DO
     END IF
  END IF
!
!     End of HHERK
!
END SUBROUTINE HHERK
