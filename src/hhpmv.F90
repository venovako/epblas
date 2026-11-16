!> \brief \b HHPMV
!
!  =========== DOCUMENTATION ===========
!
! Online html documentation available at
!            http://www.netlib.org/lapack/explore-html/
!
!  Definition:
!  ===========
!
!       SUBROUTINE HHPMV(UPLO,N,ALPHA,AP,X,INCX,BETA,Y,INCY)
!
!       .. Scalar Arguments ..
!       COMPLEX ALPHA,BETA
!       INTEGER INCX,INCY,N
!       CHARACTER UPLO
!       ..
!       .. Array Arguments ..
!       COMPLEX AP(*),X(*),Y(*)
!       ..
!
!
!> \par Purpose:
!  =============
!>
!> \verbatim
!>
!> HHPMV  performs the matrix-vector operation
!>
!>    y := alpha*A*x + beta*y,
!>
!> where alpha and beta are scalars, x and y are n element vectors and
!> A is an n by n hermitian matrix, supplied in packed form.
!> \endverbatim
!
!  Arguments:
!  ==========
!
!> \param[in] UPLO
!> \verbatim
!>          UPLO is CHARACTER*1
!>           On entry, UPLO specifies whether the upper or lower
!>           triangular part of the matrix A is supplied in the packed
!>           array AP as follows:
!>
!>              UPLO = 'U' or 'u'   The upper triangular part of A is
!>                                  supplied in AP.
!>
!>              UPLO = 'L' or 'l'   The lower triangular part of A is
!>                                  supplied in AP.
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
!> \param[in] AP
!> \verbatim
!>          AP is COMPLEX array, dimension at least
!>           ( ( n*( n + 1 ) )/2 ).
!>           Before entry with UPLO = 'U' or 'u', the array AP must
!>           contain the upper triangular part of the hermitian matrix
!>           packed sequentially, column by column, so that AP( 1 )
!>           contains a( 1, 1 ), AP( 2 ) and AP( 3 ) contain a( 1, 2 )
!>           and a( 2, 2 ) respectively, and so on.
!>           Before entry with UPLO = 'L' or 'l', the array AP must
!>           contain the lower triangular part of the hermitian matrix
!>           packed sequentially, column by column, so that AP( 1 )
!>           contains a( 1, 1 ), AP( 2 ) and AP( 3 ) contain a( 2, 1 )
!>           and a( 3, 1 ) respectively, and so on.
!>           Note that the imaginary parts of the diagonal elements need
!>           not be set and are assumed to be zero.
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
!> \ingroup hpmv
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
PURE SUBROUTINE HHPMV(UPLO, N, ALPHA, AP, X, INCX, BETA, Y, INCY)
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
#elif ((BLAS_REAL_KIND == 10) && ((HAVE_FMA & 8) == 0))
  INTERFACE
     PURE FUNCTION GFMA(A, B, C) BIND(C,NAME='fmal')
       IMPLICIT NONE
       REAL(KIND=BLAS_REAL_KIND), INTENT(IN), VALUE :: A, B, C
       REAL(KIND=BLAS_REAL_KIND) :: GFMA
     END FUNCTION GFMA
  END INTERFACE
#elif ((BLAS_REAL_KIND == 16) && ((HAVE_FMA & 4) == 0))
  INTERFACE
#ifdef PVN_QUADMATH
#ifdef __GFORTRAN__
     PURE FUNCTION GFMA(A, B, C) BIND(C,NAME='fmaq')
#else
     PURE FUNCTION GFMA(A, B, C) BIND(C,NAME='__fmaq')
#endif
#else
     PURE FUNCTION GFMA(A, B, C) BIND(C,NAME='fmal')
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
  INTEGER, INTENT(IN) :: N, INCX, INCY
  COMPLEX(KIND=BLAS_REAL_KIND), INTENT(IN) :: ALPHA, BETA
!     ..
!     .. Array Arguments ..
  COMPLEX(KIND=BLAS_REAL_KIND), INTENT(IN) :: AP(*), X(*)
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
  INTEGER :: I, INFO, IX, IY, J, JX, JY, K, KK, KX, KY
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
     INFO = 6
  ELSE IF (INCY .EQ. 0) THEN
     INFO = 9
  END IF
  IF (INFO .NE. 0) THEN
     CALL XERBLA('HHPMV', INFO)
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
!     Start the operations. In this version the elements of the array AP
!     are accessed sequentially with one pass through AP.
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
  KK = 1
  IF (LSAME(UPLO, 'U')) THEN
!
!        Form  y  when AP contains the upper triangle.
!
     IF ((INCX .EQ. 1) .AND. (INCY .EQ. 1)) THEN
        DO J = 1, N
           TEMP1 = HMUL(ALPHA, X(J))
           TEMP2 = ZERO
           K = KK
           DO I = 1, J-1
              Y(I) = HFMA(TEMP1, AP(K), Y(I))
              TEMP2 = HFMA(CONJG(AP(K)), X(I), TEMP2)
              K = K + 1
           END DO
           TEMP1 = CMPLX(GFMA(REAL(TEMP1), REAL(AP(KK+J-1)), REAL(Y(J))), GFMA(AIMAG(TEMP1), REAL(AP(KK+J-1)), AIMAG(Y(J))), BLAS_REAL_KIND)
           Y(J) = HFMA(ALPHA, TEMP2, TEMP1)
           KK = KK + J
        END DO
     ELSE
        JX = KX
        JY = KY
        DO J = 1, N
           TEMP1 = HMUL(ALPHA, X(JX))
           TEMP2 = ZERO
           IX = KX
           IY = KY
           DO K = KK, KK+J-2
              Y(IY) = HFMA(TEMP1, AP(K), Y(IY))
              TEMP2 = HFMA(CONJG(AP(K)), X(IX), TEMP2)
              IX = IX + INCX
              IY = IY + INCY
           END DO
           TEMP1 = CMPLX(GFMA(REAL(TEMP1), REAL(AP(KK+J-1)), REAL(Y(JY))), GFMA(AIMAG(TEMP1), REAL(AP(KK+J-1)), AIMAG(Y(JY))), BLAS_REAL_KIND)
           Y(JY) = HFMA(ALPHA, TEMP2, TEMP1)
           JX = JX + INCX
           JY = JY + INCY
           KK = KK + J
        END DO
     END IF
  ELSE
!
!        Form  y  when AP contains the lower triangle.
!
     IF ((INCX .EQ. 1) .AND. (INCY .EQ. 1)) THEN
        DO J = 1, N
           TEMP1 = HMUL(ALPHA, X(J))
           TEMP2 = ZERO
           Y(J) = CMPLX(GFMA(REAL(TEMP1), REAL(AP(KK)), REAL(Y(J))), GFMA(AIMAG(TEMP1), REAL(AP(KK)), AIMAG(Y(J))), BLAS_REAL_KIND)
           K = KK + 1
           DO I = J + 1,N
              Y(I) = HFMA(TEMP1, AP(K), Y(I))
              TEMP2 = HFMA(CONJG(AP(K)), X(I), TEMP2)
              K = K + 1
           END DO
           Y(J) = HFMA(ALPHA, TEMP2, Y(J))
           KK = KK + (N-J+1)
        END DO
     ELSE
        JX = KX
        JY = KY
        DO J = 1, N
           TEMP1 = HMUL(ALPHA, X(JX))
           TEMP2 = ZERO
           Y(JY) = CMPLX(GFMA(REAL(TEMP1), REAL(AP(KK)), REAL(Y(JY))), GFMA(AIMAG(TEMP1), REAL(AP(KK)), AIMAG(Y(JY))), BLAS_REAL_KIND)
           IX = JX
           IY = JY
           DO K = KK+1, KK+N-J
              IX = IX + INCX
              IY = IY + INCY
              Y(IY) = HFMA(TEMP1, AP(K), Y(IY))
              TEMP2 = HFMA(CONJG(AP(K)), X(IX), TEMP2)
           END DO
           Y(JY) = HFMA(ALPHA, TEMP2, Y(JY))
           JX = JX + INCX
           JY = JY + INCY
           KK = KK + (N-J+1)
        END DO
     END IF
  END IF
!
!     End of HHPMV
!
END SUBROUTINE HHPMV
