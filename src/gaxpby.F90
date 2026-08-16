!> \brief \b GAXPBY
!
!  =========== DOCUMENTATION ===========
!
! Online html documentation available at
!            http://www.netlib.org/lapack/explore-html/
!
!  Definition:
!  ===========
!
!       SUBROUTINE GAXPBY(N,SA,SX,INCX,SB,SY,INCY)
!
!       .. Scalar Arguments ..
!       REAL SA,SB
!       INTEGER INCX,INCY,N
!       ..
!       .. Array Arguments ..
!       REAL SX(*),SY(*)
!       ..
!
!
!> \par Purpose:
!  =============
!>
!> \verbatim
!>
!>    GAXPBY constant times a vector plus constant times a vector.
!>
!>    Y = ALPHA * X + BETA * Y
!>
!> \endverbatim
!
!  Arguments:
!  ==========
!
!> \param[in] N
!> \verbatim
!>          N is INTEGER
!>          number of elements in input vector(s)
!> \endverbatim
!>
!> \param[in] SA
!> \verbatim
!>           SA is REAL
!>           On entry, SA specifies the scalar alpha.
!> \endverbatim
!>
!> \param[in] SX
!> \verbatim
!>          SX is REAL array, dimension ( 1 + ( N - 1 )*abs( INCX ) )
!> \endverbatim
!>
!> \param[in] INCX
!> \verbatim
!>          INCX is INTEGER
!>          storage spacing between elements of SX
!> \endverbatim
!>
!> \param[in] SB
!> \verbatim
!>           SB is REAL
!>           On entry, SB specifies the scalar beta.
!> \endverbatim
!>
!> \param[in,out] SY
!> \verbatim
!>          SY is REAL array, dimension ( 1 + ( N - 1 )*abs( INCY ) )
!> \endverbatim
!>
!> \param[in] INCY
!> \verbatim
!>          INCY is INTEGER
!>         storage spacing between elements of SY
!> \endverbatim
!
!  Authors:
!  ========
!
!> \author Univ. of Tennessee
!> \author Univ. of California Berkeley
!> \author Univ. of Colorado Denver
!> \author NAG Ltd.
!> \author Martin Koehler, MPI Magdeburg
!> \author modified by venovako
!
!> \ingroup axpby
!
!  =====================================================================
PURE SUBROUTINE GAXPBY(N, SA, SX, INCX, SB, SY, INCY)
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
!
!  -- Reference BLAS level1 routine --
!  -- Reference BLAS is a software package provided by Univ. of Tennessee,    --
!  -- Univ. of California Berkeley, Univ. of Colorado Denver and NAG Ltd..--
!
!     .. Scalar Arguments ..
  REAL(KIND=BLAS_REAL_KIND), INTENT(IN) :: SA, SB
  INTEGER, INTENT(IN) :: INCX, INCY, N
!     ..
!     .. Array Arguments ..
  REAL(KIND=BLAS_REAL_KIND), INTENT(IN) :: SX(*)
  REAL(KIND=BLAS_REAL_KIND), INTENT(INOUT) :: SY(*)
!
!  =====================================================================
  REAL(KIND=BLAS_REAL_KIND), PARAMETER :: ZERO = 0.0, ONE = 1.0
!
!     .. Local Scalars ..
  INTEGER :: I, IX, IY
!     ..
  IF (N .LE. 0) RETURN
!
  IF (SA .EQ. ZERO) THEN
     IF (INCY .EQ. 1) THEN
        IF (SB .NE. ONE) THEN
           DO I = 1, N
              SY(I) = SB*SY(I)
           END DO
        END IF
     ELSE
        IF (SB .NE. ONE) THEN
           IF (INCY .LT. 0) THEN
              IY = (1-N)*INCY + 1
           ELSE
              IY = 1
           END IF
           DO I = 1, N
              SY(IY) = SB*SY(IY)
              IY = IY + INCY
           END DO
        END IF
     END IF
  ELSE IF (SB .EQ. ZERO) THEN
     IF ((INCX .EQ. 1) .AND. (INCY .EQ. 1)) THEN
        DO I = 1, N
           SY(I) = SA*SX(I)
        END DO
     ELSE
        IF (INCX .LT. 0) THEN
           IX = (1-N)*INCX + 1
        ELSE
           IX = 1
        END IF
        IF (INCY .LT. 0) THEN
           IY = (1-N)*INCY + 1
        ELSE
           IY = 1
        END IF
        IF (SA .EQ. ONE) THEN
           DO I = 1, N
              SY(IY) = SX(IX)
              IX = IX + INCX
              IY = IY + INCY
           END DO
        ELSE
           DO I = 1, N
              SY(IY) = SA*SX(IX)
              IX = IX + INCX
              IY = IY + INCY
           END DO
        END IF
     END IF
  ELSE
     IF ((INCX .EQ. 1) .AND. (INCY .EQ. 1)) THEN
        IF (SA .EQ. ONE) THEN
           IF (SB .EQ. ONE) THEN
              DO I = 1, N
                 SY(I) = SY(I) + SX(I)
              END DO
           ELSE
              DO I = 1, N
                 SY(I) = GFMA(SB, SY(I), SX(I))
              END DO
           END IF
        ELSE IF (SB .EQ. ONE) THEN
           DO I = 1, N
              SY(I) = GFMA(SA, SX(I), SY(I))
           END DO
        ELSE
           DO I = 1, N
              SY(I) = GFMMA(SB, SY(I), SA, SX(I))
           END DO
        END IF
     ELSE
        IF (INCX .LT. 0) THEN
           IX = (1-N)*INCX + 1
        ELSE
           IX = 1
        END IF
        IF (INCY .LT. 0) THEN
           IY = (1-N)*INCY + 1
        ELSE
           IY = 1
        END IF
        IF (SA .EQ. ONE) THEN
           IF (SB .EQ. ONE) THEN
              DO I = 1, N
                 SY(IY) = SY(IY) + SX(IX)
                 IX = IX + INCX
                 IY = IY + INCY
              END DO
           ELSE
              DO I = 1, N
                 SY(IY) = GFMA(SB, SY(IY), SX(IX))
                 IX = IX + INCX
                 IY = IY + INCY
              END DO
           END IF
        ELSE IF (SB .EQ. ONE) THEN
           DO I = 1, N
              SY(IY) = GFMA(SA, SX(IX), SY(IY))
              IX = IX + INCX
              IY = IY + INCY
           END DO
        ELSE
           DO I = 1, N
              SY(IY) = GFMMA(SB, SY(IY), SA, SX(IX))
              IX = IX + INCX
              IY = IY + INCY
           END DO
        END IF
     END IF
  END IF
!
!     End of GAXPBY
!
END SUBROUTINE GAXPBY
