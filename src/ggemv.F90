!> \brief \b GGEMV
!
!  =========== DOCUMENTATION ===========
!
! Online html documentation available at
!            http://www.netlib.org/lapack/explore-html/
!
!  Definition:
!  ===========
!
!       SUBROUTINE GGEMV(TRANS,M,N,ALPHA,A,LDA,X,INCX,BETA,Y,INCY)
!
!       .. Scalar Arguments ..
!       REAL ALPHA,BETA
!       INTEGER INCX,INCY,LDA,M,N
!       CHARACTER TRANS
!       ..
!       .. Array Arguments ..
!       REAL A(LDA,*),X(*),Y(*)
!       ..
!
!
!> \par Purpose:
!  =============
!>
!> \verbatim
!>
!> GGEMV  performs one of the matrix-vector operations
!>
!>    y := alpha*A*x + beta*y,   or   y := alpha*A**T*x + beta*y,
!>
!> where alpha and beta are scalars, x and y are vectors and A is an
!> m by n matrix.
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
!>              TRANS = 'C' or 'c'   y := alpha*A**T*x + beta*y.
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
!> \param[in] ALPHA
!> \verbatim
!>          ALPHA is REAL
!>           On entry, ALPHA specifies the scalar alpha.
!> \endverbatim
!>
!> \param[in] A
!> \verbatim
!>          A is REAL array, dimension ( LDA, N )
!>           Before entry, the leading m by n part of the array A must
!>           contain the matrix of coefficients.
!> \endverbatim
!>
!> \param[in] LDA
!> \verbatim
!>          LDA is INTEGER
!>           On entry, LDA specifies the first dimension of A as declared
!>           in the calling (sub) program. LDA must be at least
!>           max( 1, m ).
!> \endverbatim
!>
!> \param[in] X
!> \verbatim
!>          X is REAL array, dimension at least
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
!>          BETA is REAL
!>           On entry, BETA specifies the scalar beta. When BETA is
!>           supplied as zero then Y need not be set on input.
!> \endverbatim
!>
!> \param[in,out] Y
!> \verbatim
!>          Y is REAL array, dimension at least
!>           ( 1 + ( m - 1 )*abs( INCY ) ) when TRANS = 'N' or 'n'
!>           and at least
!>           ( 1 + ( n - 1 )*abs( INCY ) ) otherwise.
!>           Before entry with BETA non-zero, the incremented array Y
!>           must contain the vector y. On exit, Y is overwritten by the
!>           updated vector y.
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
!> \ingroup gemv
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
SUBROUTINE GGEMV(TRANS, M, N, ALPHA, A, LDA, X, INCX, BETA, Y, INCY)
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
  INTEGER, INTENT(IN) :: M, N, LDA, INCX, INCY
  REAL(KIND=BLAS_REAL_KIND) :: ALPHA, BETA
!     ..
!     .. Array Arguments ..
  REAL(KIND=BLAS_REAL_KIND), INTENT(IN) :: A(LDA,*), X(*)
  REAL(KIND=BLAS_REAL_KIND), INTENT(INOUT) :: Y(*)
!     ..
!
!  =====================================================================
!
!     .. Parameters ..
  REAL(KIND=BLAS_REAL_KIND), PARAMETER :: ZERO = 0.0, ONE = 1.0
!     ..
!     .. Local Scalars ..
  REAL(KIND=BLAS_REAL_KIND) :: TEMP
  INTEGER :: I, INFO, IX, IY, J, JX, JY, KX, KY, LENX, LENY
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
  ELSE IF (LDA .LT. MAX(1, M)) THEN
     INFO = 6
  ELSE IF (INCX .EQ. 0) THEN
     INFO = 8
  ELSE IF (INCY .EQ. 0) THEN
     INFO = 11
  END IF
  IF (INFO .NE. 0) THEN
     CALL XERBLA('GGEMV', INFO)
     RETURN
  END IF
!
!     Quick return if possible.
!
  IF ((M .EQ. 0) .OR. (N .EQ. 0) .OR. ((ALPHA .EQ. ZERO) .AND. (BETA .EQ. ONE))) RETURN
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
     KX = 1 - (LENX - 1)*INCX
  END IF
  IF (INCY .GT. 0) THEN
     KY = 1
  ELSE
     KY = 1 - (LENY - 1)*INCY
  END IF
!
!     Start the operations. In this version the elements of A are
!     accessed sequentially with one pass through A.
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
              Y(I) = BETA * Y(I)
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
              Y(IY) = BETA * Y(IY)
              IY = IY + INCY
           END DO
        END IF
     END IF
  END IF
  IF (ALPHA .EQ. ZERO) RETURN
  IF (LSAME(TRANS, 'N')) THEN
!
!        Form  y := alpha*A*x + y.
!
     JX = KX
     IF (INCY .EQ. 1) THEN
        DO J = 1, N
           TEMP = ALPHA * X(JX)
           DO I = 1, M
              Y(I) = GFMA(TEMP, A(I,J), Y(I))
           END DO
           JX = JX + INCX
        END DO
     ELSE
        DO J = 1, N
           TEMP = ALPHA * X(JX)
           IY = KY
           DO I = 1, M
              Y(IY) = GFMA(TEMP, A(I,J), Y(IY))
              IY = IY + INCY
           END DO
           JX = JX + INCX
        END DO
     END IF
  ELSE
!
!        Form  y := alpha*A**T*x + y.
!
     JY = KY
     IF (INCX .EQ. 1) THEN
        DO J = 1, N
           TEMP = ZERO
           DO I = 1, M
              TEMP = GFMA(A(I,J), X(I), TEMP)
           END DO
           Y(JY) = GFMA(ALPHA, TEMP, Y(JY))
           JY = JY + INCY
        END DO
     ELSE
        DO J = 1, N
           TEMP = ZERO
           IX = KX
           DO I = 1, M
              TEMP = GFMA(A(I,J), X(IX), TEMP)
              IX = IX + INCX
           END DO
           Y(JY) = GFMA(ALPHA, TEMP, Y(JY))
           JY = JY + INCY
        END DO
     END IF
  END IF
!
!     End of GGEMV
!
END SUBROUTINE GGEMV
