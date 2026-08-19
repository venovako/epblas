# epblas
Extra Precisions BLAS etc.

This is an extension of [LAPACK](https://github.com/Reference-LAPACK/lapack) to extra precisions, i.e., beyond the single and double ones.

Currently, the following parts are in progress of being converted, alongside some additions:
* INSTALL (partially),
* BLAS (TBD, started),
* MATGEN (TBD).

The original source code has been modified and adapted, but the existing interfaces will remain unchanged.

Sometimes a new algorithm has been implemented for an existing interface, e.g., `NRM2` has been provided following [VecNrmP](https://github.com/venovako/VecNrmP).

In several other cases, the basic algorithm has been heavily reworked, but remained in the same spirit, e.g., `AXPBY`, the complex `IAMAX`, and `XERBLA`.

The aim is to have (most of) the routines in single, double, and extended precisions not dependent on the Fortran library when `IEEE<=0` (see below), but many routines instead depend on `libpvn`.

In extended (80-bit Intel) precision, available only with `gfortran` on Intel-compatible platforms, the real and complex routines have the prefixes `x` and `w`, respectively.
In quadruple (128-bit IEEE) precision, the prefixes are `q` and `y`.
The type-generic prefixes are `g` and `h`.

Note that `XERBLA` no longer stops the program.
Please see in `src/xerbla.F90` how the error handling is meant to work.

## Building

First, clone and build [libpvn](https://github.com/venovako/libpvn).

Please adjust `src/GNUmakefile` according to the comments within.
Only `gfortran`, `ifx`, and `nvfortran` compilers will be supported.

Then, from within the `src` subdirectory, call
```bash
make [LIBPVN=../../libpvn] [INT=4|8] [IEEE=0|-1|...] [all|help|clean]
```
where `LIBPVN` is the libpvn's directory, `INT` specifies the default integer width (4 or 8 bytes), and `IEEE=1` allows the intrinsic module `IEEE_ARITHMETIC` to be used.
If a non-default rounding mode is desired, please make sure that `libpvn` has been built with the `STRICT` option and set `IEEE=2`.
For the meaning of `IEEE=-1` please consult the makefile.

On Windows, please use `nmake.exe` instead of `make` (or `gmake`), which in turn processes `src\Makefile` and expects the Intel's oneAPI toolchain.

The outputs are `epblas_$(INT)$(IEEE).lib` and `eplapack_$(INT)$(IEEE).lib` on Windows, or `libepblas_$(INT)$(IEEE).a` and `libeplapack_$(INT)$(IEEE).a` otherwise, and several `t*_$(INT)$(IEEE).exe` testing executables.

It is intended for the static libraries to be a drop-in replacement for the LAPACK's `librefblas.a` and parts of `liblapack.a`, respectively, as well as for the `MATGEN` objects, in single and double precisions, while extending those interfaces to other compiler-supported precisions.

(... work in progress ...)
