!> \brief \b GGEMMTR
!
!  =========== DOCUMENTATION ===========
!
! Online html documentation available at
!            http://www.netlib.org/lapack/explore-html/
!
!  Definition:
!  ===========
!
!       SUBROUTINE GGEMMTR(UPLO,TRANSA,TRANSB,N,K,ALPHA,A,LDA,B,LDB,BETA,
!                         C,LDC)
!
!       .. Scalar Arguments ..
!       REAL ALPHA,BETA
!       INTEGER K,LDA,LDB,LDC,N
!       CHARACTER TRANSA,TRANSB, UPLO
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
!> GGEMMTR  performs one of the matrix-matrix operations
!>
!>    C := alpha*op( A )*op( B ) + beta*C,
!>
!> where  op( X ) is one of
!>
!>    op( X ) = X   or   op( X ) = X**T,
!>
!> alpha and beta are scalars, and A, B and C are matrices, with op( A )
!> an n by k matrix,  op( B )  a  k by n matrix and  C an n by n matrix.
!> Thereby, the routine only accesses and updates the upper or lower
!> triangular part of the result matrix C. This behaviour can be used if
!> the resulting matrix C is known to be symmetric.
!> \endverbatim
!
!  Arguments:
!  ==========
!
!> \param[in] UPLO
!> \verbatim
!>          UPLO is CHARACTER*1
!>           On entry, UPLO specifies whether the lower or the upper
!>           triangular part of C is access and updated.
!>
!>              UPLO = 'L' or 'l', the lower triangular part of C is used.
!>
!>              UPLO = 'U' or 'u', the upper triangular part of C is used.
!> \endverbatim
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
!> \endverbatim
!>
!> \param[in] N
!> \verbatim
!>          N is INTEGER
!>           On entry,  N specifies the number of rows and columns of
!>           the matrix C, the number of columns of op(B) and the number
!>           of rows of op(A).  N must be at least zero.
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
!>          ALPHA is REAL.
!>           On entry, ALPHA specifies the scalar alpha.
!> \endverbatim
!>
!> \param[in] A
!> \verbatim
!>          A is REAL array, dimension ( LDA, ka ), where ka is
!>           k  when  TRANSA = 'N' or 'n',  and is  n  otherwise.
!>           Before entry with  TRANSA = 'N' or 'n',  the leading  n by k
!>           part of the array  A  must contain the matrix  A,  otherwise
!>           the leading  k by m  part of the array  A  must contain  the
!>           matrix A.
!> \endverbatim
!>
!> \param[in] LDA
!> \verbatim
!>          LDA is INTEGER
!>           On entry, LDA specifies the first dimension of A as declared
!>           in the calling (sub) program. When  TRANSA = 'N' or 'n' then
!>           LDA must be at least  max( 1, n ), otherwise  LDA must be at
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
!>           matrix B.
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
!>          BETA is REAL.
!>           On entry,  BETA  specifies the scalar  beta.  When  BETA  is
!>           supplied as zero then C need not be set on input.
!> \endverbatim
!>
!> \param[in,out] C
!> \verbatim
!>          C is REAL array, dimension ( LDC, N )
!>           Before entry, the leading  n by n  part of the array  C must
!>           contain the matrix  C,  except when  beta  is zero, in which
!>           case C need not be set on entry.
!>           On exit, the upper or lower triangular part of the matrix
!>           C  is overwritten by the n by n matrix
!>           ( alpha*op( A )*op( B ) + beta*C ).
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
!> \author Martin Koehler
!> \author modified by venovako
!
!> \ingroup gemmtr
!
!> \par Further Details:
!  =====================
!>
!> \verbatim
!>
!>  Level 3 Blas routine.
!>
!>  -- Written on 19-July-2023.
!>     Martin Koehler, MPI Magdeburg
!> \endverbatim
!>
!  =====================================================================
SUBROUTINE GGEMMTR(UPLO, TRANSA, TRANSB, N, K, ALPHA, A, LDA, B, LDB, BETA, C, LDC)
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
  CHARACTER, INTENT(IN) :: UPLO, TRANSA, TRANSB
  INTEGER, INTENT(IN) :: N, K, LDA, LDB, LDC
  REAL(KIND=BLAS_REAL_KIND) :: ALPHA, BETA
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
  INTEGER :: I, INFO, J, L, NROWA, NROWB, ISTART, ISTOP
  LOGICAL :: NOTA, NOTB, UPPER
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
     NROWA = N
  ELSE
     NROWA = K
  END IF
  IF (NOTB) THEN
     NROWB = K
  ELSE
     NROWB = N
  END IF
  UPPER = LSAME(UPLO, 'U')
!
!     Test the input parameters.
!
  INFO = 0
  IF ((.NOT. UPPER) .AND. (.NOT. LSAME(UPLO, 'L'))) THEN
     INFO = 1
  ELSE IF ((.NOT. NOTA) .AND. (.NOT. LSAME(TRANSA, 'C')) .AND. (.NOT. LSAME(TRANSA, 'T'))) THEN
     INFO = 2
  ELSE IF ((.NOT. NOTB) .AND. (.NOT. LSAME(TRANSB, 'C')) .AND. (.NOT. LSAME(TRANSB, 'T'))) THEN
     INFO = 3
  ELSE IF (N .LT. 0) THEN
     INFO = 4
  ELSE IF (K .LT. 0) THEN
     INFO = 5
  ELSE IF (LDA .LT. MAX(1, NROWA)) THEN
     INFO = 8
  ELSE IF (LDB .LT. MAX(1, NROWB)) THEN
     INFO = 10
  ELSE IF (LDC .LT. MAX(1, N)) THEN
     INFO = 13
  END IF
  IF (INFO .NE. 0) THEN
     CALL XERBLA('GGEMMTR', INFO)
     RETURN
  END IF
!
!     Quick return if possible.
!
  IF (N .EQ. 0) RETURN
!
!     And if  alpha.eq.zero.
!
  IF (ALPHA .EQ. ZERO) THEN
     IF (BETA .EQ. ZERO) THEN
        DO J = 1, N
           IF (UPPER) THEN
              ISTART = 1
              ISTOP  = J
           ELSE
              ISTART = J
              ISTOP  = N
           END IF

           DO I = ISTART, ISTOP
              C(I,J) = ZERO
           END DO
        END DO
     ELSE
        DO J = 1, N
           IF (UPPER) THEN
              ISTART = 1
              ISTOP  = J
           ELSE
              ISTART = J
              ISTOP  = N
           END IF

           DO I = ISTART, ISTOP
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
           IF (UPPER) THEN
              ISTART = 1
              ISTOP  = J
           ELSE
              ISTART = J
              ISTOP  = N
           END IF
           IF (BETA .EQ. ZERO) THEN
              DO I = ISTART, ISTOP
                 C(I,J) = ZERO
              END DO
           ELSE IF (BETA .NE. ONE) THEN
              DO I = ISTART, ISTOP
                 C(I,J) = BETA * C(I,J)
              END DO
           END IF
           DO L = 1, K
              TEMP = ALPHA * B(L,J)
              DO I = ISTART, ISTOP
                 C(I,J) = GFMA(TEMP, A(I,L), C(I,J))
              END DO
           END DO
        END DO
     ELSE
!
!           Form  C := alpha*A**T*B + beta*C
!
        DO J = 1, N
           IF (UPPER) THEN
              ISTART = 1
              ISTOP  = J
           ELSE
              ISTART = J
              ISTOP  = N
           END IF

           DO I = ISTART, ISTOP
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
           IF (UPPER) THEN
              ISTART = 1
              ISTOP  = J
           ELSE
              ISTART = J
              ISTOP  = N
           END IF

           IF (BETA .EQ. ZERO) THEN
              DO I = ISTART, ISTOP
                 C(I,J) = ZERO
              END DO
           ELSE IF (BETA .NE. ONE) THEN
              DO I = ISTART, ISTOP
                 C(I,J) = BETA * C(I,J)
              END DO
           END IF
           DO L = 1, K
              TEMP = ALPHA * B(J,L)
              DO I = ISTART, ISTOP
                 C(I,J) = GFMA(TEMP, A(I,L), C(I,J))
              END DO
           END DO
        END DO
     ELSE
!
!           Form  C := alpha*A**T*B**T + beta*C
!
        DO J = 1, N
           IF (UPPER) THEN
              ISTART = 1
              ISTOP  = J
           ELSE
              ISTART = J
              ISTOP  = N
           END IF

           DO I = ISTART, ISTOP
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
!     End of GGEMMTR
!
END SUBROUTINE GGEMMTR
