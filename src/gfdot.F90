!> \brief \b GFDOT
!
!  =========== DOCUMENTATION ===========
!
! Online html documentation available at
!            http://www.netlib.org/lapack/explore-html/
!
!  Definition:
!  ===========
!
!       REAL2 FUNCTION GFDOT(N,SX,INCX,SY,INCY)
!
!       .. Scalar Arguments ..
!       INTEGER INCX,INCY,N
!       ..
!       .. Array Arguments ..
!       REAL SX(*),SY(*)
!       ..
!
!    AUTHORS
!    =======
!    Lawson, C. L., (JPL), Hanson, R. J., (SNLA),
!    Kincaid, D. R., (U. of Texas), Krogh, F. T., (JPL)
!
!
!> \par Purpose:
!  =============
!>
!> \verbatim
!>
!> Compute the inner product of two vectors with extended
!> precision accumulation and result.
!>
!> Returns D.P. dot product accumulated in D.P., for S.P. SX and SY
!> GFDOT = sum for I = 0 to N-1 of  SX(LX+I*INCX) * SY(LY+I*INCY),
!> where LX = 1 if INCX .GE. 0, else LX = 1+(1-N)*INCX, and LY is
!> defined in a similar way using INCY.
!> \endverbatim
!
!  Arguments:
!  ==========
!
!> \param[in] N
!> \verbatim
!>          N is INTEGER
!>         number of elements in input vector(s)
!> \endverbatim
!>
!> \param[in] SX
!> \verbatim
!>          SX is REAL array, dimension(N)
!> \endverbatim
!>
!> \param[in] INCX
!> \verbatim
!>          INCX is INTEGER
!>          storage spacing between elements of SX
!> \endverbatim
!>
!> \param[in] SY
!> \verbatim
!>          SY is REAL array, dimension(N)
!> \endverbatim
!>
!> \param[in] INCY
!> \verbatim
!>          INCY is INTEGER
!>         storage spacing between elements of SY
!> \endverbatim
!>
!> \result GFDOT
!> \verbatim
!>          GFDOT is REAL2
!>         GFDOT  double precision dot product (zero if N.LE.0)
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
!> \ingroup dot
!
!> \par Further Details:
!  =====================
!>
!> \verbatim
!> \endverbatim
!
!> \par References:
!  ================
!>
!> \verbatim
!>
!>
!>  C. L. Lawson, R. J. Hanson, D. R. Kincaid and F. T.
!>  Krogh, Basic linear algebra subprograms for Fortran
!>  usage, Algorithm No. 539, Transactions on Mathematical
!>  Software 5, 3 (September 1979), pp. 308-323.
!>
!>  REVISION HISTORY  (YYMMDD)
!>
!>  791001  DATE WRITTEN
!>  890831  Modified array declarations.  (WRB)
!>  890831  REVISION DATE from Version 3.2
!>  891214  Prologue converted to Version 4.0 format.  (BAB)
!>  920310  Corrected definition of LX in DESCRIPTION.  (WRB)
!>  920501  Reformatted the REFERENCES section.  (WRB)
!>  070118  Reformat to LAPACK style (JL)
!> \endverbatim
!>
!  =====================================================================
PURE FUNCTION GFDOT(N, SX, INCX, SY, INCY)
#ifdef USE_IEEE_INTRINSIC
  USE, INTRINSIC :: IEEE_ARITHMETIC, ONLY: IEEE_FMA
#define GFMA IEEE_FMA
#endif
  IMPLICIT NONE
#ifndef USE_IEEE_INTRINSIC
#if ((BLAS_REAL_KIND2 == 4) && ((HAVE_FMA & 1) == 0))
  INTERFACE
     PURE FUNCTION GFMA(A, B, C) BIND(C,NAME='fmaf')
       IMPLICIT NONE
       REAL(KIND=BLAS_REAL_KIND2), INTENT(IN), VALUE :: A, B, C
       REAL(KIND=BLAS_REAL_KIND2) :: GFMA
     END FUNCTION GFMA
  END INTERFACE
#elif ((BLAS_REAL_KIND2 == 8) && ((HAVE_FMA & 2) == 0))
  INTERFACE
     PURE FUNCTION GFMA(A, B, C) BIND(C,NAME='fma')
       IMPLICIT NONE
       REAL(KIND=BLAS_REAL_KIND2), INTENT(IN), VALUE :: A, B, C
       REAL(KIND=BLAS_REAL_KIND2) :: GFMA
     END FUNCTION GFMA
  END INTERFACE
#elif ((BLAS_REAL_KIND2 == 10) && ((HAVE_FMA & 4) == 0))
  INTERFACE
     PURE FUNCTION GFMA(A, B, C) BIND(C,NAME='fmal')
       IMPLICIT NONE
       REAL(KIND=BLAS_REAL_KIND2), INTENT(IN), VALUE :: A, B, C
       REAL(KIND=BLAS_REAL_KIND2) :: GFMA
     END FUNCTION GFMA
  END INTERFACE
#elif ((BLAS_REAL_KIND2 == 16) && ((HAVE_FMA & 8) == 0))
  INTERFACE
#ifdef __GFORTRAN__
     PURE FUNCTION GFMA(A, B, C) BIND(C,NAME='fmaq')
#else
     PURE FUNCTION GFMA(A, B, C) BIND(C,NAME='__fmaq')
#endif
       IMPLICIT NONE
       REAL(KIND=BLAS_REAL_KIND2), INTENT(IN), VALUE :: A, B, C
       REAL(KIND=BLAS_REAL_KIND2) :: GFMA
     END FUNCTION GFMA
  END INTERFACE
#else
#define GFMA(A,B,C) ((A)*(B)+(C))
#endif
#endif
!
!  -- Reference BLAS level1 routine --
!  -- Reference BLAS is a software package provided by Univ. of Tennessee,    --
!  -- Univ. of California Berkeley, Univ. of Colorado Denver and NAG Ltd..--
!
!     .. Scalar Arguments ..
  INTEGER, INTENT(IN) :: INCX, INCY, N
!     ..
!     .. Array Arguments ..
  REAL(KIND=BLAS_REAL_KIND), INTENT(IN) :: SX(*), SY(*)
!     ..
!
!  Authors:
!  ========
!  Lawson, C. L., (JPL), Hanson, R. J., (SNLA),
!  Kincaid, D. R., (U. of Texas), Krogh, F. T., (JPL)
!
!  =====================================================================
!     ..
  REAL(KIND=BLAS_REAL_KIND2), PARAMETER :: ZERO = 0.0
  REAL(KIND=BLAS_REAL_KIND2) :: GFDOT
!     .. Local Scalars ..
  INTEGER :: I, KX, KY, NS
!     ..
  GFDOT = ZERO
  IF (N .LE. 0) RETURN
  IF ((INCX .EQ. INCY) .AND. (INCX .GT. 0)) THEN
!
!     Code for equal, positive, non-unit increments.
!
     NS = N*INCX
     DO I = 1, NS, INCX
        GFDOT = GFMA(REAL(SX(I),BLAS_REAL_KIND2), REAL(SY(I),BLAS_REAL_KIND2), GFDOT)
     END DO
  ELSE
!
!     Code for unequal or nonpositive increments.
!
     IF (INCX .LT. 0) THEN
        KX = 1 + (1-N)*INCX
     ELSE
        KX = 1
     END IF
     IF (INCY .LT. 0) THEN
        KY = 1 + (1-N)*INCY
     ELSE
        KY = 1
     END IF
     DO I = 1, N
        GFDOT = GFMA(REAL(SX(KX),BLAS_REAL_KIND2), REAL(SY(KY),BLAS_REAL_KIND2), GFDOT)
        KX = KX + INCX
        KY = KY + INCY
     END DO
  END IF
!
!     End of GFDOT
!
END FUNCTION GFDOT
