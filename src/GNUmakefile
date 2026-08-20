MACHINE:=$(shell uname -m)
ifeq ($(MACHINE),amd64)
ARCH:=x86_64
else # !amd64
ifeq ($(MACHINE),aarch64)
ARCH:=arm64
else # !aarch64
ARCH:=$(MACHINE)
endif # ?aarch64
endif # ?amd64
AR:=ar
ARFLAGS:=rsv
ifndef LIBPVN
LIBPVN:=../../libpvn
endif # !LIBPVN
MK=$(LIBPVN)/src/pvn.mk
include $(MK)
FC:=$(PVN_FC)
FCFLAGS=$(PVN_FCFLAGS)
# Fortran kinds
ifndef REAL32
REAL32:=4
endif # !REAL32
ifndef REAL64
REAL64:=8
endif # !REAL64
ifndef REAL80
REAL80:=10
endif # !REAL80
ifndef REAL128
REAL128:=16
endif # !REAL128
ifndef INT32
INT32:=4
endif # !INT32
ifndef INT64
INT64:=8
endif # !INT64
ifndef INT
INT:=$(INT32)
endif # !INT
ifeq ($(findstring gfortran,$(FC)),gfortran)
ifeq ($(INT),$(INT64))
FCFLAGS += -fdefault-integer-8
endif # ?INT
ifeq ($(ARCH),x86_64)
REAL_KINDS:=$(REAL32),$(REAL64),$(REAL80),$(REAL128)
else # !x86_64
REAL_KINDS:=$(REAL32),$(REAL64),$(REAL128)
endif # ?x86_64
else # !gfortran
ifeq ($(INT),$(INT64))
FCFLAGS += -i8
endif # ?INT
ifeq ($(findstring nvfortran,$(FC)),nvfortran)
REAL_KINDS:=$(REAL32),$(REAL64)
else # !nvfortran
REAL_KINDS:=$(REAL32),$(REAL64),$(REAL128)
endif # ?nvfortran
endif # ?gfortran
ifndef IEEE
IEEE:=0
endif # !IEEE
ifneq ($(IEEE),0)
ifneq ($(IEEE),-1)
FCFLAGS += -DUSE_IEEE_INTRINSIC=$(IEEE)
endif # !spec IEEE
endif # ?IEEE
ifeq ($(ARCH),x86_64)
# HACK: HAVE_FMA set for KIND=10 does NOT indicate that FMA is available,
# but instead that fmal(3) calls are too expensive and should be avoided,
# effectively turning the FMAs off for extended precision!!!  HAVE_FMA:=3
# re-enables the calls at a huge performance penalty compared to MUL&ADD.
ifeq ($(IEEE),-1)
HAVE_FMA:=3
else # !spec IEEE
HAVE_FMA:=7
endif # ?IEEE
else # !x86_64
ifeq ($(findstring ppc64,$(ARCH)),ppc64)
# HACK: if REAL128 is NOT the quadruple precision, set HAVE_FMA:=15 to indicate that.
ifeq ($(IEEE),-1)
HAVE_FMA:=15
else # !spec IEEE
HAVE_FMA:=11
endif # ?IEEE
else # !ppc64
HAVE_FMA:=3
endif # ?ppc64
endif # ?x86_64
FCFLAGS += -DBLAS_INT_KIND=$(INT) -DHAVE_FMA=$(HAVE_FMA)
FCFLAGS += $(PVN_CPPFLAGS)
LDFLAGS:=$(PVN_LDFLAGS) -L.. -leptmglib_$(INT)$(IEEE) -leplapack_$(INT)$(IEEE) -lepblas_$(INT)$(IEEE) $(PVN_LIBS)

MK += GNUmakefile
O:=../obj_$(INT)$(IEEE)
T:=../exe_$(INT)$(IEEE)
L:=../libepblas_$(INT)$(IEEE).a ../libeplapack_$(INT)$(IEEE).a ../libeptmglib_$(INT)$(IEEE).a

G=\
$(O)/isamax.o $(O)/idamax.o\
$(O)/sasum.o $(O)/dasum.o\
$(O)/saxpby.o $(O)/daxpby.o\
$(O)/saxpy.o $(O)/daxpy.o\
$(O)/scopy.o $(O)/dcopy.o\
$(O)/sdot.o $(O)/ddot.o\
$(O)/sgbmv.o $(O)/dgbmv.o\
$(O)/sgemm.o $(O)/dgemm.o\
$(O)/sgemmtr.o $(O)/dgemmtr.o\
$(O)/sgemv.o $(O)/dgemv.o\
$(O)/sger.o $(O)/dger.o\
$(O)/snrm2.o $(O)/dnrm2.o\
$(O)/sscal.o $(O)/dscal.o\
$(O)/dsdot.o
ifeq ($(findstring $(REAL80),$(REAL_KINDS)),$(REAL80))
G += \
$(O)/ixamax.o\
$(O)/xasum.o\
$(O)/xaxpby.o\
$(O)/xaxpy.o\
$(O)/xcopy.o\
$(O)/xdot.o\
$(O)/xgbmv.o\
$(O)/xgemm.o\
$(O)/xgemmtr.o\
$(O)/xgemv.o\
$(O)/xger.o\
$(O)/xnrm2.o\
$(O)/xscal.o\
$(O)/xsdot.o\
$(O)/xddot.o\
$(O)/qxdot.o
endif # REAL80
ifeq ($(findstring $(REAL128),$(REAL_KINDS)),$(REAL128))
G += \
$(O)/iqamax.o\
$(O)/qasum.o\
$(O)/qaxpby.o\
$(O)/qaxpy.o\
$(O)/qcopy.o\
$(O)/qdot.o\
$(O)/qgbmv.o\
$(O)/qgemm.o\
$(O)/qgemmtr.o\
$(O)/qgemv.o\
$(O)/qger.o\
$(O)/qnrm2.o\
$(O)/qscal.o\
$(O)/qddot.o
endif # REAL128

H=\
$(O)/icamax.o $(O)/izamax.o\
$(O)/icmax2.o $(O)/izmax2.o\
$(O)/caxpby.o $(O)/zaxpby.o\
$(O)/caxpy.o $(O)/zaxpy.o\
$(O)/scabs1.o $(O)/dcabs1.o\
$(O)/scasum.o $(O)/dzasum.o\
$(O)/ccopy.o $(O)/zcopy.o\
$(O)/cdotc.o $(O)/zdotc.o\
$(O)/cdotu.o $(O)/zdotu.o\
$(O)/cgbmv.o $(O)/zgbmv.o\
$(O)/cgemm.o $(O)/zgemm.o\
$(O)/cgemmtr.o $(O)/zgemmtr.o\
$(O)/cgemv.o $(O)/zgemv.o\
$(O)/cgerc.o $(O)/zgerc.o\
$(O)/cgeru.o $(O)/zgeru.o\
$(O)/scnrm2.o $(O)/dznrm2.o\
$(O)/cscal.o $(O)/zscal.o\
$(O)/csscal.o $(O)/zdscal.o
ifeq ($(findstring $(REAL80),$(REAL_KINDS)),$(REAL80))
H += \
$(O)/iwamax.o\
$(O)/iwmax2.o\
$(O)/waxpby.o\
$(O)/waxpy.o\
$(O)/xcabs1.o\
$(O)/xwasum.o\
$(O)/wcopy.o\
$(O)/wdotc.o\
$(O)/wdotu.o\
$(O)/wgbmv.o\
$(O)/wgemm.o\
$(O)/wgemmtr.o\
$(O)/wgemv.o\
$(O)/wgerc.o\
$(O)/wgeru.o\
$(O)/xwnrm2.o\
$(O)/wscal.o\
$(O)/wxscal.o
endif # REAL80
ifeq ($(findstring $(REAL128),$(REAL_KINDS)),$(REAL128))
H += \
$(O)/iyamax.o\
$(O)/iymax2.o\
$(O)/yaxpby.o\
$(O)/yaxpy.o\
$(O)/qcabs1.o\
$(O)/qyasum.o\
$(O)/ycopy.o\
$(O)/ydotc.o\
$(O)/ydotu.o\
$(O)/ygbmv.o\
$(O)/ygemm.o\
$(O)/ygemmtr.o\
$(O)/ygemv.o\
$(O)/ygerc.o\
$(O)/ygeru.o\
$(O)/qynrm2.o\
$(O)/yscal.o\
$(O)/yqscal.o
endif # REAL128

F=\
$(O)/slamch.o $(O)/dlamch.o\
$(O)/sroundup_lwork.o $(O)/droundup_lwork.o\
$(O)/second.o $(O)/dsecnd.o
ifeq ($(findstring $(REAL80),$(REAL_KINDS)),$(REAL80))
F += \
$(O)/xlamch.o\
$(O)/xroundup_lwork.o\
$(O)/xsecnd.o
endif # REAL80
ifeq ($(findstring $(REAL128),$(REAL_KINDS)),$(REAL128))
F += \
$(O)/qlamch.o\
$(O)/qroundup_lwork.o\
$(O)/qsecnd.o
endif # REAL128

M=\
$(O)/slaran.o $(O)/dlaran.o\
$(O)/slarnd.o $(O)/dlarnd.o\
$(O)/clarnd.o $(O)/zlarnd.o
ifeq ($(findstring $(REAL80),$(REAL_KINDS)),$(REAL80))
M += \
$(O)/xlaran.o\
$(O)/xlarnd.o\
$(O)/wlarnd.o
endif # REAL80
ifeq ($(findstring $(REAL128),$(REAL_KINDS)),$(REAL128))
M += \
$(O)/qlaran.o\
$(O)/qlarnd.o\
$(O)/ylarnd.o
endif # REAL128

E=\
$(T)/tsecond.exe $(T)/tdsecnd.exe\
$(T)/tslamch.exe $(T)/tdlamch.exe\
$(T)/tsnrm2.exe $(T)/tdnrm2.exe\
$(T)/ticmax2.exe $(T)/tizmax2.exe
ifeq ($(findstring $(REAL80),$(REAL_KINDS)),$(REAL80))
E += \
$(T)/txsecnd.exe\
$(T)/txlamch.exe\
$(T)/txnrm2.exe\
$(T)/tiwmax2.exe
endif # REAL80
ifeq ($(findstring $(REAL128),$(REAL_KINDS)),$(REAL128))
E += \
$(T)/tqsecnd.exe\
$(T)/tqlamch.exe\
$(T)/tqnrm2.exe\
$(T)/tiymax2.exe
endif # REAL128

.PHONY: all help dirs clean

all: dirs $(L) $(E)

help:
	@echo "$(MAKE) [LIBPVN=../../libpvn] [INT=$(INT32)|$(INT64)] [IEEE=0|-1|1|2] [all|help|clean]"

dirs:
	@echo "ARCH=$(ARCH)"
	@echo "LIBPVN=$(LIBPVN)"
	@echo "INT=$(INT)"
	@echo "IEEE=$(IEEE)"
	@echo "REAL_KINDS=$(REAL_KINDS)"
	@echo "HAVE_FMA=$(HAVE_FMA)"
	@mkdir -pv $(O)
	@mkdir -pv $(T)

../libepblas_$(INT)$(IEEE).a: $(G) $(H) $(O)/lsame.o $(O)/xerbla.o $(O)/xerbla_array.o
	$(AR) $(ARFLAGS) $@ $^

../libeplapack_$(INT)$(IEEE).a: $(F)
	$(AR) $(ARFLAGS) $@ $^

../libeptmglib_$(INT)$(IEEE).a: $(M)
	$(AR) $(ARFLAGS) $@ $^

$(T)/tsecond.exe: tgsecnd.F90 $(L) $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DGSECND=SECOND $< -o $@ $(LDFLAGS)
$(T)/tdsecnd.exe: tgsecnd.F90 $(L) $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DGSECND=DSECND $< -o $@ $(LDFLAGS)
$(T)/txsecnd.exe: tgsecnd.F90 $(L) $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL80) -DGSECND=XSECND $< -o $@ $(LDFLAGS)
$(T)/tqsecnd.exe: tgsecnd.F90 $(L) $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL128) -DGSECND=QSECND $< -o $@ $(LDFLAGS)

$(T)/tslamch.exe: tglamch.F90 $(L) $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DGLAMCH=SLAMCH $< -o $@ $(LDFLAGS)
$(T)/tdlamch.exe: tglamch.F90 $(L) $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DGLAMCH=DLAMCH $< -o $@ $(LDFLAGS)
$(T)/txlamch.exe: tglamch.F90 $(L) $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL80) -DGLAMCH=XLAMCH $< -o $@ $(LDFLAGS)
$(T)/tqlamch.exe: tglamch.F90 $(L) $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL128) -DGLAMCH=QLAMCH $< -o $@ $(LDFLAGS)

$(T)/tsnrm2.exe: tgnrm2.F90 $(L) $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DGNRM2=SNRM2 $< -o $@ $(LDFLAGS)
$(T)/tdnrm2.exe: tgnrm2.F90 $(L) $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DGNRM2=DNRM2 $< -o $@ $(LDFLAGS)
$(T)/txnrm2.exe: tgnrm2.F90 $(L) $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL80) -DGNRM2=XNRM2 $< -o $@ $(LDFLAGS)
$(T)/tqnrm2.exe: tgnrm2.F90 $(L) $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL128) -DGNRM2=QNRM2 $< -o $@ $(LDFLAGS)

$(T)/ticmax2.exe: tihmax2.F90 $(L) $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DIHAMAX=ICAMAX -DIHMAX2=ICMAX2 $< -o $@ $(LDFLAGS)
$(T)/tizmax2.exe: tihmax2.F90 $(L) $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DIHAMAX=IZAMAX -DIHMAX2=IZMAX2 $< -o $@ $(LDFLAGS)
$(T)/tiwmax2.exe: tihmax2.F90 $(L) $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL80) -DIHAMAX=IWAMAX -DIHMAX2=IWMAX2 $< -o $@ $(LDFLAGS)
$(T)/tiymax2.exe: tihmax2.F90 $(L) $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL128) -DIHAMAX=IYAMAX -DIHMAX2=IYMAX2 $< -o $@ $(LDFLAGS)

$(O)/slaran.o: glaran.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DGLARAN=SLARAN -c $< -o $@
$(O)/dlaran.o: glaran.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DGLARAN=DLARAN -c $< -o $@
$(O)/xlaran.o: glaran.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL80) -DGLARAN=XLARAN -c $< -o $@
$(O)/qlaran.o: glaran.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL128) -DGLARAN=QLARAN -c $< -o $@

$(O)/slarnd.o: glarnd.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DGLARND=SLARND -DGLARAN=SLARAN -c $< -o $@
$(O)/dlarnd.o: glarnd.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DGLARND=DLARND -DGLARAN=DLARAN -c $< -o $@
$(O)/xlarnd.o: glarnd.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL80) -DGLARND=XLARND -DGLARAN=XLARAN -c $< -o $@
$(O)/qlarnd.o: glarnd.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL128) -DGLARND=QLARND -DGLARAN=QLARAN -c $< -o $@

$(O)/clarnd.o: hlarnd.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DHLARND=CLARND -DGLARAN=SLARAN -c $< -o $@
$(O)/zlarnd.o: hlarnd.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DHLARND=ZLARND -DGLARAN=DLARAN -c $< -o $@
$(O)/wlarnd.o: hlarnd.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL80) -DHLARND=WLARND -DGLARAN=XLARAN -c $< -o $@
$(O)/ylarnd.o: hlarnd.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL128) -DHLARND=YLARND -DGLARAN=QLARAN -c $< -o $@

$(O)/slamch.o: glamch.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DGLAMCH=SLAMCH -c $< -o $@
$(O)/dlamch.o: glamch.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DGLAMCH=DLAMCH -c $< -o $@
$(O)/xlamch.o: glamch.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL80) -DGLAMCH=XLAMCH -c $< -o $@
$(O)/qlamch.o: glamch.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL128) -DGLAMCH=QLAMCH -c $< -o $@

$(O)/sroundup_lwork.o: groundup_lwork.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DGROUNDUP_LWORK=SROUNDUP_LWORK -c $< -o $@
$(O)/droundup_lwork.o: groundup_lwork.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DGROUNDUP_LWORK=DROUNDUP_LWORK -c $< -o $@
$(O)/xroundup_lwork.o: groundup_lwork.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL80) -DGROUNDUP_LWORK=XROUNDUP_LWORK -c $< -o $@
$(O)/qroundup_lwork.o: groundup_lwork.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL128) -DGROUNDUP_LWORK=QROUNDUP_LWORK -c $< -o $@

$(O)/second.o: gsecnd.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DGSECND=SECOND -c $< -o $@
$(O)/dsecnd.o: gsecnd.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DGSECND=DSECND -c $< -o $@
$(O)/xsecnd.o: gsecnd.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL80) -DGSECND=XSECND -c $< -o $@
$(O)/qsecnd.o: gsecnd.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL128) -DGSECND=QSECND -c $< -o $@

$(O)/lsame.o: lsame.F90 $(MK)
	$(FC) $(FCFLAGS) -c $< -o $@
$(O)/xerbla.o: xerbla.F90 $(MK)
	$(FC) $(FCFLAGS) -c $< -o $@
$(O)/xerbla_array.o: xerbla_array.F90 $(MK)
	$(FC) $(FCFLAGS) -c $< -o $@

$(O)/isamax.o: igamax.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DIGAMAX=ISAMAX -c $< -o $@
$(O)/idamax.o: igamax.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DIGAMAX=IDAMAX -c $< -o $@
$(O)/ixamax.o: igamax.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL80) -DIGAMAX=IXAMAX -c $< -o $@
$(O)/iqamax.o: igamax.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL128) -DIGAMAX=IQAMAX -c $< -o $@

$(O)/sasum.o: gasum.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DGASUM=SASUM -c $< -o $@
$(O)/dasum.o: gasum.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DGASUM=DASUM -c $< -o $@
$(O)/xasum.o: gasum.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL80) -DGASUM=XASUM -c $< -o $@
$(O)/qasum.o: gasum.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL128) -DGASUM=QASUM -c $< -o $@

$(O)/saxpby.o: gaxpby.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DGAXPBY=SAXPBY -c $< -o $@
$(O)/daxpby.o: gaxpby.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DGAXPBY=DAXPBY -c $< -o $@
$(O)/xaxpby.o: gaxpby.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL80) -DGAXPBY=XAXPBY -c $< -o $@
$(O)/qaxpby.o: gaxpby.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL128) -DGAXPBY=QAXPBY -c $< -o $@

$(O)/saxpy.o: gaxpy.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DGAXPY=SAXPY -c $< -o $@
$(O)/daxpy.o: gaxpy.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DGAXPY=DAXPY -c $< -o $@
$(O)/xaxpy.o: gaxpy.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL80) -DGAXPY=XAXPY -c $< -o $@
$(O)/qaxpy.o: gaxpy.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL128) -DGAXPY=QAXPY -c $< -o $@

$(O)/scopy.o: gcopy.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DGCOPY=SCOPY -c $< -o $@
$(O)/dcopy.o: gcopy.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DGCOPY=DCOPY -c $< -o $@
$(O)/xcopy.o: gcopy.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL80) -DGCOPY=XCOPY -c $< -o $@
$(O)/qcopy.o: gcopy.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL128) -DGCOPY=QCOPY -c $< -o $@

$(O)/sdot.o: gdot.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DGDOT=SDOT -c $< -o $@
$(O)/ddot.o: gdot.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DGDOT=DDOT -c $< -o $@
$(O)/xdot.o: gdot.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL80) -DGDOT=XDOT -c $< -o $@
$(O)/qdot.o: gdot.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL128) -DGDOT=QDOT -c $< -o $@

$(O)/sgbmv.o: ggbmv.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DGGBMV=SGBMV -c $< -o $@
$(O)/dgbmv.o: ggbmv.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DGGBMV=DGBMV -c $< -o $@
$(O)/xgbmv.o: ggbmv.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL80) -DGGBMV=XGBMV -c $< -o $@
$(O)/qgbmv.o: ggbmv.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL128) -DGGBMV=QGBMV -c $< -o $@

$(O)/sgemm.o: ggemm.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DGGEMM=SGEMM -c $< -o $@
$(O)/dgemm.o: ggemm.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DGGEMM=DGEMM -c $< -o $@
$(O)/xgemm.o: ggemm.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL80) -DGGEMM=XGEMM -c $< -o $@
$(O)/qgemm.o: ggemm.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL128) -DGGEMM=QGEMM -c $< -o $@

$(O)/sgemmtr.o: ggemmtr.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DGGEMMTR=SGEMMTR -c $< -o $@
$(O)/dgemmtr.o: ggemmtr.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DGGEMMTR=DGEMMTR -c $< -o $@
$(O)/xgemmtr.o: ggemmtr.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL80) -DGGEMMTR=XGEMMTR -c $< -o $@
$(O)/qgemmtr.o: ggemmtr.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL128) -DGGEMMTR=QGEMMTR -c $< -o $@

$(O)/sgemv.o: ggemv.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DGGEMV=SGEMV -c $< -o $@
$(O)/dgemv.o: ggemv.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DGGEMV=DGEMV -c $< -o $@
$(O)/xgemv.o: ggemv.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL80) -DGGEMV=XGEMV -c $< -o $@
$(O)/qgemv.o: ggemv.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL128) -DGGEMV=QGEMV -c $< -o $@

$(O)/sger.o: gger.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DGGER=SGER -c $< -o $@
$(O)/dger.o: gger.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DGGER=DGER -c $< -o $@
$(O)/xger.o: gger.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL80) -DGGER=XGER -c $< -o $@
$(O)/qger.o: gger.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL128) -DGGER=QGER -c $< -o $@

$(O)/snrm2.o: gnrm2.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DGNRM2=SNRM2 -c $< -o $@
$(O)/dnrm2.o: gnrm2.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DGNRM2=DNRM2 -c $< -o $@
$(O)/xnrm2.o: gnrm2.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL80) -DGNRM2=XNRM2 -c $< -o $@
$(O)/qnrm2.o: gnrm2.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL128) -DGNRM2=QNRM2 -c $< -o $@

$(O)/sscal.o: gscal.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DGSCAL=SSCAL -c $< -o $@
$(O)/dscal.o: gscal.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DGSCAL=DSCAL -c $< -o $@
$(O)/xscal.o: gscal.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL80) -DGSCAL=XSCAL -c $< -o $@
$(O)/qscal.o: gscal.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL128) -DGSCAL=QSCAL -c $< -o $@

$(O)/dsdot.o: gfdot.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DBLAS_REAL_KIND2=$(REAL64) -DGFDOT=DSDOT -c $< -o $@
$(O)/xsdot.o: gfdot.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DBLAS_REAL_KIND2=$(REAL80) -DGFDOT=XSDOT -c $< -o $@
$(O)/xddot.o: gfdot.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DBLAS_REAL_KIND2=$(REAL80) -DGFDOT=XDDOT -c $< -o $@
$(O)/qddot.o: gfdot.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DBLAS_REAL_KIND2=$(REAL128) -DGFDOT=QDDOT -c $< -o $@
$(O)/qxdot.o: gfdot.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL80) -DBLAS_REAL_KIND2=$(REAL128) -DGFDOT=QXDOT -c $< -o $@

$(O)/icamax.o: ihamax.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DIHAMAX=ICAMAX -c $< -o $@
$(O)/izamax.o: ihamax.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DIHAMAX=IZAMAX -c $< -o $@
$(O)/iwamax.o: ihamax.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL80) -DIHAMAX=IWAMAX -c $< -o $@
$(O)/iyamax.o: ihamax.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL128) -DIHAMAX=IYAMAX -c $< -o $@

$(O)/icmax2.o: ihmax2.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DIHMAX2=ICMAX2 -c $< -o $@
$(O)/izmax2.o: ihmax2.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DIHMAX2=IZMAX2 -c $< -o $@
$(O)/iwmax2.o: ihmax2.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL80) -DIHMAX2=IWMAX2 -c $< -o $@
$(O)/iymax2.o: ihmax2.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL128) -DIHMAX2=IYMAX2 -c $< -o $@

$(O)/caxpby.o: haxpby.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DHAXPBY=CAXPBY -c $< -o $@
$(O)/zaxpby.o: haxpby.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DHAXPBY=ZAXPBY -c $< -o $@
$(O)/waxpby.o: haxpby.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL80) -DHAXPBY=WAXPBY -c $< -o $@
$(O)/yaxpby.o: haxpby.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL128) -DHAXPBY=YAXPBY -c $< -o $@

$(O)/caxpy.o: haxpy.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DHAXPY=CAXPY -c $< -o $@
$(O)/zaxpy.o: haxpy.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DHAXPY=ZAXPY -c $< -o $@
$(O)/waxpy.o: haxpy.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL80) -DHAXPY=WAXPY -c $< -o $@
$(O)/yaxpy.o: haxpy.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL128) -DHAXPY=YAXPY -c $< -o $@

$(O)/scabs1.o: gcabs1.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DGCABS1=SCABS1 -c $< -o $@
$(O)/dcabs1.o: gcabs1.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DGCABS1=DCABS1 -c $< -o $@
$(O)/xcabs1.o: gcabs1.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL80) -DGCABS1=XCABS1 -c $< -o $@
$(O)/qcabs1.o: gcabs1.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL128) -DGCABS1=QCABS1 -c $< -o $@

$(O)/scasum.o: ghasum.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DGHASUM=SCASUM -c $< -o $@
$(O)/dzasum.o: ghasum.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DGHASUM=DZASUM -c $< -o $@
$(O)/xwasum.o: ghasum.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL80) -DGHASUM=XWASUM -c $< -o $@
$(O)/qyasum.o: ghasum.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL128) -DGHASUM=QYASUM -c $< -o $@

$(O)/ccopy.o: hcopy.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DHCOPY=CCOPY -c $< -o $@
$(O)/zcopy.o: hcopy.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DHCOPY=ZCOPY -c $< -o $@
$(O)/wcopy.o: hcopy.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL80) -DHCOPY=WCOPY -c $< -o $@
$(O)/ycopy.o: hcopy.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL128) -DHCOPY=YCOPY -c $< -o $@

$(O)/cdotc.o: hdotc.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DHDOTC=CDOTC -c $< -o $@
$(O)/zdotc.o: hdotc.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DHDOTC=ZDOTC -c $< -o $@
$(O)/wdotc.o: hdotc.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL80) -DHDOTC=WDOTC -c $< -o $@
$(O)/ydotc.o: hdotc.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL128) -DHDOTC=YDOTC -c $< -o $@

$(O)/cdotu.o: hdotu.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DHDOTU=CDOTU -c $< -o $@
$(O)/zdotu.o: hdotu.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DHDOTU=ZDOTU -c $< -o $@
$(O)/wdotu.o: hdotu.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL80) -DHDOTU=WDOTU -c $< -o $@
$(O)/ydotu.o: hdotu.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL128) -DHDOTU=YDOTU -c $< -o $@

$(O)/cgbmv.o: hgbmv.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DHGBMV=CGBMV -c $< -o $@
$(O)/zgbmv.o: hgbmv.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DHGBMV=ZGBMV -c $< -o $@
$(O)/wgbmv.o: hgbmv.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL80) -DHGBMV=WGBMV -c $< -o $@
$(O)/ygbmv.o: hgbmv.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL128) -DHGBMV=YGBMV -c $< -o $@

$(O)/cgemm.o: hgemm.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DHGEMM=CGEMM -c $< -o $@
$(O)/zgemm.o: hgemm.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DHGEMM=ZGEMM -c $< -o $@
$(O)/wgemm.o: hgemm.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL80) -DHGEMM=WGEMM -c $< -o $@
$(O)/ygemm.o: hgemm.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL128) -DHGEMM=YGEMM -c $< -o $@

$(O)/cgemmtr.o: hgemmtr.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DHGEMMTR=CGEMMTR -c $< -o $@
$(O)/zgemmtr.o: hgemmtr.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DHGEMMTR=ZGEMMTR -c $< -o $@
$(O)/wgemmtr.o: hgemmtr.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL80) -DHGEMMTR=WGEMMTR -c $< -o $@
$(O)/ygemmtr.o: hgemmtr.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL128) -DHGEMMTR=YGEMMTR -c $< -o $@

$(O)/cgemv.o: hgemv.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DHGEMV=CGEMV -c $< -o $@
$(O)/zgemv.o: hgemv.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DHGEMV=ZGEMV -c $< -o $@
$(O)/wgemv.o: hgemv.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL80) -DHGEMV=WGEMV -c $< -o $@
$(O)/ygemv.o: hgemv.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL128) -DHGEMV=YGEMV -c $< -o $@

$(O)/cgerc.o: hgerc.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DHGERC=CGERC -c $< -o $@
$(O)/zgerc.o: hgerc.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DHGERC=ZGERC -c $< -o $@
$(O)/wgerc.o: hgerc.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL80) -DHGERC=WGERC -c $< -o $@
$(O)/ygerc.o: hgerc.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL128) -DHGERC=YGERC -c $< -o $@

$(O)/cgeru.o: hgeru.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DHGERU=CGERU -c $< -o $@
$(O)/zgeru.o: hgeru.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DHGERU=ZGERU -c $< -o $@
$(O)/wgeru.o: hgeru.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL80) -DHGERU=WGERU -c $< -o $@
$(O)/ygeru.o: hgeru.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL128) -DHGERU=YGERU -c $< -o $@

$(O)/scnrm2.o: ghnrm2.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DGHNRM2=SCNRM2 -c $< -o $@
$(O)/dznrm2.o: ghnrm2.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DGHNRM2=DZNRM2 -c $< -o $@
$(O)/xwnrm2.o: ghnrm2.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL80) -DGHNRM2=XWNRM2 -c $< -o $@
$(O)/qynrm2.o: ghnrm2.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL128) -DGHNRM2=QYNRM2 -c $< -o $@

$(O)/cscal.o: hscal.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DHSCAL=CSCAL -c $< -o $@
$(O)/zscal.o: hscal.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DHSCAL=ZSCAL -c $< -o $@
$(O)/wscal.o: hscal.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL80) -DHSCAL=WSCAL -c $< -o $@
$(O)/yscal.o: hscal.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL128) -DHSCAL=YSCAL -c $< -o $@

$(O)/csscal.o: hgscal.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL32) -DHGSCAL=CSSCAL -c $< -o $@
$(O)/zdscal.o: hgscal.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL64) -DHGSCAL=ZDSCAL -c $< -o $@
$(O)/wxscal.o: hgscal.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL80) -DHGSCAL=WXSCAL -c $< -o $@
$(O)/yqscal.o: hgscal.F90 $(MK)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=$(REAL128) -DHGSCAL=YQSCAL -c $< -o $@

clean:
	@-rm -fv $(L)
	@-rm -rfv $(T)
	@-rm -rfv $(O)
