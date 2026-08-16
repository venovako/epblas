AR=lib.exe
ARFLAGS=/NOLOGO /VERBOSE
!IFNDEF LIBPVN
LIBPVN=..\..\libpvn
!ENDIF # !LIBPVN
!INCLUDE $(LIBPVN)\src\pvn.mk
FC=$(PVN_FC)
FCFLAGS=$(PVN_FCFLAGS)
!IFNDEF INT
INT=4
!ENDIF # !INT
!IF "$(INT)"=="8"
FCFLAGS=$(FCFLAGS) /4I8
!ENDIF # ?INT
REAL_KINDS=4,8,16
HAVE_FMA=15
FCFLAGS=$(FCFLAGS) /DBLAS_INT_KIND=$(INT) /DHAVE_FMA=$(HAVE_FMA)
!IFDEF IEEE
FCFLAGS=$(FCFLAGS) /DUSE_IEEE_INTRINSIC=$(IEEE)
!ELSE # !IEEE
IEEE=0
!ENDIF # ?IEEE
FCFLAGS=$(FCFLAGS) $(PVN_CPPFLAGS)
LDFLAGS=$(PVN_LDFLAGS) /LIBPATH:.. epblas$(INT)$(IEEE).lib $(PVN_LIBS)

O=..\obj$(INT)$(IEEE)
L=..\epblas$(INT)$(IEEE).lib

E= \
..\tsecond$(INT)$(IEEE).exe \
..\tdsecnd$(INT)$(IEEE).exe \
..\tqsecnd$(INT)$(IEEE).exe \
..\tslamch$(INT)$(IEEE).exe \
..\tdlamch$(INT)$(IEEE).exe \
..\tqlamch$(INT)$(IEEE).exe \
..\tsnrm2$(INT)$(IEEE).exe \
..\tdnrm2$(INT)$(IEEE).exe \
..\tqnrm2$(INT)$(IEEE).exe \
..\ticmax2$(INT)$(IEEE).exe \
..\tizmax2$(INT)$(IEEE).exe \
..\tiymax2$(INT)$(IEEE).exe

F= \
$(O)\lsame.obj \
$(O)\slamch.obj \
$(O)\dlamch.obj \
$(O)\qlamch.obj \
$(O)\sroundup_lwork.obj \
$(O)\droundup_lwork.obj \
$(O)\qroundup_lwork.obj \
$(O)\second.obj \
$(O)\dsecnd.obj \
$(O)\qsecnd.obj \
$(O)\xerbla.obj \
$(O)\xerbla_array.obj

G= \
$(O)\isamax.obj \
$(O)\idamax.obj \
$(O)\iqamax.obj \
$(O)\sasum.obj \
$(O)\dasum.obj \
$(O)\qasum.obj \
$(O)\saxpby.obj \
$(O)\daxpby.obj \
$(O)\qaxpby.obj \
$(O)\saxpy.obj \
$(O)\daxpy.obj \
$(O)\qaxpy.obj \
$(O)\scopy.obj \
$(O)\dcopy.obj \
$(O)\qcopy.obj \
$(O)\sdot.obj \
$(O)\ddot.obj \
$(O)\qdot.obj \
$(O)\sgbmv.obj \
$(O)\dgbmv.obj \
$(O)\qgbmv.obj \
$(O)\sgemm.obj \
$(O)\dgemm.obj \
$(O)\qgemm.obj \
$(O)\sgemmtr.obj \
$(O)\dgemmtr.obj \
$(O)\qgemmtr.obj \
$(O)\sgemv.obj \
$(O)\dgemv.obj \
$(O)\qgemv.obj \
$(O)\sger.obj \
$(O)\dger.obj \
$(O)\qger.obj \
$(O)\snrm2.obj \
$(O)\dnrm2.obj \
$(O)\qnrm2.obj \
$(O)\sscal.obj \
$(O)\dscal.obj \
$(O)\qscal.obj \
$(O)\dsdot.obj

H= \
$(O)\icamax.obj \
$(O)\izamax.obj \
$(O)\iyamax.obj \
$(O)\icmax2.obj \
$(O)\izmax2.obj \
$(O)\iymax2.obj \
$(O)\caxpby.obj \
$(O)\zaxpby.obj \
$(O)\yaxpby.obj \
$(O)\caxpy.obj \
$(O)\zaxpy.obj \
$(O)\yaxpy.obj \
$(O)\scabs1.obj \
$(O)\dcabs1.obj \
$(O)\qcabs1.obj \
$(O)\scasum.obj \
$(O)\dzasum.obj \
$(O)\qyasum.obj \
$(O)\ccopy.obj \
$(O)\zcopy.obj \
$(O)\ycopy.obj \
$(O)\cdotc.obj \
$(O)\zdotc.obj \
$(O)\ydotc.obj \
$(O)\cdotu.obj \
$(O)\zdotu.obj \
$(O)\ydotu.obj \
$(O)\cgbmv.obj \
$(O)\zgbmv.obj \
$(O)\ygbmv.obj \
$(O)\cgemm.obj \
$(O)\zgemm.obj \
$(O)\ygemm.obj \
$(O)\cgemmtr.obj \
$(O)\zgemmtr.obj \
$(O)\ygemmtr.obj \
$(O)\cgemv.obj \
$(O)\zgemv.obj \
$(O)\ygemv.obj \
$(O)\cgerc.obj \
$(O)\zgerc.obj \
$(O)\ygerc.obj \
$(O)\cgeru.obj \
$(O)\zgeru.obj \
$(O)\ygeru.obj \
$(O)\scnrm2.obj \
$(O)\dznrm2.obj \
$(O)\qynrm2.obj \
$(O)\cscal.obj \
$(O)\zscal.obj \
$(O)\yscal.obj \
$(O)\csscal.obj \
$(O)\zdscal.obj \
$(O)\yqscal.obj

all: dirs $(L) $(E)

help:
	@ECHO "nmake.exe [LIBPVN=..\..\libpvn] [INT=4|8] [IEEE=0] [all|help|clean]"

dirs:
	@ECHO LIBPVN=$(LIBPVN)
	@ECHO INT=$(INT)
	@ECHO IEEE=$(IEEE)
	@ECHO REAL_KINDS=$(REAL_KINDS)
	@ECHO HAVE_FMA=$(HAVE_FMA)
	@-MD $(O)

$(L): $(F) $(G) $(H)
	$(AR) $(ARFLAGS) /OUT:$@ $**

..\tsecond$(INT)$(IEEE).exe: tgsecnd.F90 $(L)
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DGSECND=SECOND $? /Fe$@ $(LDFLAGS)
..\tdsecnd$(INT)$(IEEE).exe: tgsecnd.F90 $(L)
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DGSECND=DSECND $? /Fe$@ $(LDFLAGS)
..\tqsecnd$(INT)$(IEEE).exe: tgsecnd.F90 $(L)
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DGSECND=QSECND $? /Fe$@ $(LDFLAGS)

..\tslamch$(INT)$(IEEE).exe: tglamch.F90 $(L)
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DGLAMCH=SLAMCH $? /Fe$@ $(LDFLAGS)
..\tdlamch$(INT)$(IEEE).exe: tglamch.F90 $(L)
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DGLAMCH=DLAMCH $? /Fe$@ $(LDFLAGS)
..\tqlamch$(INT)$(IEEE).exe: tglamch.F90 $(L)
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DGLAMCH=QLAMCH $? /Fe$@ $(LDFLAGS)

..\tsnrm2$(INT)$(IEEE).exe: tgnrm2.F90 $(L)
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DGNRM2=SNRM2 $? /Fe$@ $(LDFLAGS)
..\tdnrm2$(INT)$(IEEE).exe: tgnrm2.F90 $(L)
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DGNRM2=DNRM2 $? /Fe$@ $(LDFLAGS)
..\tqnrm2$(INT)$(IEEE).exe: tgnrm2.F90 $(L)
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DGNRM2=QNRM2 $? /Fe$@ $(LDFLAGS)

..\ticmax2$(INT)$(IEEE).exe: tihmax2.F90 $(L)
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DIHAMAX=ICAMAX /DIHMAX2=ICMAX2 $? /Fe$@ $(LDFLAGS)
..\tizmax2$(INT)$(IEEE).exe: tihmax2.F90 $(L)
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DIHAMAX=IZAMAX /DIHMAX2=IZMAX2 $? /Fe$@ $(LDFLAGS)
..\tiymax2$(INT)$(IEEE).exe: tihmax2.F90 $(L)
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DIHAMAX=IYAMAX /DIHMAX2=IYMAX2 $? /Fe$@ $(LDFLAGS)

$(O)\lsame.obj: lsame.F90
	$(FC) $(FCFLAGS) /c $? /Fo$@
$(O)\xerbla.obj: xerbla.F90
	$(FC) $(FCFLAGS) /c $? /Fo$@
$(O)\xerbla_array.obj: xerbla_array.F90
	$(FC) $(FCFLAGS) /c $? /Fo$@

$(O)\slamch.obj: glamch.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DGLAMCH=SLAMCH /c $? /Fo$@
$(O)\dlamch.obj: glamch.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DGLAMCH=DLAMCH /c $? /Fo$@
$(O)\qlamch.obj: glamch.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DGLAMCH=QLAMCH /c $? /Fo$@

$(O)\sroundup_lwork.obj: groundup_lwork.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DGROUNDUP_LWORK=SROUNDUP_LWORK /c $? /Fo$@
$(O)\droundup_lwork.obj: groundup_lwork.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DGROUNDUP_LWORK=DROUNDUP_LWORK /c $? /Fo$@
$(O)\qroundup_lwork.obj: groundup_lwork.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DGROUNDUP_LWORK=QROUNDUP_LWORK /c $? /Fo$@

$(O)\second.obj: gsecnd.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DGSECND=SECOND /c $? /Fo$@
$(O)\dsecnd.obj: gsecnd.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DGSECND=DSECND /c $? /Fo$@
$(O)\qsecnd.obj: gsecnd.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DGSECND=QSECND /c $? /Fo$@

$(O)\isamax.obj: igamax.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DIGAMAX=ISAMAX /c $? /Fo$@
$(O)\idamax.obj: igamax.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DIGAMAX=IDAMAX /c $? /Fo$@
$(O)\iqamax.obj: igamax.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DIGAMAX=IQAMAX /c $? /Fo$@

$(O)\sasum.obj: gasum.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DGASUM=SASUM /c $? /Fo$@
$(O)\dasum.obj: gasum.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DGASUM=DASUM /c $? /Fo$@
$(O)\qasum.obj: gasum.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DGASUM=QASUM /c $? /Fo$@

$(O)\saxpby.obj: gaxpby.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DGAXPBY=SAXPBY /c $? /Fo$@
$(O)\daxpby.obj: gaxpby.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DGAXPBY=DAXPBY /c $? /Fo$@
$(O)\qaxpby.obj: gaxpby.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DGAXPBY=QAXPBY /c $? /Fo$@

$(O)\saxpy.obj: gaxpy.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DGAXPY=SAXPY /c $? /Fo$@
$(O)\daxpy.obj: gaxpy.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DGAXPY=DAXPY /c $? /Fo$@
$(O)\qaxpy.obj: gaxpy.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DGAXPY=QAXPY /c $? /Fo$@

$(O)\scopy.obj: gcopy.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DGCOPY=SCOPY /c $? /Fo$@
$(O)\dcopy.obj: gcopy.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DGCOPY=DCOPY /c $? /Fo$@
$(O)\qcopy.obj: gcopy.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DGCOPY=QCOPY /c $? /Fo$@

$(O)\sdot.obj: gdot.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DGDOT=SDOT /c $? /Fo$@
$(O)\ddot.obj: gdot.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DGDOT=DDOT /c $? /Fo$@
$(O)\qdot.obj: gdot.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DGDOT=QDOT /c $? /Fo$@

$(O)\sgbmv.obj: ggbmv.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DGGBMV=SGBMV /c $? /Fo$@
$(O)\dgbmv.obj: ggbmv.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DGGBMV=DGBMV /c $? /Fo$@
$(O)\qgbmv.obj: ggbmv.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DGGBMV=QGBMV /c $? /Fo$@

$(O)\sgemm.obj: ggemm.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DGGEMM=SGEMM /c $? /Fo$@
$(O)\dgemm.obj: ggemm.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DGGEMM=DGEMM /c $? /Fo$@
$(O)\qgemm.obj: ggemm.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DGGEMM=QGEMM /c $? /Fo$@

$(O)\sgemmtr.obj: ggemmtr.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DGGEMMTR=SGEMMTR /c $? /Fo$@
$(O)\dgemmtr.obj: ggemmtr.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DGGEMMTR=DGEMMTR /c $? /Fo$@
$(O)\qgemmtr.obj: ggemmtr.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DGGEMMTR=QGEMMTR /c $? /Fo$@

$(O)\sgemv.obj: ggemv.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DGGEMV=SGEMV /c $? /Fo$@
$(O)\dgemv.obj: ggemv.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DGGEMV=DGEMV /c $? /Fo$@
$(O)\qgemv.obj: ggemv.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DGGEMV=QGEMV /c $? /Fo$@

$(O)\sger.obj: gger.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DGGER=SGER /c $? /Fo$@
$(O)\dger.obj: gger.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DGGER=DGER /c $? /Fo$@
$(O)\qger.obj: gger.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DGGER=QGER /c $? /Fo$@

$(O)\snrm2.obj: gnrm2.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DGNRM2=SNRM2 /c $? /Fo$@
$(O)\dnrm2.obj: gnrm2.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DGNRM2=DNRM2 /c $? /Fo$@
$(O)\qnrm2.obj: gnrm2.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DGNRM2=QNRM2 /c $? /Fo$@

$(O)\sscal.obj: gscal.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DGSCAL=SSCAL /c $? /Fo$@
$(O)\dscal.obj: gscal.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DGSCAL=DSCAL /c $? /Fo$@
$(O)\qscal.obj: gscal.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DGSCAL=QSCAL /c $? /Fo$@

$(O)\dsdot.obj: gfdot.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DBLAS_REAL_KIND2=8 /DGFDOT=DSDOT /c $? /Fo$@

$(O)\icamax.obj: ihamax.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DIHAMAX=ICAMAX /c $? /Fo$@
$(O)\izamax.obj: ihamax.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DIHAMAX=IZAMAX /c $? /Fo$@
$(O)\iyamax.obj: ihamax.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DIHAMAX=IYAMAX /c $? /Fo$@

$(O)\icmax2.obj: ihmax2.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DIHMAX2=ICMAX2 /c $? /Fo$@
$(O)\izmax2.obj: ihmax2.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DIHMAX2=IZMAX2 /c $? /Fo$@
$(O)\iymax2.obj: ihmax2.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DIHMAX2=IYMAX2 /c $? /Fo$@

$(O)\caxpby.obj: haxpby.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DHAXPBY=CAXPBY /c $? /Fo$@
$(O)\zaxpby.obj: haxpby.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DHAXPBY=ZAXPBY /c $? /Fo$@
$(O)\yaxpby.obj: haxpby.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DHAXPBY=YAXPBY /c $? /Fo$@

$(O)\caxpy.obj: haxpy.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DHAXPY=CAXPY /c $? /Fo$@
$(O)\zaxpy.obj: haxpy.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DHAXPY=ZAXPY /c $? /Fo$@
$(O)\yaxpy.obj: haxpy.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DHAXPY=YAXPY /c $? /Fo$@

$(O)\scabs1.obj: gcabs1.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DGCABS1=SCABS1 /c $? /Fo$@
$(O)\dcabs1.obj: gcabs1.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DGCABS1=DCABS1 /c $? /Fo$@
$(O)\qcabs1.obj: gcabs1.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DGCABS1=QCABS1 /c $? /Fo$@

$(O)\scasum.obj: ghasum.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DGHASUM=SCASUM /c $? /Fo$@
$(O)\dzasum.obj: ghasum.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DGHASUM=DZASUM /c $? /Fo$@
$(O)\qyasum.obj: ghasum.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DGHASUM=QYASUM /c $? /Fo$@

$(O)\ccopy.obj: hcopy.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DHCOPY=CCOPY /c $? /Fo$@
$(O)\zcopy.obj: hcopy.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DHCOPY=ZCOPY /c $? /Fo$@
$(O)\ycopy.obj: hcopy.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DHCOPY=YCOPY /c $? /Fo$@

$(O)\cdotc.obj: hdotc.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DHDOTC=CDOTC /c $? /Fo$@
$(O)\zdotc.obj: hdotc.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DHDOTC=ZDOTC /c $? /Fo$@
$(O)\ydotc.obj: hdotc.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DHDOTC=YDOTC /c $? /Fo$@

$(O)\cdotu.obj: hdotu.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DHDOTU=CDOTU /c $? /Fo$@
$(O)\zdotu.obj: hdotu.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DHDOTU=ZDOTU /c $? /Fo$@
$(O)\ydotu.obj: hdotu.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DHDOTU=YDOTU /c $? /Fo$@

$(O)\cgbmv.obj: hgbmv.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DHGBMV=CGBMV /c $? /Fo$@
$(O)\zgbmv.obj: hgbmv.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DHGBMV=ZGBMV /c $? /Fo$@
$(O)\ygbmv.obj: hgbmv.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DHGBMV=YGBMV /c $? /Fo$@

$(O)\cgemm.obj: hgemm.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DHGEMM=CGEMM /c $? /Fo$@
$(O)\zgemm.obj: hgemm.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DHGEMM=ZGEMM /c $? /Fo$@
$(O)\ygemm.obj: hgemm.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DHGEMM=YGEMM /c $? /Fo$@

$(O)\cgemmtr.obj: hgemmtr.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DHGEMMTR=CGEMMTR /c $? /Fo$@
$(O)\zgemmtr.obj: hgemmtr.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DHGEMMTR=ZGEMMTR /c $? /Fo$@
$(O)\ygemmtr.obj: hgemmtr.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DHGEMMTR=YGEMMTR /c $? /Fo$@

$(O)\cgemv.obj: hgemv.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DHGEMV=CGEMV /c $? /Fo$@
$(O)\zgemv.obj: hgemv.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DHGEMV=ZGEMV /c $? /Fo$@
$(O)\ygemv.obj: hgemv.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DHGEMV=YGEMV /c $? /Fo$@

$(O)\cgerc.obj: hgerc.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DHGERC=CGERC /c $? /Fo$@
$(O)\zgerc.obj: hgerc.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DHGERC=ZGERC /c $? /Fo$@
$(O)\ygerc.obj: hgerc.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DHGERC=YGERC /c $? /Fo$@

$(O)\cgeru.obj: hgeru.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DHGERU=CGERU /c $? /Fo$@
$(O)\zgeru.obj: hgeru.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DHGERU=ZGERU /c $? /Fo$@
$(O)\ygeru.obj: hgeru.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DHGERU=YGERU /c $? /Fo$@

$(O)\scnrm2.obj: ghnrm2.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DGHNRM2=SCNRM2 /c $? /Fo$@
$(O)\dznrm2.obj: ghnrm2.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DGHNRM2=DZNRM2 /c $? /Fo$@
$(O)\qynrm2.obj: ghnrm2.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DGHNRM2=QYNRM2 /c $? /Fo$@

$(O)\cscal.obj: hscal.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DHSCAL=CSCAL /c $? /Fo$@
$(O)\zscal.obj: hscal.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DHSCAL=ZSCAL /c $? /Fo$@
$(O)\yscal.obj: hscal.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DHSCAL=YSCAL /c $? /Fo$@

$(O)\csscal.obj: hgscal.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DHGSCAL=CSSCAL /c $? /Fo$@
$(O)\zdscal.obj: hgscal.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DHGSCAL=ZDSCAL /c $? /Fo$@
$(O)\yqscal.obj: hgscal.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DHGSCAL=YQSCAL /c $? /Fo$@

clean:
	@-DEL /F $(E)
	@-DEL /F $(L)
	@-RD /S /Q $(O)
