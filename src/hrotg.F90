! by venovako
PURE SUBROUTINE HROTG(A, B, C, S)
  IMPLICIT NONE
#ifdef PVN_CR_MATH
#if (BLAS_REAL_KIND == 4)
  INTERFACE
     PURE FUNCTION CR_HYPOTF(X, Y) BIND(C,NAME='cr_hypotf')
       IMPLICIT NONE
       REAL(KIND=BLAS_REAL_KIND), INTENT(IN), VALUE :: X, Y
       REAL(KIND=BLAS_REAL_KIND) :: CR_HYPOTF
     END FUNCTION CR_HYPOTF
  END INTERFACE
#define HYPOT CR_HYPOTF
#elif (BLAS_REAL_KIND == 8)
  INTERFACE
     PURE FUNCTION CR_HYPOTD(X, Y) BIND(C,NAME='cr_hypot')
       IMPLICIT NONE
       REAL(KIND=BLAS_REAL_KIND), INTENT(IN), VALUE :: X, Y
       REAL(KIND=BLAS_REAL_KIND) :: CR_HYPOTD
     END FUNCTION CR_HYPOTD
  END INTERFACE
#define HYPOT CR_HYPOTD
#elif (BLAS_REAL_KIND == 10)
  INTERFACE
     PURE FUNCTION CR_HYPOTL(X, Y) BIND(C,NAME='cr_hypotl')
       IMPLICIT NONE
       REAL(KIND=BLAS_REAL_KIND), INTENT(IN), VALUE :: X, Y
       REAL(KIND=BLAS_REAL_KIND) :: CR_HYPOTL
     END FUNCTION CR_HYPOTL
  END INTERFACE
#define HYPOT CR_HYPOTL
#elif (BLAS_REAL_KIND == 16)
  INTERFACE
     PURE FUNCTION CR_HYPOTQ(X, Y) BIND(C,NAME='cr_hypotq')
       IMPLICIT NONE
       REAL(KIND=BLAS_REAL_KIND), INTENT(IN), VALUE :: X, Y
       REAL(KIND=BLAS_REAL_KIND) :: CR_HYPOTQ
     END FUNCTION CR_HYPOTQ
  END INTERFACE
#define HYPOT CR_HYPOTQ
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
  COMPLEX(KIND=BLAS_REAL_KIND), INTENT(INOUT) :: A
  COMPLEX(KIND=BLAS_REAL_KIND), INTENT(IN) :: B
  REAL(KIND=BLAS_REAL_KIND), INTENT(OUT) :: C
  COMPLEX(KIND=BLAS_REAL_KIND), INTENT(OUT) :: S
  REAL(KIND=BLAS_REAL_KIND), PARAMETER :: ZERO = 0.0, ONE = 1.0
  REAL(KIND=BLAS_REAL_KIND) :: AR, AI, BR, BI, MA, MB, M
  INTEGER :: E
  C = ONE
  S = CMPLX(ZERO, ZERO, BLAS_REAL_KIND)
  AR = REAL(A)
  AI = AIMAG(A)
  IF (.NOT. (ABS(AR) .LE. HUGE(AR))) RETURN
  IF (.NOT. (ABS(AI) .LE. HUGE(AI))) RETURN
  BR = REAL(B)
  BI = -AIMAG(B)
  IF (.NOT. (ABS(BR) .LE. HUGE(BR))) GOTO 9
  IF (.NOT. (ABS(BI) .LE. HUGE(BI))) GOTO 9
  IF ((BR .EQ. ZERO) .AND. (BI .EQ. ZERO)) RETURN
  IF ((AR .EQ. ZERO) .AND. (AI .EQ. ZERO)) GOTO 9
  ! max safe exponent
  E = MAXEXPONENT(M) - 2
  ! the scaling exponent
  E = E - MAX(MAX(EXPONENT(AR), EXPONENT(AI)), MAX(EXPONENT(BR), EXPONENT(BI)))
  ! try to compute R without downscaling (but downscale if necessary)
  IF (E .LE. 0) THEN
     IF (AI .EQ. ZERO) THEN
        MA = ABS(AR)
     ELSE IF (AR .EQ. ZERO) THEN
        MA = ABS(AI)
     ELSE ! A complex
        MA = HYPOT(AR, AI)
     END IF
     IF (.NOT. (MA .LE. HUGE(MA))) GOTO 1
     IF (BI .EQ. ZERO) THEN
        MB = ABS(BR)
     ELSE IF (BR .EQ. ZERO) THEN
        MB = ABS(BI)
     ELSE ! B complex
        MB = HYPOT(BR, BI)
     END IF
     IF (.NOT. (MB .LE. HUGE(MB))) GOTO 1
     M = HYPOT(MA, MB)
     IF (M .LE. HUGE(M)) E = 0
  END IF
1 IF (E .NE. 0) THEN
     AR = SCALE(AR, E)
     AI = SCALE(AI, E)
     BR = SCALE(BR, E)
     BI = SCALE(BI, E)
     IF (AI .EQ. ZERO) THEN
        MA = ABS(AR)
     ELSE IF (AR .EQ. ZERO) THEN
        MA = ABS(AI)
     ELSE ! A complex
        MA = HYPOT(AR, AI)
     END IF
     IF (BI .EQ. ZERO) THEN
        MB = ABS(BR)
     ELSE IF (BR .EQ. ZERO) THEN
        MB = ABS(BI)
     ELSE ! B complex
        MB = HYPOT(BR, BI)
     END IF
     IF (MB .EQ. ZERO) THEN
        M = MA
     ELSE IF (MA .EQ. ZERO) THEN
        M = MB
     ELSE ! A*B .NE. 0
        M = HYPOT(MA, MB)
     END IF
  END IF
  IF (MA .EQ. ZERO) THEN
     ! underflow of MA, recompute
     AR = REAL(A)
     AI = AIMAG(A)
     IF (AI .EQ. ZERO) THEN
        MA = ABS(AR)
     ELSE IF (AR .EQ. ZERO) THEN
        MA = ABS(AI)
     ELSE ! A complex
        MA = HYPOT(AR, AI)
     END IF
     AR = AR / MA
     AI = AI / MA
     MA = SCALE(MA, E)
  ELSE ! MA > 0
     AR = AR / MA
     AI = AI / MA
  END IF
  C = MA / M
  BR = BR / M
  BI = BI / M
  IF (AI .EQ. ZERO) THEN
     IF (AR .EQ. ONE) THEN
        S = CMPLX(BR, BI, BLAS_REAL_KIND)
     ELSE ! AR .NE. ONE
        S = CMPLX(AR * BR, AR * BI, BLAS_REAL_KIND)
     END IF
  ELSE ! A complex
     S = HMUL(CMPLX(AR, AI, BLAS_REAL_KIND), CMPLX(BR, BI, BLAS_REAL_KIND))
  END IF
  AR = AR * M
  AI = AI * M
  IF (E .EQ. 0) THEN
     A = CMPLX(AR, AI, BLAS_REAL_KIND)
  ELSE ! E .NE. 0
     E = -E
     A = CMPLX(SCALE(AR, E), SCALE(AI, E), BLAS_REAL_KIND)
  END IF
  RETURN
9 C = ZERO
  S = CMPLX(ONE, ZERO, BLAS_REAL_KIND)
  A = B
END SUBROUTINE HROTG
