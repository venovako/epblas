!> \brief \b HHEMV
!
!  =========== DOCUMENTATION ===========
!
! Online html documentation available at
!            http://www.netlib.org/lapack/explore-html/
!
!  Definition:
!  ===========
!
!       SUBROUTINE HHEMV(UPLO,N,ALPHA,A,LDA,X,INCX,BETA,Y,INCY)
!
!       .. Scalar Arguments ..
!       COMPLEX ALPHA,BETA
!       INTEGER INCX,INCY,LDA,N
!       CHARACTER UPLO
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
!> HHEMV  performs the matrix-vector  operation
!>
!>    y := alpha*A*x + beta*y,
!>
!> where alpha and beta are scalars, x and y are n element vectors and
!> A is an n by n hermitian matrix.
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
!>          ALPHA is COMPLEX
!>           On entry, ALPHA specifies the scalar alpha.
!> \endverbatim
!>
!> \param[in] A
!> \verbatim
!>          A is COMPLEX array, dimension ( LDA, N )
!>           Before entry with  UPLO = 'U' or 'u', the leading n by n
!>           upper triangular part of the array A must contain the upper
!>           triangular part of the hermitian matrix and the strictly
!>           lower triangular part of A is not referenced.
!>           Before entry with UPLO = 'L' or 'l', the leading n by n
!>           lower triangular part of the array A must contain the lower
!>           triangular part of the hermitian matrix and the strictly
!>           upper triangular part of A is not referenced.
!>           Note that the imaginary parts of the diagonal elements need
!>           not be set and are assumed to be zero.
!> \endverbatim
!>
!> \param[in] LDA
!> \verbatim
!>          LDA is INTEGER
!>           On entry, LDA specifies the first dimension of A as declared
!>           in the calling (sub) program. LDA must be at least
!>           max( 1, n ).
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
!>           ( 1 + ( n - 1 )*abs( INCY ) ).
!>           Before entry, the incremented array Y must contain the n
!>           element vector y. On exit, Y is overwritten by the updated
!>           vector y.
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
!> \ingroup hemv
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
PURE SUBROUTINE HHEMV(UPLO, N, ALPHA, A, LDA, X, INCX, BETA, Y, INCY)
#ifdef USE_IEEE_INTRINSIC
  USE, INTRINSIC :: IEEE_ARITHMETIC, ONLY: IEEE_FMA
#define GFMA IEEE_FMA
#endif
#define HMUL(A,B) ((A)*(B))
#define HFMA(A,B,C) ((A)*(B)+(C))
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
  INTEGER, INTENT(IN) :: N, LDA, INCX, INCY
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
  COMPLEX(KIND=BLAS_REAL_KIND), PARAMETER :: ONE = CMPLX(1.0, 0.0, BLAS_REAL_KIND), ZERO = CMPLX(0.0, 0.0, BLAS_REAL_KIND)
!     ..
!     .. Local Scalars ..
  COMPLEX(KIND=BLAS_REAL_KIND) :: TEMP1, TEMP2
  INTEGER :: I, INFO, IX, IY, J, JX, JY, KX, KY
!     ..
!
!     Test the input parameters.
!
  INFO = 0
  IF ((.NOT. LSAME(UPLO, 'U')) .AND. (.NOT. LSAME(UPLO, 'L'))) THEN
     INFO = 1
  ELSE IF (N .LT. 0) THEN
     INFO = 2
  ELSE IF (LDA .LT. MAX(1,N)) THEN
     INFO = 5
  ELSE IF (INCX .EQ. 0) THEN
     INFO = 7
  ELSE IF (INCY .EQ. 0) THEN
     INFO = 10
  END IF
  IF (INFO .NE. 0) THEN
     CALL XERBLA('HHEMV', INFO)
     RETURN
  END IF
!
!     Quick return if possible.
!
  IF ((N .EQ. 0) .OR. ((ALPHA .EQ. ZERO) .AND. (BETA .EQ. ONE))) RETURN
!
!     Set up the start points in  X  and  Y.
!
  IF (INCX .GT. 0) THEN
     KX = 1
  ELSE
     KX = 1 - (N-1)*INCX
  END IF
  IF (INCY .GT. 0) THEN
     KY = 1
  ELSE
     KY = 1 - (N-1)*INCY
  END IF
!
!     Start the operations. In this version the elements of A are
!     accessed sequentially with one pass through the triangular part
!     of A.
!
!     First form  y := beta*y.
!
  IF (BETA .NE. ONE) THEN
     IF (INCY .EQ. 1) THEN
        IF (BETA .EQ. ZERO) THEN
           DO I = 1, N
              Y(I) = ZERO
           END DO
        ELSE
           DO I = 1, N
              Y(I) = HMUL(BETA, Y(I))
           END DO
        END IF
     ELSE
        IY = KY
        IF (BETA .EQ. ZERO) THEN
           DO I = 1, N
              Y(IY) = ZERO
              IY = IY + INCY
           END DO
        ELSE
           DO I = 1, N
              Y(IY) = HMUL(BETA, Y(IY))
              IY = IY + INCY
           END DO
        END IF
     END IF
  END IF
  IF (ALPHA .EQ. ZERO) RETURN
  IF (LSAME(UPLO, 'U')) THEN
!
!        Form  y  when A is stored in upper triangle.
!
     IF ((INCX .EQ. 1) .AND. (INCY .EQ. 1)) THEN
        DO J = 1, N
           TEMP1 = HMUL(ALPHA, X(J))
           TEMP2 = ZERO
           DO I = 1, J-1
              Y(I) = HFMA(TEMP1, A(I,J), Y(I))
              TEMP2 = HFMA(CONJG(A(I,J)), X(I), TEMP2)
           END DO
           TEMP1 = CMPLX(GFMA(REAL(TEMP1), REAL(A(J,J)), REAL(Y(J))), GFMA(AIMAG(TEMP1), REAL(A(J,J)), AIMAG(Y(J))), BLAS_REAL_KIND)
           Y(J) = HFMA(ALPHA, TEMP2, TEMP1)
        END DO
     ELSE
        JX = KX
        JY = KY
        DO J = 1, N
           TEMP1 = HMUL(ALPHA, X(JX))
           TEMP2 = ZERO
           IX = KX
           IY = KY
           DO I = 1, J-1
              Y(IY) = HFMA(TEMP1, A(I,J), Y(IY))
              TEMP2 = HFMA(CONJG(A(I,J)), X(IX), TEMP2)
              IX = IX + INCX
              IY = IY + INCY
           END DO
           TEMP1 = CMPLX(GFMA(REAL(TEMP1), REAL(A(J,J)), REAL(Y(JY))), GFMA(AIMAG(TEMP1), REAL(A(J,J)), AIMAG(Y(JY))), BLAS_REAL_KIND)
           Y(JY) = HFMA(ALPHA, TEMP2, TEMP1)
           JX = JX + INCX
           JY = JY + INCY
        END DO
     END IF
  ELSE
!
!        Form  y  when A is stored in lower triangle.
!
     IF ((INCX .EQ. 1) .AND. (INCY .EQ. 1)) THEN
        DO J = 1, N
           TEMP1 = HMUL(ALPHA, X(J))
           TEMP2 = ZERO
           Y(J) = CMPLX(GFMA(REAL(TEMP1), REAL(A(J,J)), REAL(Y(J))), GFMA(AIMAG(TEMP1), REAL(A(J,J)), AIMAG(Y(J))), BLAS_REAL_KIND)
           DO I = J+1, N
              Y(I) = HFMA(TEMP1, A(I,J), Y(I))
              TEMP2 = HFMA(CONJG(A(I,J)), X(I), TEMP2)
           END DO
           Y(J) = HFMA(ALPHA, TEMP2, Y(J))
        END DO
     ELSE
        JX = KX
        JY = KY
        DO J = 1, N
           TEMP1 = HMUL(ALPHA, X(JX))
           TEMP2 = ZERO
           Y(JY) = CMPLX(GFMA(REAL(TEMP1), REAL(A(J,J)), REAL(Y(JY))), GFMA(AIMAG(TEMP1), REAL(A(J,J)), AIMAG(Y(JY))), BLAS_REAL_KIND)
           IX = JX
           IY = JY
           DO I = J+1, N
              IX = IX + INCX
              IY = IY + INCY
              Y(IY) = HFMA(TEMP1, A(I,J), Y(IY))
              TEMP2 = HFMA(CONJG(A(I,J)), X(IX), TEMP2)
           END DO
           Y(JY) = HFMA(ALPHA, TEMP2, Y(JY))
           JX = JX + INCX
           JY = JY + INCY
        END DO
     END IF
  END IF
!
!     End of HHEMV
!
END SUBROUTINE HHEMV
