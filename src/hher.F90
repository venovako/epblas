!> \brief \b HHER
!
!  =========== DOCUMENTATION ===========
!
! Online html documentation available at
!            http://www.netlib.org/lapack/explore-html/
!
!  Definition:
!  ===========
!
!       SUBROUTINE HHER(UPLO,N,ALPHA,X,INCX,A,LDA)
!
!       .. Scalar Arguments ..
!       REAL ALPHA
!       INTEGER INCX,LDA,N
!       CHARACTER UPLO
!       ..
!       .. Array Arguments ..
!       COMPLEX A(LDA,*),X(*)
!       ..
!
!
!> \par Purpose:
!  =============
!>
!> \verbatim
!>
!> HHER   performs the hermitian rank 1 operation
!>
!>    A := alpha*x*x**H + A,
!>
!> where alpha is a real scalar, x is an n element vector and A is an
!> n by n hermitian matrix.
!> \endverbatim
!
!  Arguments:
!  ==========
!
!> \param[in] UPLO
!> \verbatim
!>          UPLO is CHARACTER*1
!>           On entry, UPLO specifies whether the upper or lower
!>           triangular part of the array A is to be referenced as
!>           follows:
!>
!>              UPLO = 'U' or 'u'   Only the upper triangular part of A
!>                                  is to be referenced.
!>
!>              UPLO = 'L' or 'l'   Only the lower triangular part of A
!>                                  is to be referenced.
!> \endverbatim
!>
!> \param[in] N
!> \verbatim
!>          N is INTEGER
!>           On entry, N specifies the order of the matrix A.
!>           N must be at least zero.
!> \endverbatim
!>
!> \param[in] ALPHA
!> \verbatim
!>          ALPHA is REAL
!>           On entry, ALPHA specifies the scalar alpha.
!> \endverbatim
!>
!> \param[in] X
!> \verbatim
!>          X is COMPLEX array, dimension at least
!>           ( 1 + ( n - 1 )*abs( INCX ) ).
!>           Before entry, the incremented array X must contain the n
!>           element vector x.
!> \endverbatim
!>
!> \param[in] INCX
!> \verbatim
!>          INCX is INTEGER
!>           On entry, INCX specifies the increment for the elements of
!>           X. INCX must not be zero.
!> \endverbatim
!>
!> \param[in,out] A
!> \verbatim
!>          A is COMPLEX array, dimension ( LDA, N )
!>           Before entry with  UPLO = 'U' or 'u', the leading n by n
!>           upper triangular part of the array A must contain the upper
!>           triangular part of the hermitian matrix and the strictly
!>           lower triangular part of A is not referenced. On exit, the
!>           upper triangular part of the array A is overwritten by the
!>           upper triangular part of the updated matrix.
!>           Before entry with UPLO = 'L' or 'l', the leading n by n
!>           lower triangular part of the array A must contain the lower
!>           triangular part of the hermitian matrix and the strictly
!>           upper triangular part of A is not referenced. On exit, the
!>           lower triangular part of the array A is overwritten by the
!>           lower triangular part of the updated matrix.
!>           Note that the imaginary parts of the diagonal elements need
!>           not be set, they are assumed to be zero, and on exit they
!>           are set to zero.
!> \endverbatim
!>
!> \param[in] LDA
!> \verbatim
!>          LDA is INTEGER
!>           On entry, LDA specifies the first dimension of A as declared
!>           in the calling (sub) program. LDA must be at least
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
!> \ingroup her
!
!> \par Further Details:
!  =====================
!>
!> \verbatim
!>
!>  Level 2 Blas routine.
!>
!>  -- Written on 22-October-1986.
!>     Jack Dongarra, Argonne National Lab.
!>     Jeremy Du Croz, Nag Central Office.
!>     Sven Hammarling, Nag Central Office.
!>     Richard Hanson, Sandia National Labs.
!> \endverbatim
!>
!  =====================================================================
PURE SUBROUTINE HHER(UPLO, N, ALPHA, X, INCX, A, LDA)
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
!  -- Reference BLAS level2 routine --
!  -- Reference BLAS is a software package provided by Univ. of Tennessee,    --
!  -- Univ. of California Berkeley, Univ. of Colorado Denver and NAG Ltd..--
!
!     .. Scalar Arguments ..
  CHARACTER, INTENT(IN) :: UPLO
  INTEGER, INTENT(IN) :: N, INCX, LDA
  REAL(KIND=BLAS_REAL_KIND), INTENT(IN) :: ALPHA
!     ..
!     .. Array Arguments ..
  COMPLEX(KIND=BLAS_REAL_KIND), INTENT(IN) :: X(*)
  COMPLEX(KIND=BLAS_REAL_KIND), INTENT(INOUT) ::  A(LDA,*)
!     ..
!
!  =====================================================================
!
!     .. Parameters ..
  COMPLEX(KIND=BLAS_REAL_KIND), PARAMETER :: ZERO = CMPLX(0.0, 0.0, BLAS_REAL_KIND)
!     ..
!     .. Local Scalars ..
  COMPLEX(KIND=BLAS_REAL_KIND) :: TEMP
  INTEGER :: I, INFO, IX, J, JX, KX
!     ..
!
!     Test the input parameters.
!
  INFO = 0
  IF ((.NOT. LSAME(UPLO, 'U')) .AND. (.NOT. LSAME(UPLO, 'L'))) THEN
     INFO = 1
  ELSE IF (N .LT. 0) THEN
     INFO = 2
  ELSE IF (INCX .EQ. 0) THEN
     INFO = 5
  ELSE IF (LDA .LT. MAX(1, N)) THEN
     INFO = 7
  END IF
  IF (INFO .NE. 0) THEN
     CALL XERBLA('HHER', INFO)
     RETURN
  END IF
!
!     Quick return if possible.
!
  IF ((N .EQ. 0) .OR. (ALPHA .EQ. REAL(ZERO))) RETURN
!
!     Set the start point in X if the increment is not unity.
!
  IF (INCX .LE. 0) THEN
     KX = 1 - (N-1)*INCX
  ELSE IF (INCX .NE. 1) THEN
     KX = 1
  END IF
!
!     Start the operations. In this version the elements of A are
!     accessed sequentially with one pass through the triangular part
!     of A.
!
  IF (LSAME(UPLO, 'U')) THEN
!
!        Form  A  when A is stored in upper triangle.
!
     IF (INCX .EQ. 1) THEN
        DO J = 1, N
           IF (X(J) .NE. ZERO) THEN
              TEMP = HMUL(ALPHA, CONJG(X(J)))
              DO I = 1, J-1
                 A(I,J) = HFMA(X(I), TEMP, A(I,J))
              END DO
              A(J,J) = REAL(A(J,J)) + REAL(HMUL(X(J), TEMP))
           ELSE
              A(J,J) = REAL(A(J,J))
           END IF
        END DO
     ELSE
        JX = KX
        DO J = 1, N
           IF (X(JX) .NE. ZERO) THEN
              TEMP = HMUL(ALPHA, CONJG(X(JX)))
              IX = KX
              DO I = 1, J-1
                 A(I,J) = HFMA(X(IX), TEMP, A(I,J))
                 IX = IX + INCX
              END DO
              A(J,J) = REAL(A(J,J)) + REAL(HMUL(X(JX), TEMP))
           ELSE
              A(J,J) = REAL(A(J,J))
           END IF
           JX = JX + INCX
        END DO
     END IF
  ELSE
!
!        Form  A  when A is stored in lower triangle.
!
     IF (INCX .EQ. 1) THEN
        DO J = 1, N
           IF (X(J) .NE. ZERO) THEN
              TEMP = HMUL(ALPHA, CONJG(X(J)))
              A(J,J) = REAL(A(J,J)) + REAL(HMUL(TEMP, X(J)))
              DO I = J+1, N
                 A(I,J) = HFMA(X(I), TEMP, A(I,J))
              END DO
           ELSE
              A(J,J) = REAL(A(J,J))
           END IF
        END DO
     ELSE
        JX = KX
        DO J = 1, N
           IF (X(JX) .NE. ZERO) THEN
              TEMP = HMUL(ALPHA, CONJG(X(JX)))
              A(J,J) = REAL(A(J,J)) + REAL(HMUL(TEMP, X(JX)))
              IX = JX
              DO I = J+1, N
                 IX = IX + INCX
                 A(I,J) = HFMA(X(IX), TEMP, A(I,J))
              END DO
           ELSE
              A(J,J) = REAL(A(J,J))
           END IF
           JX = JX + INCX
        END DO
     END IF
  END IF
!
!     End of HHER
!
END SUBROUTINE HHER
