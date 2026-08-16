! by venovako
PURE RECURSIVE FUNCTION GHNRM2(N, X, INCX) RESULT(F)
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
#if (HAVE_FMA == 15)
#warning IEEE quad not yet available
#else
  INTERFACE
     PURE FUNCTION CR_HYPOTQ(X, Y) BIND(C,NAME='cr_hypotq')
       IMPLICIT NONE
       REAL(KIND=BLAS_REAL_KIND), INTENT(IN), VALUE :: X, Y
       REAL(KIND=BLAS_REAL_KIND) :: CR_HYPOTQ
     END FUNCTION CR_HYPOTQ
  END INTERFACE
#define HYPOT CR_HYPOTQ
#endif
#else
#error CR_HYPOT not defined
#endif
#endif
  REAL(KIND=BLAS_REAL_KIND), PARAMETER :: ZERO = 0.0
  INTEGER, INTENT(IN) :: N, INCX
  COMPLEX(KIND=BLAS_REAL_KIND), INTENT(IN) :: X(*)
  REAL(KIND=BLAS_REAL_KIND) :: F, L, R
  INTEGER :: M, IX
  IF (N .LE. 0) THEN
     F = ZERO
  ELSE IF (N .EQ. 1) THEN
     F = HYPOT(REAL(X(1)), AIMAG(X(1)))
  ELSE ! N >= 2
    IF (INCX .LT. 0) THEN
        IX = 1 + (1-N)*INCX
        IF (N .EQ. 2) THEN
           L = HYPOT(REAL(X(IX)), AIMAG(X(IX)))
           IX = IX + INCX
           R = HYPOT(REAL(X(IX)), AIMAG(X(IX)))
        ELSE ! N > 2
           M = ISHFT(N, -1) + IAND(N, 1)
           IX = IX + (M-1)*INCX
           L = GHNRM2(M, X(IX), INCX)
           M = N - M
           IX = IX + M*INCX
           R = GHNRM2(M, X(IX), INCX)
        END IF
     ELSE ! INCX >= 0
        IX = 1
        IF (N .EQ. 2) THEN
           L = HYPOT(REAL(X(IX)), AIMAG(X(IX)))
           IX = IX + INCX
           R = HYPOT(REAL(X(IX)), AIMAG(X(IX)))
        ELSE ! N > 2
           M = ISHFT(N, -1) + IAND(N, 1)
           L = GHNRM2(M, X(IX), INCX)
           IX = IX + M*INCX
           M = N - M
           R = GHNRM2(M, X(IX), INCX)
        END IF
     END IF
     F = HYPOT(L, R)
  END IF
END FUNCTION GHNRM2
