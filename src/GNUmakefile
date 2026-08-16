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
M=$(LIBPVN)/src/pvn.mk
include $(M)
FC:=$(PVN_FC)
FCFLAGS=$(PVN_FCFLAGS)
ifndef INT
INT:=4
endif # !INT
ifeq ($(findstring gfortran,$(FC)),gfortran)
ifeq ($(INT),8)
FCFLAGS += -fdefault-integer-8
endif # ?INT
ifeq ($(ARCH),x86_64)
REAL_KINDS:=4,8,10,16
else # !x86_64
REAL_KINDS:=4,8,16
endif # ?x86_64
else # !gfortran
ifeq ($(INT),8)
FCFLAGS += -i8
endif # ?INT
ifeq ($(findstring nvfortran,$(FC)),nvfortran)
REAL_KINDS:=4,8
else # !nvfortran
REAL_KINDS:=4,8,16
endif # ?nvfortran
endif # ?gfortran
ifeq ($(ARCH),x86_64)
# HACK: HAVE_FMA set for KIND=10 does NOT indicate that FMA is available,
# but instead that fmal(3) calls are too expensive and should be avoided,
# effectively turning the FMAs off for extended precision!!!  HAVE_FMA:=3
# re-enables the calls at a huge performance penalty compared to MUL&ADD.
HAVE_FMA:=7
else # !x86_64
ifeq ($(findstring ppc64,$(ARCH)),ppc64)
# If using the IBM XL Fortran, REAL128 is NOT the quadruple precision yet,
# so set HAVE_FMA:=15 to indicate that, and do not set the IEEE variable.
HAVE_FMA:=11
else # !ppc64
HAVE_FMA:=3
endif # ?ppc64
endif # ?x86_64
FCFLAGS += -DBLAS_INT_KIND=$(INT) -DHAVE_FMA=$(HAVE_FMA)
ifdef IEEE
FCFLAGS += -DUSE_IEEE_INTRINSIC=$(IEEE)
else # !IEEE
IEEE:=0
endif # ?IEEE
FCFLAGS += $(PVN_CPPFLAGS)
LDFLAGS:=$(PVN_LDFLAGS) -L.. -lepblas$(INT)$(IEEE) $(PVN_LIBS)

M += GNUmakefile

O:=../obj$(INT)$(IEEE)
L:=../libepblas$(INT)$(IEEE).a

E=\
../tsecond$(INT)$(IEEE).exe\
../tdsecnd$(INT)$(IEEE).exe\
../tslamch$(INT)$(IEEE).exe\
../tdlamch$(INT)$(IEEE).exe\
../tsnrm2$(INT)$(IEEE).exe\
../tdnrm2$(INT)$(IEEE).exe\
../ticmax2$(INT)$(IEEE).exe\
../tizmax2$(INT)$(IEEE).exe
ifeq ($(findstring 10,$(REAL_KINDS)),10)
E += \
../txsecnd$(INT)$(IEEE).exe\
../txlamch$(INT)$(IEEE).exe\
../txnrm2$(INT)$(IEEE).exe\
../tiwmax2$(INT)$(IEEE).exe
endif # 10
ifeq ($(findstring 16,$(REAL_KINDS)),16)
E += \
../tqsecnd$(INT)$(IEEE).exe\
../tqlamch$(INT)$(IEEE).exe\
../tqnrm2$(INT)$(IEEE).exe\
../tiymax2$(INT)$(IEEE).exe
endif # 16

F=\
$(O)/lsame.o\
$(O)/slamch.o\
$(O)/dlamch.o\
$(O)/sroundup_lwork.o\
$(O)/droundup_lwork.o\
$(O)/second.o\
$(O)/dsecnd.o\
$(O)/xerbla.o\
$(O)/xerbla_array.o
ifeq ($(findstring 10,$(REAL_KINDS)),10)
F += \
$(O)/xlamch.o\
$(O)/xroundup_lwork.o\
$(O)/xsecnd.o
endif # 10
ifeq ($(findstring 16,$(REAL_KINDS)),16)
F += \
$(O)/qlamch.o\
$(O)/qroundup_lwork.o\
$(O)/qsecnd.o
endif # 16

G=\
$(O)/isamax.o\
$(O)/idamax.o\
$(O)/sasum.o\
$(O)/dasum.o\
$(O)/saxpby.o\
$(O)/daxpby.o\
$(O)/saxpy.o\
$(O)/daxpy.o\
$(O)/scopy.o\
$(O)/dcopy.o\
$(O)/sdot.o\
$(O)/ddot.o\
$(O)/sgbmv.o\
$(O)/dgbmv.o\
$(O)/sgemm.o\
$(O)/dgemm.o\
$(O)/sgemmtr.o\
$(O)/dgemmtr.o\
$(O)/sgemv.o\
$(O)/dgemv.o\
$(O)/sger.o\
$(O)/dger.o\
$(O)/snrm2.o\
$(O)/dnrm2.o\
$(O)/sscal.o\
$(O)/dscal.o\
$(O)/dsdot.o
ifeq ($(findstring 10,$(REAL_KINDS)),10)
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
endif # 10
ifeq ($(findstring 16,$(REAL_KINDS)),16)
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
$(O)/qscal.o
endif # 16

H=\
$(O)/icamax.o\
$(O)/izamax.o\
$(O)/icmax2.o\
$(O)/izmax2.o\
$(O)/caxpby.o\
$(O)/zaxpby.o\
$(O)/caxpy.o\
$(O)/zaxpy.o\
$(O)/scabs1.o\
$(O)/dcabs1.o\
$(O)/scasum.o\
$(O)/dzasum.o\
$(O)/ccopy.o\
$(O)/zcopy.o\
$(O)/cdotc.o\
$(O)/zdotc.o\
$(O)/cdotu.o\
$(O)/zdotu.o\
$(O)/cgbmv.o\
$(O)/zgbmv.o\
$(O)/cgemm.o\
$(O)/zgemm.o\
$(O)/cgemmtr.o\
$(O)/zgemmtr.o\
$(O)/cgemv.o\
$(O)/zgemv.o\
$(O)/cgerc.o\
$(O)/zgerc.o\
$(O)/cgeru.o\
$(O)/zgeru.o\
$(O)/scnrm2.o\
$(O)/dznrm2.o\
$(O)/cscal.o\
$(O)/zscal.o\
$(O)/csscal.o\
$(O)/zdscal.o
ifeq ($(findstring 10,$(REAL_KINDS)),10)
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
endif # 10
ifeq ($(findstring 16,$(REAL_KINDS)),16)
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
endif # 16

.PHONY: all help dirs clean

all: dirs $(L) $(E)

help:
	@echo "$(MAKE) [LIBPVN=../../libpvn] [INT=4|8] [IEEE=0] [all|help|clean]"

dirs:
	@echo "ARCH=$(ARCH)"
	@echo "LIBPVN=$(LIBPVN)"
	@echo "INT=$(INT)"
	@echo "IEEE=$(IEEE)"
	@echo "REAL_KINDS=$(REAL_KINDS)"
	@echo "HAVE_FMA=$(HAVE_FMA)"
	@mkdir -pv $(O)

$(L): $(F) $(G) $(H)
	$(AR) $(ARFLAGS) $@ $^

../tsecond$(INT)$(IEEE).exe: tgsecnd.F90 $(L) $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=4 -DGSECND=SECOND $< -o $@ $(LDFLAGS)
../tdsecnd$(INT)$(IEEE).exe: tgsecnd.F90 $(L) $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=8 -DGSECND=DSECND $< -o $@ $(LDFLAGS)
../txsecnd$(INT)$(IEEE).exe: tgsecnd.F90 $(L) $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=10 -DGSECND=XSECND $< -o $@ $(LDFLAGS)
../tqsecnd$(INT)$(IEEE).exe: tgsecnd.F90 $(L) $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=16 -DGSECND=QSECND $< -o $@ $(LDFLAGS)

../tslamch$(INT)$(IEEE).exe: tglamch.F90 $(L) $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=4 -DGLAMCH=SLAMCH $< -o $@ $(LDFLAGS)
../tdlamch$(INT)$(IEEE).exe: tglamch.F90 $(L) $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=8 -DGLAMCH=DLAMCH $< -o $@ $(LDFLAGS)
../txlamch$(INT)$(IEEE).exe: tglamch.F90 $(L) $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=10 -DGLAMCH=XLAMCH $< -o $@ $(LDFLAGS)
../tqlamch$(INT)$(IEEE).exe: tglamch.F90 $(L) $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=16 -DGLAMCH=QLAMCH $< -o $@ $(LDFLAGS)

../tsnrm2$(INT)$(IEEE).exe: tgnrm2.F90 $(L) $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=4 -DGNRM2=SNRM2 $< -o $@ $(LDFLAGS)
../tdnrm2$(INT)$(IEEE).exe: tgnrm2.F90 $(L) $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=8 -DGNRM2=DNRM2 $< -o $@ $(LDFLAGS)
../txnrm2$(INT)$(IEEE).exe: tgnrm2.F90 $(L) $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=10 -DGNRM2=XNRM2 $< -o $@ $(LDFLAGS)
../tqnrm2$(INT)$(IEEE).exe: tgnrm2.F90 $(L) $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=16 -DGNRM2=QNRM2 $< -o $@ $(LDFLAGS)

../ticmax2$(INT)$(IEEE).exe: tihmax2.F90 $(L) $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=4 -DIHAMAX=ICAMAX -DIHMAX2=ICMAX2 $< -o $@ $(LDFLAGS)
../tizmax2$(INT)$(IEEE).exe: tihmax2.F90 $(L) $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=8 -DIHAMAX=IZAMAX -DIHMAX2=IZMAX2 $< -o $@ $(LDFLAGS)
../tiwmax2$(INT)$(IEEE).exe: tihmax2.F90 $(L) $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=10 -DIHAMAX=IWAMAX -DIHMAX2=IWMAX2 $< -o $@ $(LDFLAGS)
../tiymax2$(INT)$(IEEE).exe: tihmax2.F90 $(L) $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=16 -DIHAMAX=IYAMAX -DIHMAX2=IYMAX2 $< -o $@ $(LDFLAGS)

$(O)/lsame.o: lsame.F90 $(M)
	$(FC) $(FCFLAGS) -c $< -o $@
$(O)/xerbla.o: xerbla.F90 $(M)
	$(FC) $(FCFLAGS) -c $< -o $@
$(O)/xerbla_array.o: xerbla_array.F90 $(M)
	$(FC) $(FCFLAGS) -c $< -o $@

$(O)/slamch.o: glamch.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=4 -DGLAMCH=SLAMCH -c $< -o $@
$(O)/dlamch.o: glamch.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=8 -DGLAMCH=DLAMCH -c $< -o $@
$(O)/xlamch.o: glamch.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=10 -DGLAMCH=XLAMCH -c $< -o $@
$(O)/qlamch.o: glamch.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=16 -DGLAMCH=QLAMCH -c $< -o $@

$(O)/sroundup_lwork.o: groundup_lwork.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=4 -DGROUNDUP_LWORK=SROUNDUP_LWORK -c $< -o $@
$(O)/droundup_lwork.o: groundup_lwork.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=8 -DGROUNDUP_LWORK=DROUNDUP_LWORK -c $< -o $@
$(O)/xroundup_lwork.o: groundup_lwork.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=10 -DGROUNDUP_LWORK=XROUNDUP_LWORK -c $< -o $@
$(O)/qroundup_lwork.o: groundup_lwork.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=16 -DGROUNDUP_LWORK=QROUNDUP_LWORK -c $< -o $@

$(O)/second.o: gsecnd.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=4 -DGSECND=SECOND -c $< -o $@
$(O)/dsecnd.o: gsecnd.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=8 -DGSECND=DSECND -c $< -o $@
$(O)/xsecnd.o: gsecnd.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=10 -DGSECND=XSECND -c $< -o $@
$(O)/qsecnd.o: gsecnd.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=16 -DGSECND=QSECND -c $< -o $@

$(O)/isamax.o: igamax.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=4 -DIGAMAX=ISAMAX -c $< -o $@
$(O)/idamax.o: igamax.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=8 -DIGAMAX=IDAMAX -c $< -o $@
$(O)/ixamax.o: igamax.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=10 -DIGAMAX=IXAMAX -c $< -o $@
$(O)/iqamax.o: igamax.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=16 -DIGAMAX=IQAMAX -c $< -o $@

$(O)/sasum.o: gasum.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=4 -DGASUM=SASUM -c $< -o $@
$(O)/dasum.o: gasum.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=8 -DGASUM=DASUM -c $< -o $@
$(O)/xasum.o: gasum.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=10 -DGASUM=XASUM -c $< -o $@
$(O)/qasum.o: gasum.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=16 -DGASUM=QASUM -c $< -o $@

$(O)/saxpby.o: gaxpby.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=4 -DGAXPBY=SAXPBY -c $< -o $@
$(O)/daxpby.o: gaxpby.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=8 -DGAXPBY=DAXPBY -c $< -o $@
$(O)/xaxpby.o: gaxpby.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=10 -DGAXPBY=XAXPBY -c $< -o $@
$(O)/qaxpby.o: gaxpby.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=16 -DGAXPBY=QAXPBY -c $< -o $@

$(O)/saxpy.o: gaxpy.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=4 -DGAXPY=SAXPY -c $< -o $@
$(O)/daxpy.o: gaxpy.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=8 -DGAXPY=DAXPY -c $< -o $@
$(O)/xaxpy.o: gaxpy.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=10 -DGAXPY=XAXPY -c $< -o $@
$(O)/qaxpy.o: gaxpy.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=16 -DGAXPY=QAXPY -c $< -o $@

$(O)/scopy.o: gcopy.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=4 -DGCOPY=SCOPY -c $< -o $@
$(O)/dcopy.o: gcopy.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=8 -DGCOPY=DCOPY -c $< -o $@
$(O)/xcopy.o: gcopy.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=10 -DGCOPY=XCOPY -c $< -o $@
$(O)/qcopy.o: gcopy.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=16 -DGCOPY=QCOPY -c $< -o $@

$(O)/sdot.o: gdot.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=4 -DGDOT=SDOT -c $< -o $@
$(O)/ddot.o: gdot.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=8 -DGDOT=DDOT -c $< -o $@
$(O)/xdot.o: gdot.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=10 -DGDOT=XDOT -c $< -o $@
$(O)/qdot.o: gdot.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=16 -DGDOT=QDOT -c $< -o $@

$(O)/sgbmv.o: ggbmv.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=4 -DGGBMV=SGBMV -c $< -o $@
$(O)/dgbmv.o: ggbmv.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=8 -DGGBMV=DGBMV -c $< -o $@
$(O)/xgbmv.o: ggbmv.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=10 -DGGBMV=XGBMV -c $< -o $@
$(O)/qgbmv.o: ggbmv.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=16 -DGGBMV=QGBMV -c $< -o $@

$(O)/sgemm.o: ggemm.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=4 -DGGEMM=SGEMM -c $< -o $@
$(O)/dgemm.o: ggemm.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=8 -DGGEMM=DGEMM -c $< -o $@
$(O)/xgemm.o: ggemm.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=10 -DGGEMM=XGEMM -c $< -o $@
$(O)/qgemm.o: ggemm.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=16 -DGGEMM=QGEMM -c $< -o $@

$(O)/sgemmtr.o: ggemmtr.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=4 -DGGEMMTR=SGEMMTR -c $< -o $@
$(O)/dgemmtr.o: ggemmtr.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=8 -DGGEMMTR=DGEMMTR -c $< -o $@
$(O)/xgemmtr.o: ggemmtr.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=10 -DGGEMMTR=XGEMMTR -c $< -o $@
$(O)/qgemmtr.o: ggemmtr.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=16 -DGGEMMTR=QGEMMTR -c $< -o $@

$(O)/sgemv.o: ggemv.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=4 -DGGEMV=SGEMV -c $< -o $@
$(O)/dgemv.o: ggemv.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=8 -DGGEMV=DGEMV -c $< -o $@
$(O)/xgemv.o: ggemv.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=10 -DGGEMV=XGEMV -c $< -o $@
$(O)/qgemv.o: ggemv.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=16 -DGGEMV=QGEMV -c $< -o $@

$(O)/sger.o: gger.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=4 -DGGER=SGER -c $< -o $@
$(O)/dger.o: gger.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=8 -DGGER=DGER -c $< -o $@
$(O)/xger.o: gger.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=10 -DGGER=XGER -c $< -o $@
$(O)/qger.o: gger.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=16 -DGGER=QGER -c $< -o $@

$(O)/snrm2.o: gnrm2.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=4 -DGNRM2=SNRM2 -c $< -o $@
$(O)/dnrm2.o: gnrm2.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=8 -DGNRM2=DNRM2 -c $< -o $@
$(O)/xnrm2.o: gnrm2.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=10 -DGNRM2=XNRM2 -c $< -o $@
$(O)/qnrm2.o: gnrm2.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=16 -DGNRM2=QNRM2 -c $< -o $@

$(O)/sscal.o: gscal.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=4 -DGSCAL=SSCAL -c $< -o $@
$(O)/dscal.o: gscal.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=8 -DGSCAL=DSCAL -c $< -o $@
$(O)/xscal.o: gscal.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=10 -DGSCAL=XSCAL -c $< -o $@
$(O)/qscal.o: gscal.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=16 -DGSCAL=QSCAL -c $< -o $@

$(O)/dsdot.o: gfdot.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=4 -DBLAS_REAL_KIND2=8 -DGFDOT=DSDOT -c $< -o $@
$(O)/xsdot.o: gfdot.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=4 -DBLAS_REAL_KIND2=10 -DGFDOT=XSDOT -c $< -o $@
$(O)/xddot.o: gfdot.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=8 -DBLAS_REAL_KIND2=10 -DGFDOT=XDDOT -c $< -o $@
$(O)/qxdot.o: gfdot.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=10 -DBLAS_REAL_KIND2=16 -DGFDOT=QXDOT -c $< -o $@

$(O)/icamax.o: ihamax.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=4 -DIHAMAX=ICAMAX -c $< -o $@
$(O)/izamax.o: ihamax.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=8 -DIHAMAX=IZAMAX -c $< -o $@
$(O)/iwamax.o: ihamax.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=10 -DIHAMAX=IWAMAX -c $< -o $@
$(O)/iyamax.o: ihamax.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=16 -DIHAMAX=IYAMAX -c $< -o $@

$(O)/icmax2.o: ihmax2.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=4 -DIHMAX2=ICMAX2 -c $< -o $@
$(O)/izmax2.o: ihmax2.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=8 -DIHMAX2=IZMAX2 -c $< -o $@
$(O)/iwmax2.o: ihmax2.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=10 -DIHMAX2=IWMAX2 -c $< -o $@
$(O)/iymax2.o: ihmax2.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=16 -DIHMAX2=IYMAX2 -c $< -o $@

$(O)/caxpby.o: haxpby.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=4 -DHAXPBY=CAXPBY -c $< -o $@
$(O)/zaxpby.o: haxpby.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=8 -DHAXPBY=ZAXPBY -c $< -o $@
$(O)/waxpby.o: haxpby.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=10 -DHAXPBY=WAXPBY -c $< -o $@
$(O)/yaxpby.o: haxpby.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=16 -DHAXPBY=YAXPBY -c $< -o $@

$(O)/caxpy.o: haxpy.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=4 -DHAXPY=CAXPY -c $< -o $@
$(O)/zaxpy.o: haxpy.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=8 -DHAXPY=ZAXPY -c $< -o $@
$(O)/waxpy.o: haxpy.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=10 -DHAXPY=WAXPY -c $< -o $@
$(O)/yaxpy.o: haxpy.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=16 -DHAXPY=YAXPY -c $< -o $@

$(O)/scabs1.o: gcabs1.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=4 -DGCABS1=SCABS1 -c $< -o $@
$(O)/dcabs1.o: gcabs1.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=8 -DGCABS1=DCABS1 -c $< -o $@
$(O)/xcabs1.o: gcabs1.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=10 -DGCABS1=XCABS1 -c $< -o $@
$(O)/qcabs1.o: gcabs1.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=16 -DGCABS1=QCABS1 -c $< -o $@

$(O)/scasum.o: ghasum.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=4 -DGHASUM=SCASUM -c $< -o $@
$(O)/dzasum.o: ghasum.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=8 -DGHASUM=DZASUM -c $< -o $@
$(O)/xwasum.o: ghasum.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=10 -DGHASUM=XWASUM -c $< -o $@
$(O)/qyasum.o: ghasum.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=16 -DGHASUM=QYASUM -c $< -o $@

$(O)/ccopy.o: hcopy.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=4 -DHCOPY=CCOPY -c $< -o $@
$(O)/zcopy.o: hcopy.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=8 -DHCOPY=ZCOPY -c $< -o $@
$(O)/wcopy.o: hcopy.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=10 -DHCOPY=WCOPY -c $< -o $@
$(O)/ycopy.o: hcopy.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=16 -DHCOPY=YCOPY -c $< -o $@

$(O)/cdotc.o: hdotc.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=4 -DHDOTC=CDOTC -c $< -o $@
$(O)/zdotc.o: hdotc.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=8 -DHDOTC=ZDOTC -c $< -o $@
$(O)/wdotc.o: hdotc.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=10 -DHDOTC=WDOTC -c $< -o $@
$(O)/ydotc.o: hdotc.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=16 -DHDOTC=YDOTC -c $< -o $@

$(O)/cdotu.o: hdotu.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=4 -DHDOTU=CDOTU -c $< -o $@
$(O)/zdotu.o: hdotu.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=8 -DHDOTU=ZDOTU -c $< -o $@
$(O)/wdotu.o: hdotu.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=10 -DHDOTU=WDOTU -c $< -o $@
$(O)/ydotu.o: hdotu.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=16 -DHDOTU=YDOTU -c $< -o $@

$(O)/cgbmv.o: hgbmv.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=4 -DHGBMV=CGBMV -c $< -o $@
$(O)/zgbmv.o: hgbmv.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=8 -DHGBMV=ZGBMV -c $< -o $@
$(O)/wgbmv.o: hgbmv.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=10 -DHGBMV=WGBMV -c $< -o $@
$(O)/ygbmv.o: hgbmv.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=16 -DHGBMV=YGBMV -c $< -o $@

$(O)/cgemm.o: hgemm.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=4 -DHGEMM=CGEMM -c $< -o $@
$(O)/zgemm.o: hgemm.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=8 -DHGEMM=ZGEMM -c $< -o $@
$(O)/wgemm.o: hgemm.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=10 -DHGEMM=WGEMM -c $< -o $@
$(O)/ygemm.o: hgemm.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=16 -DHGEMM=YGEMM -c $< -o $@

$(O)/cgemmtr.o: hgemmtr.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=4 -DHGEMMTR=CGEMMTR -c $< -o $@
$(O)/zgemmtr.o: hgemmtr.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=8 -DHGEMMTR=ZGEMMTR -c $< -o $@
$(O)/wgemmtr.o: hgemmtr.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=10 -DHGEMMTR=WGEMMTR -c $< -o $@
$(O)/ygemmtr.o: hgemmtr.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=16 -DHGEMMTR=YGEMMTR -c $< -o $@

$(O)/cgemv.o: hgemv.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=4 -DHGEMV=CGEMV -c $< -o $@
$(O)/zgemv.o: hgemv.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=8 -DHGEMV=ZGEMV -c $< -o $@
$(O)/wgemv.o: hgemv.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=10 -DHGEMV=WGEMV -c $< -o $@
$(O)/ygemv.o: hgemv.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=16 -DHGEMV=YGEMV -c $< -o $@

$(O)/cgerc.o: hgerc.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=4 -DHGERC=CGERC -c $< -o $@
$(O)/zgerc.o: hgerc.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=8 -DHGERC=ZGERC -c $< -o $@
$(O)/wgerc.o: hgerc.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=10 -DHGERC=WGERC -c $< -o $@
$(O)/ygerc.o: hgerc.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=16 -DHGERC=YGERC -c $< -o $@

$(O)/cgeru.o: hgeru.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=4 -DHGERU=CGERU -c $< -o $@
$(O)/zgeru.o: hgeru.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=8 -DHGERU=ZGERU -c $< -o $@
$(O)/wgeru.o: hgeru.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=10 -DHGERU=WGERU -c $< -o $@
$(O)/ygeru.o: hgeru.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=16 -DHGERU=YGERU -c $< -o $@

$(O)/scnrm2.o: ghnrm2.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=4 -DGHNRM2=SCNRM2 -c $< -o $@
$(O)/dznrm2.o: ghnrm2.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=8 -DGHNRM2=DZNRM2 -c $< -o $@
$(O)/xwnrm2.o: ghnrm2.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=10 -DGHNRM2=XWNRM2 -c $< -o $@
$(O)/qynrm2.o: ghnrm2.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=16 -DGHNRM2=QYNRM2 -c $< -o $@

$(O)/cscal.o: hscal.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=4 -DHSCAL=CSCAL -c $< -o $@
$(O)/zscal.o: hscal.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=8 -DHSCAL=ZSCAL -c $< -o $@
$(O)/wscal.o: hscal.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=10 -DHSCAL=WSCAL -c $< -o $@
$(O)/yscal.o: hscal.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=16 -DHSCAL=YSCAL -c $< -o $@

$(O)/csscal.o: hgscal.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=4 -DHGSCAL=CSSCAL -c $< -o $@
$(O)/zdscal.o: hgscal.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=8 -DHGSCAL=ZDSCAL -c $< -o $@
$(O)/wxscal.o: hgscal.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=10 -DHGSCAL=WXSCAL -c $< -o $@
$(O)/yqscal.o: hgscal.F90 $(M)
	$(FC) $(FCFLAGS) -DBLAS_REAL_KIND=16 -DHGSCAL=YQSCAL -c $< -o $@

clean:
	@-rm -fv $(E)
	@-rm -fv $(L)
	@-rm -rfv $(O)
