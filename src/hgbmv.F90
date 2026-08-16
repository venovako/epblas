!> \brief \b HGBMV
!
!  =========== DOCUMENTATION ===========
!
! Online html documentation available at
!            http://www.netlib.org/lapack/explore-html/
!
!  Definition:
!  ===========
!
!       SUBROUTINE HGBMV(TRANS,M,N,KL,KU,ALPHA,A,LDA,X,INCX,BETA,Y,INCY)
!
!       .. Scalar Arguments ..
!       COMPLEX ALPHA,BETA
!       INTEGER INCX,INCY,KL,KU,LDA,M,N
!       CHARACTER TRANS
!       ..
!       .. Array Arguments ..
!       COMPLEX A(LDA,*),X(*),Y(*)
!       ..
!
!
!> \par Purpose:
!  =============
!>
!> \verbatim
!>
!> HGBMV  performs one of the matrix-vector operations
!>
!>    y := alpha*A*x + beta*y,   or   y := alpha*A**T*x + beta*y,   or
!>
!>    y := alpha*A**H*x + beta*y,
!>
!> where alpha and beta are scalars, x and y are vectors and A is an
!> m by n band matrix, with kl sub-diagonals and ku super-diagonals.
!> \endverbatim
!
!  Arguments:
!  ==========
!
!> \param[in] TRANS
!> \verbatim
!>          TRANS is CHARACTER*1
!>           On entry, TRANS specifies the operation to be performed as
!>           follows:
!>
!>              TRANS = 'N' or 'n'   y := alpha*A*x + beta*y.
!>
!>              TRANS = 'T' or 't'   y := alpha*A**T*x + beta*y.
!>
!>              TRANS = 'C' or 'c'   y := alpha*A**H*x + beta*y.
!> \endverbatim
!>
!> \param[in] M
!> \verbatim
!>          M is INTEGER
!>           On entry, M specifies the number of rows of the matrix A.
!>           M must be at least zero.
!> \endverbatim
!>
!> \param[in] N
!> \verbatim
!>          N is INTEGER
!>           On entry, N specifies the number of columns of the matrix A.
!>           N must be at least zero.
!> \endverbatim
!>
!> \param[in] KL
!> \verbatim
!>          KL is INTEGER
!>           On entry, KL specifies the number of sub-diagonals of the
!>           matrix A. KL must satisfy  0 .le. KL.
!> \endverbatim
!>
!> \param[in] KU
!> \verbatim
!>          KU is INTEGER
!>           On entry, KU specifies the number of super-diagonals of the
!>           matrix A. KU must satisfy  0 .le. KU.
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
!>          A is COMPLEX array, dimension ( LDA, N )
!>           Before entry, the leading ( kl + ku + 1 ) by n part of the
!>           array A must contain the matrix of coefficients, supplied
!>           column by column, with the leading diagonal of the matrix in
!>           row ( ku + 1 ) of the array, the first super-diagonal
!>           starting at position 2 in row ku, the first sub-diagonal
!>           starting at position 1 in row ( ku + 2 ), and so on.
!>           Elements in the array A that do not correspond to elements
!>           in the band matrix (such as the top left ku by ku triangle)
!>           are not referenced.
!>           The following program segment will transfer a band matrix
!>           from conventional full matrix storage to band storage:
!>
!>                 DO 20, J = 1, N
!>                    K = KU + 1 - J
!>                    DO 10, I = MAX( 1, J - KU ), MIN( M, J + KL )
!>                       A( K + I, J ) = matrix( I, J )
!>              10    CONTINUE
!>              20 CONTINUE
!> \endverbatim
!>
!> \param[in] LDA
!> \verbatim
!>          LDA is INTEGER
!>           On entry, LDA specifies the first dimension of A as declared
!>           in the calling (sub) program. LDA must be at least
!>           ( kl + ku + 1 ).
!> \endverbatim
!>
!> \param[in] X
!> \verbatim
!>          X is COMPLEX array, dimension at least
!>           ( 1 + ( n - 1 )*abs( INCX ) ) when TRANS = 'N' or 'n'
!>           and at least
!>           ( 1 + ( m - 1 )*abs( INCX ) ) otherwise.
!>           Before entry, the incremented array X must contain the
!>           vector x.
!> \endverbatim
!>
!> \param[in] INCX
!> \verbatim
!>          INCX is INTEGER
!>           On entry, INCX specifies the increment for the elements of
!>           X. INCX must not be zero.
!> \endverbatim
!>
!> \param[in] BETA
!> \verbatim
!>          BETA is COMPLEX
!>           On entry, BETA specifies the scalar beta. When BETA is
!>           supplied as zero then Y need not be set on input.
!> \endverbatim
!>
!> \param[in,out] Y
!> \verbatim
!>          Y is COMPLEX array, dimension at least
!>           ( 1 + ( m - 1 )*abs( INCY ) ) when TRANS = 'N' or 'n'
!>           and at least
!>           ( 1 + ( n - 1 )*abs( INCY ) ) otherwise.
!>           Before entry, the incremented array Y must contain the
!>           vector y. On exit, Y is overwritten by the updated vector y.
!>           If either m or n is zero, then Y not referenced and the function
!>           performs a quick return.
!> \endverbatim
!>
!> \param[in] INCY
!> \verbatim
!>          INCY is INTEGER
!>           On entry, INCY specifies the increment for the elements of
!>           Y. INCY must not be zero.
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
!> \ingroup gbmv
!
!> \par Further Details:
!  =====================
!>
!> \verbatim
!>
!>  Level 2 Blas routine.
!>  The vector and matrix arguments are not referenced when N = 0, or M = 0
!>
!>  -- Written on 22-October-1986.
!>     Jack Dongarra, Argonne National Lab.
!>     Jeremy Du Croz, Nag Central Office.
!>     Sven Hammarling, Nag Central Office.
!>     Richard Hanson, Sandia National Labs.
!> \endverbatim
!>
!  =====================================================================
SUBROUTINE HGBMV(TRANS, M, N, KL, KU, ALPHA, A, LDA, X, INCX, BETA, Y, INCY)
#define HMUL(A,B) ((A)*(B))
#define HFMA(A,B,C) ((A)*(B)+(C))
  IMPLICIT NONE
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
!  -- Reference BLAS level2 routine --
!  -- Reference BLAS is a software package provided by Univ. of Tennessee,    --
!  -- Univ. of California Berkeley, Univ. of Colorado Denver and NAG Ltd..--
!
!     .. Scalar Arguments ..
  CHARACTER, INTENT(IN) :: TRANS
  INTEGER, INTENT(IN) :: M, N, KL, KU, LDA, INCX, INCY
  COMPLEX(KIND=BLAS_REAL_KIND), INTENT(IN) :: ALPHA, BETA
!     ..
!     .. Array Arguments ..
  COMPLEX(KIND=BLAS_REAL_KIND), INTENT(IN) :: A(LDA,*), X(*)
  COMPLEX(KIND=BLAS_REAL_KIND), INTENT(INOUT) :: Y(*)
!     ..
!
!  =====================================================================
!
!     .. Parameters ..
  COMPLEX(KIND=BLAS_REAL_KIND), PARAMETER :: ONE = CMPLX(1.0, 0.0, BLAS_REAL_KIND)
  COMPLEX(KIND=BLAS_REAL_KIND), PARAMETER :: ZERO = CMPLX(0.0, 0.0, BLAS_REAL_KIND)
!     ..
!     .. Local Scalars ..
  COMPLEX(KIND=BLAS_REAL_KIND) :: TEMP
  INTEGER :: I, INFO, IX, IY, J, JX, JY, K, KUP1, KX, KY, LENX, LENY
  LOGICAL :: NOCONJ
!     ..
!
!     Test the input parameters.
!
  INFO = 0
  IF ((.NOT. LSAME(TRANS, 'N')) .AND. (.NOT. LSAME(TRANS, 'T')) .AND. (.NOT. LSAME(TRANS, 'C'))) THEN
     INFO = 1
  ELSE IF (M .LT. 0) THEN
     INFO = 2
  ELSE IF (N .LT. 0) THEN
     INFO = 3
  ELSE IF (KL .LT. 0) THEN
     INFO = 4
  ELSE IF (KU .LT. 0) THEN
     INFO = 5
  ELSE IF (LDA .LT. (KL + KU + 1)) THEN
     INFO = 8
  ELSE IF (INCX .EQ. 0) THEN
     INFO = 10
  ELSE IF (INCY .EQ. 0) THEN
     INFO = 13
  END IF
  IF (INFO .NE. 0) THEN
     CALL XERBLA('HGBMV', INFO)
     RETURN
  END IF
!
!     Quick return if possible.
!
  IF ((M .EQ. 0) .OR. (N .EQ. 0) .OR. ((ALPHA .EQ. ZERO) .AND. (BETA .EQ. ONE))) RETURN
!
  NOCONJ = LSAME(TRANS, 'T')
!
!     Set  LENX  and  LENY, the lengths of the vectors x and y, and set
!     up the start points in  X  and  Y.
!
  IF (LSAME(TRANS, 'N')) THEN
     LENX = N
     LENY = M
  ELSE
     LENX = M
     LENY = N
  END IF
  IF (INCX .GT. 0) THEN
     KX = 1
  ELSE
     KX = 1 - (LENX-1)*INCX
  END IF
  IF (INCY .GT. 0) THEN
     KY = 1
  ELSE
     KY = 1 - (LENY-1)*INCY
  END IF
!
!     Start the operations. In this version the elements of A are
!     accessed sequentially with one pass through the band part of A.
!
!     First form  y := beta*y.
!
  IF (BETA .NE. ONE) THEN
     IF (INCY .EQ. 1) THEN
        IF (BETA .EQ. ZERO) THEN
           DO I = 1, LENY
              Y(I) = ZERO
           END DO
        ELSE
           DO I = 1, LENY
              Y(I) = HMUL(BETA, Y(I))
           END DO
        END IF
     ELSE
        IY = KY
        IF (BETA .EQ. ZERO) THEN
           DO I = 1, LENY
              Y(IY) = ZERO
              IY = IY + INCY
           END DO
        ELSE
           DO I = 1, LENY
              Y(IY) = HMUL(BETA, Y(IY))
              IY = IY + INCY
           END DO
        END IF
     END IF
  END IF
  IF (ALPHA .EQ. ZERO) RETURN
  KUP1 = KU + 1
  IF (LSAME(TRANS, 'N')) THEN
!
!        Form  y := alpha*A*x + y.
!
     JX = KX
     IF (INCY .EQ. 1) THEN
        DO J = 1, N
           TEMP = HMUL(ALPHA, X(JX))
           K = KUP1 - J
           DO I = MAX(1,J-KU), MIN(M,J+KL)
              Y(I) = HFMA(TEMP, A(K+I,J), Y(I))
           END DO
           JX = JX + INCX
        END DO
     ELSE
        DO J = 1, N
           TEMP = HMUL(ALPHA, X(JX))
           IY = KY
           K = KUP1 - J
           DO I = MAX(1,J-KU), MIN(M,J+KL)
              Y(IY) = HFMA(TEMP, A(K+I,J), Y(IY))
              IY = IY + INCY
           END DO
           JX = JX + INCX
           IF (J .GT. KU) KY = KY + INCY
        END DO
     END IF
  ELSE
!
!        Form  y := alpha*A**T*x + y  or  y := alpha*A**H*x + y.
!
     JY = KY
     IF (INCX .EQ. 1) THEN
        DO J = 1, N
           TEMP = ZERO
           K = KUP1 - J
           IF (NOCONJ) THEN
              DO I = MAX(1,J-KU), MIN(M,J+KL)
                 TEMP = HFMA(A(K+I,J), X(I), TEMP)
              END DO
           ELSE
              DO I = MAX(1,J-KU), MIN(M,J+KL)
                 TEMP = HFMA(CONJG(A(K+I,J)), X(I), TEMP)
              END DO
           END IF
           Y(JY) = HFMA(ALPHA, TEMP, Y(JY))
           JY = JY + INCY
        END DO
     ELSE
        DO J = 1, N
           TEMP = ZERO
           IX = KX
           K = KUP1 - J
           IF (NOCONJ) THEN
              DO I = MAX(1,J-KU), MIN(M,J+KL)
                 TEMP = HFMA(A(K+I,J), X(IX), TEMP)
                 IX = IX + INCX
              END DO
           ELSE
              DO I = MAX(1,J-KU), MIN(M,J+KL)
                 TEMP = HFMA(CONJG(A(K+I,J)), X(IX), TEMP)
                 IX = IX + INCX
              END DO
           END IF
           Y(JY) = HFMA(ALPHA, TEMP, Y(JY))
           JY = JY + INCY
           IF (J .GT. KU) KX = KX + INCX
        END DO
     END IF
  END IF
!
!     End of HGBMV
!
END SUBROUTINE HGBMV
