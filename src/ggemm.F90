!> \brief \b GGEMM
!
!  =========== DOCUMENTATION ===========
!
! Online html documentation available at
!            http://www.netlib.org/lapack/explore-html/
!
!  Definition:
!  ===========
!
!       SUBROUTINE GGEMM(TRANSA,TRANSB,M,N,K,ALPHA,A,LDA,B,LDB,BETA,C,LDC)
!
!       .. Scalar Arguments ..
!       REAL ALPHA,BETA
!       INTEGER K,LDA,LDB,LDC,M,N
!       CHARACTER TRANSA,TRANSB
!       ..
!       .. Array Arguments ..
!       REAL A(LDA,*),B(LDB,*),C(LDC,*)
!       ..
!
!
!> \par Purpose:
!  =============
!>
!> \verbatim
!>
!> GGEMM  performs one of the matrix-matrix operations
!>
!>    C := alpha*op( A )*op( B ) + beta*C,
!>
!> where  op( X ) is one of
!>
!>    op( X ) = X   or   op( X ) = X**T,
!>
!> alpha and beta are scalars, and A, B and C are matrices, with op( A )
!> an m by k matrix,  op( B )  a  k by n matrix and  C an m by n matrix.
!>
!> Note: if alpha and/or beta is zero, some parts of the matrix-matrix
!>  operations are not performed. This results in the following NaN/Inf
!>  propagation quirks:
!>
!>  1. If alpha is zero, NaNs or Infs in A or B do not affect the result.
!>  2. If both alpha and beta are zero, then a zero matrix is returned in C,
!>   irrespective of any NaNs or Infs in A, B or C.
!>  3. If only beta is zero, alpha*op( A )*op( B ) is returned, irrespective
!>   of any NaNs or Infs in C.
!> \endverbatim
!
!  Arguments:
!  ==========
!
!> \param[in] TRANSA
!> \verbatim
!>          TRANSA is CHARACTER*1
!>           On entry, TRANSA specifies the form of op( A ) to be used in
!>           the matrix multiplication as follows:
!>
!>              TRANSA = 'N' or 'n',  op( A ) = A.
!>
!>              TRANSA = 'T' or 't',  op( A ) = A**T.
!>
!>              TRANSA = 'C' or 'c',  op( A ) = A**T.
!>
!>           Note: TRANSA = 'C' is supported for the sake of API consistency
!>           between all ?GEMM variants.
!> \endverbatim
!>
!> \param[in] TRANSB
!> \verbatim
!>          TRANSB is CHARACTER*1
!>           On entry, TRANSB specifies the form of op( B ) to be used in
!>           the matrix multiplication as follows:
!>
!>              TRANSB = 'N' or 'n',  op( B ) = B.
!>
!>              TRANSB = 'T' or 't',  op( B ) = B**T.
!>
!>              TRANSB = 'C' or 'c',  op( B ) = B**T.
!>
!>           Note: TRANSB = 'C' is supported for the sake of API consistency
!>           between all ?GEMM variants.
!> \endverbatim
!>
!> \param[in] M
!> \verbatim
!>          M is INTEGER
!>           On entry,  M  specifies  the number  of rows  of the  matrix
!>           op( A )  and of the  matrix  C.  M  must  be at least  zero.
!> \endverbatim
!>
!> \param[in] N
!> \verbatim
!>          N is INTEGER
!>           On entry,  N  specifies the number  of columns of the matrix
!>           op( B ) and the number of columns of the matrix C. N must be
!>           at least zero.
!> \endverbatim
!>
!> \param[in] K
!> \verbatim
!>          K is INTEGER
!>           On entry,  K  specifies  the number of columns of the matrix
!>           op( A ) and the number of rows of the matrix op( B ). K must
!>           be at least  zero.
!> \endverbatim
!>
!> \param[in] ALPHA
!> \verbatim
!>          ALPHA is REAL
!>           On entry, ALPHA specifies the scalar alpha. If ALPHA is zero the
!>           values in A and B do not affect the result. This also means that
!>           NaN/Inf propagation from A and B is inhibited if ALPHA is zero.
!> \endverbatim
!>
!> \param[in] A
!> \verbatim
!>          A is REAL array, dimension ( LDA, ka ), where ka is
!>           k  when  TRANSA = 'N' or 'n',  and is  m  otherwise.
!>           Before entry with  TRANSA = 'N' or 'n',  the leading  m by k
!>           part of the array  A  must contain the matrix  A,  otherwise
!>           the leading  k by m  part of the array  A  must contain  the
!>           matrix A, except if ALPHA is zero.
!>           If ALPHA is zero, none of the values in A affect the result, even
!>           if they are NaN/Inf. This also implies that if ALPHA is zero,
!>           the matrix elements of A need not be initialized by the caller.
!> \endverbatim
!>
!> \param[in] LDA
!> \verbatim
!>          LDA is INTEGER
!>           On entry, LDA specifies the first dimension of A as declared
!>           in the calling (sub) program. When  TRANSA = 'N' or 'n' then
!>           LDA must be at least  max( 1, m ), otherwise  LDA must be at
!>           least  max( 1, k ).
!> \endverbatim
!>
!> \param[in] B
!> \verbatim
!>          B is REAL array, dimension ( LDB, kb ), where kb is
!>           n  when  TRANSB = 'N' or 'n',  and is  k  otherwise.
!>           Before entry with  TRANSB = 'N' or 'n',  the leading  k by n
!>           part of the array  B  must contain the matrix  B,  otherwise
!>           the leading  n by k  part of the array  B  must contain  the
!>           matrix B, except if ALPHA is zero.
!>           If ALPHA is zero, none of the values in B affect the result, even
!>           if they are NaN/Inf. This also implies that if ALPHA is zero,
!>           the matrix elements of B need not be initialized by the caller.
!> \endverbatim
!>
!> \param[in] LDB
!> \verbatim
!>          LDB is INTEGER
!>           On entry, LDB specifies the first dimension of B as declared
!>           in the calling (sub) program. When  TRANSB = 'N' or 'n' then
!>           LDB must be at least  max( 1, k ), otherwise  LDB must be at
!>           least  max( 1, n ).
!> \endverbatim
!>
!> \param[in] BETA
!> \verbatim
!>          BETA is REAL
!>           On entry,  BETA  specifies the scalar  beta.  If BETA is zero the
!>           values in C do not affect the result. This also means that
!>           NaN/Inf propagation from C is inhibited if BETA is zero.
!> \endverbatim
!>
!> \param[in,out] C
!> \verbatim
!>          C is REAL array, dimension ( LDC, N )
!>           Before entry, the leading  m by n  part of the array  C must
!>           contain the matrix  C, except if beta is zero.
!>           If beta is zero, none of the values in C affect the result, even
!>           if they are NaN/Inf. This also implies that if beta is zero,
!>           the matrix elements of C need not be initialized by the caller.
!>           On exit, the array  C  is overwritten by the  m by n  matrix
!>           ( alpha*op( A )*op( B ) + beta*C ).
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
!> \ingroup gemm
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
SUBROUTINE GGEMM(TRANSA, TRANSB, M, N, K, ALPHA, A, LDA, B, LDB, BETA, C, LDC)
#ifdef USE_IEEE_INTRINSIC
  USE, INTRINSIC :: IEEE_ARITHMETIC, ONLY: IEEE_FMA
#define GFMA IEEE_FMA
#endif
  IMPLICIT NONE
#ifndef USE_IEEE_INTRINSIC
#if ((BLAS_REAL_KIND == 4) && ((HAVE_FMA & 1) == 0))
  INTERFACE
     PURE FUNCTION GFMA(A, B, C) BIND(C,NAME='fmaf')
       IMPLICIT NONE
       REAL(KIND=BLAS_REAL_KIND), INTENT(IN), VALUE :: A, B, C
       REAL(KIND=BLAS_REAL_KIND) :: GFMA
     END FUNCTION GFMA
  END INTERFACE
#elif ((BLAS_REAL_KIND == 8) && ((HAVE_FMA & 2) == 0))
  INTERFACE
     PURE FUNCTION GFMA(A, B, C) BIND(C,NAME='fma')
       IMPLICIT NONE
       REAL(KIND=BLAS_REAL_KIND), INTENT(IN), VALUE :: A, B, C
       REAL(KIND=BLAS_REAL_KIND) :: GFMA
     END FUNCTION GFMA
  END INTERFACE
#elif ((BLAS_REAL_KIND == 10) && ((HAVE_FMA & 4) == 0))
  INTERFACE
     PURE FUNCTION GFMA(A, B, C) BIND(C,NAME='fmal')
       IMPLICIT NONE
       REAL(KIND=BLAS_REAL_KIND), INTENT(IN), VALUE :: A, B, C
       REAL(KIND=BLAS_REAL_KIND) :: GFMA
     END FUNCTION GFMA
  END INTERFACE
#elif ((BLAS_REAL_KIND == 16) && ((HAVE_FMA & 8) == 0))
  INTERFACE
#ifdef __GFORTRAN__
     PURE FUNCTION GFMA(A, B, C) BIND(C,NAME='fmaq')
#else
     PURE FUNCTION GFMA(A, B, C) BIND(C,NAME='__fmaq')
#endif
       IMPLICIT NONE
       REAL(KIND=BLAS_REAL_KIND), INTENT(IN), VALUE :: A, B, C
       REAL(KIND=BLAS_REAL_KIND) :: GFMA
     END FUNCTION GFMA
  END INTERFACE
#else
#define GFMA(A,B,C) ((A)*(B)+(C))
#endif
#endif
#define GFMMA(A,B,C,D) ((A)*(B)+(C)*(D))
  INTERFACE
     PURE FUNCTION LSAME(CA, CB)
       IMPLICIT NONE
       CHARACTER, INTENT(IN) :: CA, CB
       LOGICAL :: LSAME
     END FUNCTION LSAME
  END INTERFACE
  INTERFACE
     SUBROUTINE XERBLA(SRNAME, INFO)
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
  CHARACTER, INTENT(IN) :: TRANSA, TRANSB
  INTEGER, INTENT(IN) :: M, N, K, LDA, LDB, LDC
  REAL(KIND=BLAS_REAL_KIND), INTENT(IN) :: ALPHA, BETA
!     ..
!     .. Array Arguments ..
  REAL(KIND=BLAS_REAL_KIND), INTENT(IN) :: A(LDA,*), B(LDB,*)
  REAL(KIND=BLAS_REAL_KIND), INTENT(INOUT) :: C(LDC,*)
!     ..
!
!  =====================================================================
!
!     ..
!     .. Local Scalars ..
  REAL(KIND=BLAS_REAL_KIND) :: TEMP
  INTEGER :: I, INFO, J, L, NROWA, NROWB
  LOGICAL :: NOTA, NOTB
!     ..
!     .. Parameters ..
  REAL(KIND=BLAS_REAL_KIND), PARAMETER :: ZERO = 0.0, ONE = 1.0
!     ..
!
!     Set  NOTA  and  NOTB  as  true if  A  and  B  respectively are not
!     transposed and set  NROWA and NROWB  as the number of rows of  A
!     and  B  respectively.
!
  NOTA = LSAME(TRANSA, 'N')
  NOTB = LSAME(TRANSB, 'N')
  IF (NOTA) THEN
     NROWA = M
  ELSE
     NROWA = K
  END IF
  IF (NOTB) THEN
     NROWB = K
  ELSE
     NROWB = N
  END IF
!
!     Test the input parameters.
!
  INFO = 0
  IF ((.NOT. NOTA) .AND. (.NOT. LSAME(TRANSA, 'C')) .AND. (.NOT. LSAME(TRANSA, 'T'))) THEN
     INFO = 1
  ELSE IF ((.NOT. NOTB) .AND. (.NOT. LSAME(TRANSB, 'C')) .AND. (.NOT. LSAME(TRANSB, 'T'))) THEN
     INFO = 2
  ELSE IF (M .LT. 0) THEN
     INFO = 3
  ELSE IF (N .LT. 0) THEN
     INFO = 4
  ELSE IF (K .LT. 0) THEN
     INFO = 5
  ELSE IF (LDA .LT. MAX(1, NROWA)) THEN
     INFO = 8
  ELSE IF (LDB .LT. MAX(1, NROWB)) THEN
     INFO = 10
  ELSE IF (LDC .LT. MAX(1, M)) THEN
     INFO = 13
  END IF
  IF (INFO .NE. 0) THEN
     CALL XERBLA('GGEMM', INFO)
     RETURN
  END IF
!
!     Quick return if possible.
!
  IF ((M .EQ. 0) .OR. (N .EQ. 0) .OR. (((ALPHA .EQ. ZERO) .OR. (K .EQ. 0)) .AND. (BETA .EQ. ONE))) RETURN
!
!     And if  alpha.eq.zero.
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
              C(I,J) = BETA * C(I,J)
           END DO
        END DO
     END IF
     RETURN
  END IF
!
!     Start the operations.
!
  IF (NOTB) THEN
     IF (NOTA) THEN
!
!           Form  C := alpha*A*B + beta*C.
!
        DO J = 1, N
           IF (BETA .EQ. ZERO) THEN
              DO I = 1, M
                 C(I,J) = ZERO
              END DO
           ELSE IF (BETA .NE. ONE) THEN
              DO I = 1, M
                 C(I,J) = BETA * C(I,J)
              END DO
           END IF
           DO L = 1, K
              TEMP = ALPHA * B(L,J)
              DO I = 1, M
                 C(I,J) = GFMA(TEMP, A(I,L), C(I,J))
              END DO
           END DO
        END DO
     ELSE
!
!           Form  C := alpha*A**T*B + beta*C
!
        DO J = 1, N
           DO I = 1, M
              TEMP = ZERO
              DO L = 1, K
                 TEMP = GFMA(A(L,I), B(L,J), TEMP)
              END DO
              IF (BETA .EQ. ZERO) THEN
                 C(I,J) = ALPHA * TEMP
              ELSE
                 C(I,J) = GFMMA(ALPHA, TEMP, BETA, C(I,J))
              END IF
           END DO
        END DO
     END IF
  ELSE
     IF (NOTA) THEN
!
!           Form  C := alpha*A*B**T + beta*C
!
        DO J = 1, N
           IF (BETA .EQ. ZERO) THEN
              DO I = 1, M
                 C(I,J) = ZERO
              END DO
           ELSE IF (BETA .NE. ONE) THEN
              DO I = 1, M
                 C(I,J) = BETA * C(I,J)
              END DO
           END IF
           DO L = 1, K
              TEMP = ALPHA * B(J,L)
              DO I = 1, M
                 C(I,J) = GFMA(TEMP, A(I,L), C(I,J))
              END DO
           END DO
        END DO
     ELSE
!
!           Form  C := alpha*A**T*B**T + beta*C
!
        DO J = 1, N
           DO I = 1, M
              TEMP = ZERO
              DO L = 1, K
                 TEMP = GFMA(A(L,I), B(J,L), TEMP)
              END DO
              IF (BETA .EQ. ZERO) THEN
                 C(I,J) = ALPHA * TEMP
              ELSE
                 C(I,J) = GFMMA(ALPHA, TEMP, BETA, C(I,J))
              END IF
           END DO
        END DO
     END IF
  END IF
!
!     End of GGEMM
!
END SUBROUTINE GGEMM
