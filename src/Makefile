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
HAVE_FMA=3
FCFLAGS=$(FCFLAGS) /DBLAS_INT_KIND=$(INT) /DHAVE_FMA=$(HAVE_FMA)
!IFNDEF IEEE
IEEE=0
!ENDIF # !IEEE
!IF "$(IEEE)"!="0"
FCFLAGS=$(FCFLAGS) /DUSE_IEEE_INTRINSIC=$(IEEE)
!ENDIF # ?IEEE
FCFLAGS=$(FCFLAGS) $(PVN_CPPFLAGS)
LDFLAGS=$(PVN_LDFLAGS) /LIBPATH:.. eptmglib_$(INT)$(IEEE).lib eplapack_$(INT)$(IEEE).lib epblas_$(INT)$(IEEE).lib $(PVN_LIBS)

O=..\obj_$(INT)$(IEEE)
T=..\exe_$(INT)$(IEEE)
L=..\epblas_$(INT)$(IEEE).lib ..\eplapack_$(INT)$(IEEE).lib ..\eptmglib_$(INT)$(IEEE).lib

G= \
$(O)\isamax.obj $(O)\idamax.obj $(O)\iqamax.obj \
$(O)\sasum.obj $(O)\dasum.obj $(O)\qasum.obj \
$(O)\saxpby.obj $(O)\daxpby.obj $(O)\qaxpby.obj \
$(O)\saxpy.obj $(O)\daxpy.obj $(O)\qaxpy.obj \
$(O)\scopy.obj $(O)\dcopy.obj $(O)\qcopy.obj \
$(O)\sdot.obj $(O)\ddot.obj $(O)\qdot.obj \
$(O)\sgbmv.obj $(O)\dgbmv.obj $(O)\qgbmv.obj \
$(O)\sgemm.obj $(O)\dgemm.obj $(O)\qgemm.obj \
$(O)\sgemmtr.obj $(O)\dgemmtr.obj $(O)\qgemmtr.obj \
$(O)\sgemv.obj $(O)\dgemv.obj $(O)\qgemv.obj \
$(O)\sger.obj $(O)\dger.obj $(O)\qger.obj \
$(O)\snrm2.obj $(O)\dnrm2.obj $(O)\qnrm2.obj \
$(O)\sscal.obj $(O)\dscal.obj $(O)\qscal.obj \
$(O)\stbmv.obj $(O)\dtbmv.obj $(O)\qtbmv.obj \
$(O)\dsdot.obj $(O)\qddot.obj

H= \
$(O)\icamax.obj $(O)\izamax.obj $(O)\iyamax.obj \
$(O)\icmax2.obj $(O)\izmax2.obj $(O)\iymax2.obj \
$(O)\caxpby.obj $(O)\zaxpby.obj $(O)\yaxpby.obj \
$(O)\caxpy.obj $(O)\zaxpy.obj $(O)\yaxpy.obj \
$(O)\scabs1.obj $(O)\dcabs1.obj $(O)\qcabs1.obj \
$(O)\scasum.obj $(O)\dzasum.obj $(O)\qyasum.obj \
$(O)\ccopy.obj $(O)\zcopy.obj $(O)\ycopy.obj \
$(O)\cdotc.obj $(O)\zdotc.obj $(O)\ydotc.obj \
$(O)\cdotu.obj $(O)\zdotu.obj $(O)\ydotu.obj \
$(O)\cgbmv.obj $(O)\zgbmv.obj $(O)\ygbmv.obj \
$(O)\cgemm.obj $(O)\zgemm.obj $(O)\ygemm.obj \
$(O)\cgemmtr.obj $(O)\zgemmtr.obj $(O)\ygemmtr.obj \
$(O)\cgemv.obj $(O)\zgemv.obj $(O)\ygemv.obj \
$(O)\cgerc.obj $(O)\zgerc.obj $(O)\ygerc.obj \
$(O)\cgeru.obj $(O)\zgeru.obj $(O)\ygeru.obj \
$(O)\chbmv.obj $(O)\zhbmv.obj $(O)\yhbmv.obj \
$(O)\chemm.obj $(O)\zhemm.obj $(O)\yhemm.obj \
$(O)\chemv.obj $(O)\zhemv.obj $(O)\yhemv.obj \
$(O)\scnrm2.obj $(O)\dznrm2.obj $(O)\qynrm2.obj \
$(O)\cscal.obj $(O)\zscal.obj $(O)\yscal.obj \
$(O)\csscal.obj $(O)\zdscal.obj $(O)\yqscal.obj

F= \
$(O)\slamch.obj $(O)\dlamch.obj $(O)\qlamch.obj \
$(O)\sroundup_lwork.obj $(O)\droundup_lwork.obj $(O)\qroundup_lwork.obj \
$(O)\second.obj $(O)\dsecnd.obj $(O)\qsecnd.obj \
$(O)\slacpy.obj $(O)\dlacpy.obj $(O)\qlacpy.obj \
$(O)\clacpy.obj $(O)\zlacpy.obj $(O)\ylacpy.obj \
$(O)\slaset.obj $(O)\dlaset.obj $(O)\qlaset.obj \
$(O)\claset.obj $(O)\zlaset.obj $(O)\ylaset.obj \
$(O)\slaruv.obj $(O)\dlaruv.obj $(O)\qlaruv.obj \
$(O)\slarnv.obj $(O)\dlarnv.obj $(O)\qlarnv.obj \
$(O)\clarnv.obj $(O)\zlarnv.obj $(O)\ylarnv.obj

M= \
$(O)\slaran.obj $(O)\dlaran.obj $(O)\qlaran.obj \
$(O)\slarnd.obj $(O)\dlarnd.obj $(O)\qlarnd.obj \
$(O)\clarnd.obj $(O)\zlarnd.obj $(O)\ylarnd.obj

E=$(T)\txerbla.exe \
$(T)\tslamch.exe $(T)\tdlamch.exe $(T)\tqlamch.exe \
$(T)\tsecond.exe $(T)\tdsecnd.exe $(T)\tqsecnd.exe \
$(T)\tsnrm2.exe $(T)\tdnrm2.exe $(T)\tqnrm2.exe \
$(T)\ticmax2.exe $(T)\tizmax2.exe $(T)\tiymax2.exe

all: dirs $(L) $(E)

help:
	@ECHO "nmake.exe [LIBPVN=..\..\libpvn] [INT=4|8] [IEEE=0|1] [all|help|test|clean]"

dirs:
	@ECHO LIBPVN=$(LIBPVN)
	@ECHO INT=$(INT)
	@ECHO IEEE=$(IEEE)
	@-MD $(O)
	@-MD $(T)

test: all
	@FOR %%I IN ($(E)) DO %%I

..\epblas_$(INT)$(IEEE).lib: $(G) $(H) $(O)\lsame.obj $(O)\xerbla.obj $(O)\xerbla_array.obj $(O)\xerrno.obj
	$(AR) $(ARFLAGS) /OUT:$@ $**

..\eplapack_$(INT)$(IEEE).lib: $(F) $(O)\lsamen.obj
	$(AR) $(ARFLAGS) /OUT:$@ $**

..\eptmglib_$(INT)$(IEEE).lib: $(M)
	$(AR) $(ARFLAGS) /OUT:$@ $**

$(T)\txerbla.exe: txerbla.F90
	$(FC) $(FCFLAGS) $? /Fe$@ $(LDFLAGS)

$(T)\tslamch.exe: tglamch.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DGLAMCH=SLAMCH $? /Fe$@ $(LDFLAGS)
$(T)\tdlamch.exe: tglamch.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DGLAMCH=DLAMCH $? /Fe$@ $(LDFLAGS)
$(T)\tqlamch.exe: tglamch.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DGLAMCH=QLAMCH $? /Fe$@ $(LDFLAGS)

$(T)\tsecond.exe: tgsecnd.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DGSECND=SECOND $? /Fe$@ $(LDFLAGS)
$(T)\tdsecnd.exe: tgsecnd.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DGSECND=DSECND $? /Fe$@ $(LDFLAGS)
$(T)\tqsecnd.exe: tgsecnd.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DGSECND=QSECND $? /Fe$@ $(LDFLAGS)

$(T)\tsnrm2.exe: tgnrm2.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DGNRM2=SNRM2 $? /Fe$@ $(LDFLAGS)
$(T)\tdnrm2.exe: tgnrm2.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DGNRM2=DNRM2 $? /Fe$@ $(LDFLAGS)
$(T)\tqnrm2.exe: tgnrm2.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DGNRM2=QNRM2 $? /Fe$@ $(LDFLAGS)

$(T)\ticmax2.exe: tihmax2.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DIHAMAX=ICAMAX /DIHMAX2=ICMAX2 $? /Fe$@ $(LDFLAGS)
$(T)\tizmax2.exe: tihmax2.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DIHAMAX=IZAMAX /DIHMAX2=IZMAX2 $? /Fe$@ $(LDFLAGS)
$(T)\tiymax2.exe: tihmax2.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DIHAMAX=IYAMAX /DIHMAX2=IYMAX2 $? /Fe$@ $(LDFLAGS)

$(O)\slaran.obj: glaran.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DGLARAN=SLARAN /c $? /Fo$@
$(O)\dlaran.obj: glaran.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DGLARAN=DLARAN /c $? /Fo$@
$(O)\qlaran.obj: glaran.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DGLARAN=QLARAN /c $? /Fo$@

$(O)\slarnd.obj: glarnd.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DGLARND=SLARND /DGLARAN=SLARAN /c $? /Fo$@
$(O)\dlarnd.obj: glarnd.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DGLARND=DLARND /DGLARAN=DLARAN /c $? /Fo$@
$(O)\qlarnd.obj: glarnd.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DGLARND=QLARND /DGLARAN=QLARAN /c $? /Fo$@

$(O)\clarnd.obj: hlarnd.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DHLARND=CLARND /DGLARAN=SLARAN /c $? /Fo$@
$(O)\zlarnd.obj: hlarnd.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DHLARND=ZLARND /DGLARAN=DLARAN /c $? /Fo$@
$(O)\ylarnd.obj: hlarnd.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DHLARND=YLARND /DGLARAN=QLARAN /c $? /Fo$@

$(O)\lsamen.obj: lsamen.F90
	$(FC) $(FCFLAGS) /c $? /Fo$@

$(O)\slamch.obj: glamch.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DGLAMCH=SLAMCH /c $? /Fo$@
$(O)\dlamch.obj: glamch.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DGLAMCH=DLAMCH /c $? /Fo$@
$(O)\qlamch.obj: glamch.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DGLAMCH=QLAMCH /c $? /Fo$@

$(O)\second.obj: gsecnd.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DGSECND=SECOND /c $? /Fo$@
$(O)\dsecnd.obj: gsecnd.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DGSECND=DSECND /c $? /Fo$@
$(O)\qsecnd.obj: gsecnd.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DGSECND=QSECND /c $? /Fo$@

$(O)\sroundup_lwork.obj: groundup_lwork.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DGROUNDUP_LWORK=SROUNDUP_LWORK /c $? /Fo$@
$(O)\droundup_lwork.obj: groundup_lwork.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DGROUNDUP_LWORK=DROUNDUP_LWORK /c $? /Fo$@
$(O)\qroundup_lwork.obj: groundup_lwork.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DGROUNDUP_LWORK=QROUNDUP_LWORK /c $? /Fo$@

$(O)\slacpy.obj: glacpy.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DGLACPY=SLACPY /c $? /Fo$@
$(O)\dlacpy.obj: glacpy.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DGLACPY=DLACPY /c $? /Fo$@
$(O)\qlacpy.obj: glacpy.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DGLACPY=QLACPY /c $? /Fo$@

$(O)\clacpy.obj: hlacpy.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DHLACPY=CLACPY /c $? /Fo$@
$(O)\zlacpy.obj: hlacpy.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DHLACPY=ZLACPY /c $? /Fo$@
$(O)\ylacpy.obj: hlacpy.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DHLACPY=YLACPY /c $? /Fo$@

$(O)\slaset.obj: glaset.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DGLASET=SLASET /c $? /Fo$@
$(O)\dlaset.obj: glaset.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DGLASET=DLASET /c $? /Fo$@
$(O)\qlaset.obj: glaset.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DGLASET=QLASET /c $? /Fo$@

$(O)\claset.obj: hlaset.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DHLASET=CLASET /c $? /Fo$@
$(O)\zlaset.obj: hlaset.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DHLASET=ZLASET /c $? /Fo$@
$(O)\ylaset.obj: hlaset.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DHLASET=YLASET /c $? /Fo$@

$(O)\slaruv.obj: glaruv.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DGLARUV=SLARUV /c $? /Fo$@
$(O)\dlaruv.obj: glaruv.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DGLARUV=DLARUV /c $? /Fo$@
$(O)\qlaruv.obj: glaruv.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DGLARUV=QLARUV /c $? /Fo$@

$(O)\slarnv.obj: glarnv.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DGLARNV=SLARNV /DGLARUV=SLARUV /c $? /Fo$@
$(O)\dlarnv.obj: glarnv.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DGLARNV=DLARNV /DGLARUV=DLARUV /c $? /Fo$@
$(O)\qlarnv.obj: glarnv.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DGLARNV=QLARNV /DGLARUV=QLARUV /c $? /Fo$@

$(O)\clarnv.obj: hlarnv.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DHLARNV=CLARNV /DGLARUV=SLARUV /c $? /Fo$@
$(O)\zlarnv.obj: hlarnv.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DHLARNV=ZLARNV /DGLARUV=DLARUV /c $? /Fo$@
$(O)\ylarnv.obj: hlarnv.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DHLARNV=YLARNV /DGLARUV=QLARUV /c $? /Fo$@

$(O)\lsame.obj: lsame.F90
	$(FC) $(FCFLAGS) /c $? /Fo$@
$(O)\xerbla.obj: xerbla.F90
	$(FC) $(FCFLAGS) /c $? /Fo$@
$(O)\xerbla_array.obj: xerbla_array.F90
	$(FC) $(FCFLAGS) /c $? /Fo$@
$(O)\xerrno.obj: xerrno.F90
	$(FC) $(FCFLAGS) /c $? /Fo$@

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
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DGAXPBY=SAXPBY /DGFMMA=PVN_SFMMA /c $? /Fo$@
$(O)\daxpby.obj: gaxpby.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DGAXPBY=DAXPBY /DGFMMA=PVN_DFMMA /c $? /Fo$@
$(O)\qaxpby.obj: gaxpby.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DGAXPBY=QAXPBY /DGFMMA=PVN_QFMMA /c $? /Fo$@

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
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DGGEMM=SGEMM /DGFMMA=PVN_SFMMA /c $? /Fo$@
$(O)\dgemm.obj: ggemm.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DGGEMM=DGEMM /DGFMMA=PVN_DFMMA /c $? /Fo$@
$(O)\qgemm.obj: ggemm.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DGGEMM=QGEMM /DGFMMA=PVN_QFMMA /c $? /Fo$@

$(O)\sgemmtr.obj: ggemmtr.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DGGEMMTR=SGEMMTR /DGFMMA=PVN_SFMMA /c $? /Fo$@
$(O)\dgemmtr.obj: ggemmtr.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DGGEMMTR=DGEMMTR /DGFMMA=PVN_DFMMA /c $? /Fo$@
$(O)\qgemmtr.obj: ggemmtr.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DGGEMMTR=QGEMMTR /DGFMMA=PVN_QFMMA /c $? /Fo$@

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

$(O)\stbmv.obj: gtbmv.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DGTBMV=STBMV /c $? /Fo$@
$(O)\dtbmv.obj: gtbmv.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DGTBMV=DTBMV /c $? /Fo$@
$(O)\qtbmv.obj: gtbmv.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DGTBMV=QTBMV /c $? /Fo$@

$(O)\dsdot.obj: gfdot.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DBLAS_REAL_KIND2=8 /DGFDOT=DSDOT /c $? /Fo$@
$(O)\qddot.obj: gfdot.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DBLAS_REAL_KIND2=16 /DGFDOT=QDDOT /c $? /Fo$@

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
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DHAXPBY=CAXPBY /DPVN_HMUL=PVN_CMUL /DPVN_HFMA=PVN_CFMA /DPVN_HFMMA=PVN_CFMMA /c $? /Fo$@
$(O)\zaxpby.obj: haxpby.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DHAXPBY=ZAXPBY /DPVN_HMUL=PVN_ZMUL /DPVN_HFMA=PVN_ZFMA /DPVN_HFMMA=PVN_ZFMMA /c $? /Fo$@
$(O)\yaxpby.obj: haxpby.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DHAXPBY=YAXPBY /DPVN_HMUL=PVN_YMUL /DPVN_HFMA=PVN_YFMA /DPVN_HFMMA=PVN_YFMMA /c $? /Fo$@

$(O)\caxpy.obj: haxpy.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DHAXPY=CAXPY /DPVN_HFMA=PVN_CFMA /c $? /Fo$@
$(O)\zaxpy.obj: haxpy.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DHAXPY=ZAXPY /DPVN_HFMA=PVN_ZFMA /c $? /Fo$@
$(O)\yaxpy.obj: haxpy.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DHAXPY=YAXPY /DPVN_HFMA=PVN_YFMA /c $? /Fo$@

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
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DHDOTC=CDOTC /DPVN_HFMA=PVN_CFMA /c $? /Fo$@
$(O)\zdotc.obj: hdotc.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DHDOTC=ZDOTC /DPVN_HFMA=PVN_ZFMA /c $? /Fo$@
$(O)\ydotc.obj: hdotc.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DHDOTC=YDOTC /DPVN_HFMA=PVN_YFMA /c $? /Fo$@

$(O)\cdotu.obj: hdotu.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DHDOTU=CDOTU /DPVN_HFMA=PVN_CFMA /c $? /Fo$@
$(O)\zdotu.obj: hdotu.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DHDOTU=ZDOTU /DPVN_HFMA=PVN_ZFMA /c $? /Fo$@
$(O)\ydotu.obj: hdotu.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DHDOTU=YDOTU /DPVN_HFMA=PVN_YFMA /c $? /Fo$@

$(O)\cgbmv.obj: hgbmv.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DHGBMV=CGBMV /DPVN_HMUL=PVN_CMUL /DPVN_HFMA=PVN_CFMA /c $? /Fo$@
$(O)\zgbmv.obj: hgbmv.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DHGBMV=ZGBMV /DPVN_HMUL=PVN_ZMUL /DPVN_HFMA=PVN_ZFMA /c $? /Fo$@
$(O)\ygbmv.obj: hgbmv.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DHGBMV=YGBMV /DPVN_HMUL=PVN_YMUL /DPVN_HFMA=PVN_YFMA /c $? /Fo$@

$(O)\cgemm.obj: hgemm.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DHGEMM=CGEMM /DPVN_HMUL=PVN_CMUL /DPVN_HFMA=PVN_CFMA /DPVN_HFMMA=PVN_CFMMA /c $? /Fo$@
$(O)\zgemm.obj: hgemm.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DHGEMM=ZGEMM /DPVN_HMUL=PVN_ZMUL /DPVN_HFMA=PVN_ZFMA /DPVN_HFMMA=PVN_ZFMMA /c $? /Fo$@
$(O)\ygemm.obj: hgemm.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DHGEMM=YGEMM /DPVN_HMUL=PVN_YMUL /DPVN_HFMA=PVN_YFMA /DPVN_HFMMA=PVN_YFMMA /c $? /Fo$@

$(O)\cgemmtr.obj: hgemmtr.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DHGEMMTR=CGEMMTR /DPVN_HMUL=PVN_CMUL /DPVN_HFMA=PVN_CFMA /DPVN_HFMMA=PVN_CFMMA /c $? /Fo$@
$(O)\zgemmtr.obj: hgemmtr.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DHGEMMTR=ZGEMMTR /DPVN_HMUL=PVN_ZMUL /DPVN_HFMA=PVN_ZFMA /DPVN_HFMMA=PVN_ZFMMA /c $? /Fo$@
$(O)\ygemmtr.obj: hgemmtr.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DHGEMMTR=YGEMMTR /DPVN_HMUL=PVN_YMUL /DPVN_HFMA=PVN_YFMA /DPVN_HFMMA=PVN_YFMMA /c $? /Fo$@

$(O)\cgemv.obj: hgemv.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DHGEMV=CGEMV /DPVN_HMUL=PVN_CMUL /DPVN_HFMA=PVN_CFMA /c $? /Fo$@
$(O)\zgemv.obj: hgemv.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DHGEMV=ZGEMV /DPVN_HMUL=PVN_ZMUL /DPVN_HFMA=PVN_ZFMA /c $? /Fo$@
$(O)\ygemv.obj: hgemv.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DHGEMV=YGEMV /DPVN_HMUL=PVN_YMUL /DPVN_HFMA=PVN_YFMA /c $? /Fo$@

$(O)\cgerc.obj: hgerc.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DHGERC=CGERC /DPVN_HMUL=PVN_CMUL /DPVN_HFMA=PVN_CFMA /c $? /Fo$@
$(O)\zgerc.obj: hgerc.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DHGERC=ZGERC /DPVN_HMUL=PVN_ZMUL /DPVN_HFMA=PVN_ZFMA /c $? /Fo$@
$(O)\ygerc.obj: hgerc.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DHGERC=YGERC /DPVN_HMUL=PVN_YMUL /DPVN_HFMA=PVN_YFMA /c $? /Fo$@

$(O)\cgeru.obj: hgeru.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DHGERU=CGERU /DPVN_HMUL=PVN_CMUL /DPVN_HFMA=PVN_CFMA /c $? /Fo$@
$(O)\zgeru.obj: hgeru.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DHGERU=ZGERU /DPVN_HMUL=PVN_ZMUL /DPVN_HFMA=PVN_ZFMA /c $? /Fo$@
$(O)\ygeru.obj: hgeru.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DHGERU=YGERU /DPVN_HMUL=PVN_YMUL /DPVN_HFMA=PVN_YFMA /c $? /Fo$@

$(O)\chbmv.obj: hhbmv.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DHHBMV=CHBMV /DPVN_HMUL=PVN_CMUL /DPVN_HFMA=PVN_CFMA /c $? /Fo$@
$(O)\zhbmv.obj: hhbmv.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DHHBMV=ZHBMV /DPVN_HMUL=PVN_ZMUL /DPVN_HFMA=PVN_ZFMA /c $? /Fo$@
$(O)\yhbmv.obj: hhbmv.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DHHBMV=YHBMV /DPVN_HMUL=PVN_YMUL /DPVN_HFMA=PVN_YFMA /c $? /Fo$@

$(O)\chemm.obj: hhemm.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DHHEMM=CHEMM /DPVN_HMUL=PVN_CMUL /DPVN_HFMA=PVN_CFMA /DPVN_HFMMA=PVN_CFMMA /c $? /Fo$@
$(O)\zhemm.obj: hhemm.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DHHEMM=ZHEMM /DPVN_HMUL=PVN_ZMUL /DPVN_HFMA=PVN_ZFMA /DPVN_HFMMA=PVN_ZFMMA /c $? /Fo$@
$(O)\yhemm.obj: hhemm.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DHHEMM=YHEMM /DPVN_HMUL=PVN_YMUL /DPVN_HFMA=PVN_YFMA /DPVN_HFMMA=PVN_YFMMA /c $? /Fo$@

$(O)\chemv.obj: hhemv.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DHHEMV=CHEMV /DPVN_HMUL=PVN_CMUL /DPVN_HFMA=PVN_CFMA /c $? /Fo$@
$(O)\zhemv.obj: hhemv.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DHHEMV=ZHEMV /DPVN_HMUL=PVN_ZMUL /DPVN_HFMA=PVN_ZFMA /c $? /Fo$@
$(O)\yhemv.obj: hhemv.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DHHEMV=YHEMV /DPVN_HMUL=PVN_YMUL /DPVN_HFMA=PVN_YFMA /c $? /Fo$@

$(O)\scnrm2.obj: ghnrm2.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DGHNRM2=SCNRM2 /c $? /Fo$@
$(O)\dznrm2.obj: ghnrm2.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DGHNRM2=DZNRM2 /c $? /Fo$@
$(O)\qynrm2.obj: ghnrm2.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DGHNRM2=QYNRM2 /c $? /Fo$@

$(O)\cscal.obj: hscal.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DHSCAL=CSCAL /DPVN_HMUL=PVN_CMUL /c $? /Fo$@
$(O)\zscal.obj: hscal.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DHSCAL=ZSCAL /DPVN_HMUL=PVN_ZMUL /c $? /Fo$@
$(O)\yscal.obj: hscal.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DHSCAL=YSCAL /DPVN_HMUL=PVN_YMUL /c $? /Fo$@

$(O)\csscal.obj: hgscal.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=4 /DHGSCAL=CSSCAL /c $? /Fo$@
$(O)\zdscal.obj: hgscal.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=8 /DHGSCAL=ZDSCAL /c $? /Fo$@
$(O)\yqscal.obj: hgscal.F90
	$(FC) $(FCFLAGS) /DBLAS_REAL_KIND=16 /DHGSCAL=YQSCAL /c $? /Fo$@

clean:
	@-DEL /F $(L)
	@-RD /S /Q $(T)
	@-RD /S /Q $(O)
