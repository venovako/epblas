!> \brief \b GLARUV returns a vector of n random real numbers from a uniform distribution.
!
!  =========== DOCUMENTATION ===========
!
! Online html documentation available at
!            http://www.netlib.org/lapack/explore-html/
!
!> Download GLARUV + dependencies
!> <a href="http://www.netlib.org/cgi-bin/netlibfiles.tgz?format=tgz&filename=/lapack/lapack_routine/slaruv.f">
!> [TGZ]</a>
!> <a href="http://www.netlib.org/cgi-bin/netlibfiles.zip?format=zip&filename=/lapack/lapack_routine/slaruv.f">
!> [ZIP]</a>
!> <a href="http://www.netlib.org/cgi-bin/netlibfiles.txt?format=txt&filename=/lapack/lapack_routine/slaruv.f">
!> [TXT]</a>
!
!  Definition:
!  ===========
!
!       SUBROUTINE GLARUV( ISEED, N, X )
!
!       .. Scalar Arguments ..
!       INTEGER            N
!       ..
!       .. Array Arguments ..
!       INTEGER            ISEED( 4 )
!       REAL               X( N )
!       ..
!
!
!> \par Purpose:
!  =============
!>
!> \verbatim
!>
!> GLARUV returns a vector of n random real numbers from a uniform (0,1)
!> distribution (n <= 128).
!>
!> This is an auxiliary routine called by SLARNV and CLARNV.
!> \endverbatim
!
!  Arguments:
!  ==========
!
!> \param[in,out] ISEED
!> \verbatim
!>          ISEED is INTEGER array, dimension (4)
!>          On entry, the seed of the random number generator; the array
!>          elements must be between 0 and 4095, and ISEED(4) must be
!>          odd.
!>          On exit, the seed is updated.
!> \endverbatim
!>
!> \param[in] N
!> \verbatim
!>          N is INTEGER
!>          The number of random numbers to be generated. N <= 128.
!> \endverbatim
!>
!> \param[out] X
!> \verbatim
!>          X is REAL array, dimension (N)
!>          The generated random numbers.
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
!> \ingroup laruv
!
!> \par Further Details:
!  =====================
!>
!> \verbatim
!>
!>  This routine uses a multiplicative congruential method with modulus
!>  2**48 and multiplier 33952834046453 (see G.S.Fishman,
!>  'Multiplicative congruential random number generators with modulus
!>  2**b: an exhaustive analysis for b = 32 and a partial analysis for
!>  b = 48', Math. Comp. 189, pp 331-344, 1990).
!>
!>  48-bit integers are stored in 4 integer array elements with 12 bits
!>  per element. Hence the routine is portable across machines with
!>  integers of 32 bits or more.
!> \endverbatim
!>
!  =====================================================================
PURE SUBROUTINE GLARUV(ISEED, N, X)
  IMPLICIT NONE
!
!  -- LAPACK auxiliary routine --
!  -- LAPACK is a software package provided by Univ. of Tennessee,    --
!  -- Univ. of California Berkeley, Univ. of Colorado Denver and NAG Ltd..--
!
!     .. Scalar Arguments ..
  INTEGER, INTENT(IN) :: N
!     ..
!     .. Array Arguments ..
  INTEGER, INTENT(INOUT) :: ISEED(4)
  REAL(KIND=BLAS_REAL_KIND), INTENT(OUT) :: X(N)
!     ..
!
!  =====================================================================
!
!     .. Parameters ..
  INTEGER, PARAMETER :: LV = 128, IPW2 = 4096
  REAL(KIND=BLAS_REAL_KIND), PARAMETER :: ONE = 1.0, R = ONE / IPW2
  INTEGER, PARAMETER :: MM(LV,4) = RESHAPE(SOURCE=(/&
        494,  322, 2508, 2549,&
       2637,  789, 3754, 1145,&
        255, 1440, 1766, 2253,&
       2008,  752, 3572,  305,&
       1253, 2859, 2893, 3301,&
       3344,  123,  307, 1065,&
       4084, 1848, 1297, 3133,&
       1739,  643, 3966, 2913,&
       3143, 2405,  758, 3285,&
       3468, 2638, 2598, 1241,&
        688, 2344, 3406, 1197,&
       1657,   46, 2922, 3729,&
       1238, 3814, 1038, 2501,&
       3166,  913, 2934, 1673,&
       1292, 3649, 2091,  541,&
       3422,  339, 2451, 2753,&
       1270, 3808, 1580,  949,&
       2016,  822, 1958, 2361,&
        154, 2832, 2055, 1165,&
       2862, 3078, 1507, 4081,&
        697, 3633, 1078, 2725,&
       1706, 2970, 3273, 3305,&
        491,  637,   17, 3069,&
        931, 2249,  854, 3617,&
       1444, 2081, 2916, 3733,&
        444, 4019, 3971,  409,&
       3577, 1478, 2889, 2157,&
       3944,  242, 3831, 1361,&
       2184,  481, 2621, 3973,&
       1661, 2075, 1541, 1865,&
       3482, 4058,  893, 2525,&
        657,  622,  736, 1409,&
       3023, 3376, 3992, 3445,&
       3618,  812,  787, 3577,&
       1267,  234, 2125,   77,&
       1828,  641, 2364, 3761,&
        164, 4005, 2460, 2149,&
       3798, 1122,  257, 1449,&
       3087, 3135, 1574, 3005,&
       2400, 2640, 3912,  225,&
       2870, 2302, 1216,   85,&
       3876,   40, 3248, 3673,&
       1905, 1832, 3401, 3117,&
       1593, 2247, 2124, 3089,&
       1797, 2034, 2762, 1349,&
       1234, 2637,  149, 2057,&
       3460, 1287, 2245,  413,&
        328, 1691,  166,   65,&
       2861,  496,  466, 1845,&
       1950, 1597, 4018,  697,&
        617, 2394, 1399, 3085,&
       2070, 2584,  190, 3441,&
       3331, 1843, 2879, 1573,&
        769,  336,  153, 3689,&
       1558, 1472, 2320, 2941,&
       2412, 2407,   18,  929,&
       2800,  433,  712,  533,&
        189, 2096, 2159, 2841,&
        287, 1761, 2318, 4077,&
       2045, 2810, 2091,  721,&
       1227,  566, 3443, 2821,&
       2838,  442, 1510, 2249,&
        209,   41,  449, 2397,&
       2770, 1238, 1956, 2817,&
       3654, 1086, 2201,  245,&
       3993,  603, 3137, 1913,&
        192,  840, 3399, 1997,&
       2253, 3168, 1321, 3121,&
       3491, 1499, 2271,  997,&
       2889, 1084, 3667, 1833,&
       2857, 3438, 2703, 2877,&
       2094, 2408,  629, 1633,&
       1818, 1589, 2365,  981,&
        688, 2391, 2431, 2009,&
       1407,  288, 1113,  941,&
        634,   26, 3922, 2449,&
       3231,  512, 2554,  197,&
        815, 1456,  184, 2441,&
       3524,  171, 2099,  285,&
       1914, 1677, 3228, 1473,&
        516, 2657, 4012, 2741,&
        164, 2270, 1921, 3129,&
        303, 2587, 3452,  909,&
       2144, 2961, 3901, 2801,&
       3480, 1970,  572,  421,&
        119, 1817, 3309, 4073,&
       3357,  676, 3171, 2813,&
        837, 1410,  817, 2337,&
       2826, 3723, 3039, 1429,&
       2332, 2803, 1696, 1177,&
       2089, 3185, 1256, 1901,&
       3780,  184, 3715,   81,&
       1700,  663, 2077, 1669,&
       3712,  499, 3019, 2633,&
        150, 3784, 1497, 2269,&
       2000, 1631, 1101,  129,&
       3375, 1925,  717, 1141,&
       1621, 3912,   51,  249,&
       3090, 1398,  981, 3917,&
       3765, 1349, 1978, 2481,&
       1149, 1441, 1813, 3941,&
       3146, 2224, 3881, 2217,&
         33, 2411,   76, 2749,&
       3082, 1907, 3846, 3041,&
       2741, 3192, 3694, 1877,&
        359, 2786, 1682,  345,&
       3316,  382,  124, 2861,&
       1749,   37, 1660, 1809,&
        185,  759, 3997, 3141,&
       2784, 2948,  479, 2825,&
       2202, 1862, 1141,  157,&
       2199, 3802,  886, 2881,&
       1364, 2423, 3514, 3637,&
       1244, 2051, 1301, 1465,&
       2020, 2295, 3604, 2829,&
       3160, 1332, 1888, 2161,&
       2785, 1832, 1836, 3365,&
       2772, 2405, 1990,  361,&
       1217, 3638, 2058, 2685,&
       1822, 3661,  692, 3745,&
       1245,  327, 1194, 2325,&
       2252, 3660,   20, 3609,&
       3904,  716, 3285, 3821,&
       2774, 1842, 2046, 3537,&
        997, 3987, 2107,  517,&
       2573, 1368, 3508, 3017,&
       1148, 1848, 3525, 2141,&
        545, 2366, 3801, 1537 &
       /), SHAPE=(/LV,4/), ORDER=(/2,1/))
!     ..
!     .. Local Scalars ..
  INTEGER :: I, I1, I2, I3, I4, IT1, IT2, IT3, IT4, J
!     ..
!     .. Executable Statements ..
!
!     Quick return for N < 1
  IF (N .LT. 1) RETURN
!
  I1 = ISEED(1)
  I2 = ISEED(2)
  I3 = ISEED(3)
  I4 = ISEED(4)
!
  DO I = 1, MIN(N, LV)
!
!        Multiply the seed by i-th power of the multiplier modulo 2**48
!
1    IT4 = I4*MM(I,4)
     IT3 = IT4 / IPW2
     IT4 = IT4 - IPW2*IT3
     IT3 = IT3 + I3*MM(I,4) + I4*MM(I,3)
     IT2 = IT3 / IPW2
     IT3 = IT3 - IPW2*IT2
     IT2 = IT2 + I2*MM(I,4) + I3*MM(I,3) + I4*MM(I,2)
     IT1 = IT2 / IPW2
     IT2 = IT2 - IPW2*IT1
     IT1 = IT1 + I1*MM(I,4) + I2*MM(I,3) + I3*MM(I,2) + I4*MM(I,1)
     IT1 = MOD(IT1, IPW2)
!
!        Convert 48-bit integer to a real number in the interval (0,1)
!
     X(I) = R*(REAL(IT1, BLAS_REAL_KIND) + R*(REAL(IT2, BLAS_REAL_KIND) + R*(REAL(IT3, BLAS_REAL_KIND) + R*REAL(IT4, BLAS_REAL_KIND))))
!
     IF (X(I) .EQ. ONE) THEN
!           If a real number has n bits of precision, and the first
!           n bits of the 48-bit integer above happen to be all 1 (which
!           will occur about once every 2**n calls), then X( I ) will
!           be rounded to exactly 1.0. In IEEE single precision arithmetic,
!           this will happen relatively often since n = 24.
!           Since X( I ) is not supposed to return exactly 0.0 or 1.0,
!           the statistically correct thing to do in this situation is
!           simply to iterate again.
!           N.B. the case X( I ) = 0.0 should not be possible.
        I1 = IT1
        I2 = IT2
        I3 = IT3
        I4 = IT4
        GOTO 1
     END IF
!
  END DO
!
!     Return final value of seed
!
  ISEED(1) = IT1
  ISEED(2) = IT2
  ISEED(3) = IT3
  ISEED(4) = IT4
!
!     End of GLARUV
!
END SUBROUTINE GLARUV
