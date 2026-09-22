# epblas
Extra Precisions BLAS etc.

(... work in progress ...)

This is an extension of parts of [LAPACK](https://github.com/Reference-LAPACK/lapack) to extra precisions, i.e., beyond the single and double ones.

Currently, the following parts are in progress of being converted, alongside some additions:
* INSTALL (partially),
* BLAS (TBD, started),
* MATGEN (TBD, started).

The original source code has been modified and adapted, but the existing interfaces will remain unchanged.

Sometimes a new algorithm has been implemented for an existing interface, e.g., `NRM2` has been provided following [VecNrmP](https://github.com/venovako/VecNrmP).

In several other cases, the basic algorithm has been heavily reworked, but remained in the same spirit, e.g., `AXPBY` and the complex `IAMAX`.

The aim is to have (most of) the routines in single, double, and extended precisions not dependent on the Fortran library when `IEEE<=0` (see below), but many routines instead depend on `libpvn`.

In extended (80-bit Intel) precision, available only with `gfortran` on Intel-compatible platforms, the real and complex routines have the prefixes `x` and `w`, respectively.
In quadruple (128-bit IEEE) precision, the prefixes are `q` and `y`.
The type-generic prefixes are `g` and `h`.

Note that `XERBLA` no longer stops the program.
Please see in `src/txerbla.F90` how the error handling is meant to work.

**HACK**: `XERBLA` is declared as `PURE`, what is not exactly correct, since it changes the C runtime environment (the `errno` variable), but this choice was made to make all other BLAS routines `PURE`.

## Building

First, clone and build [libpvn](https://github.com/venovako/libpvn).

Please adjust `src/GNUmakefile` according to the comments within.
Only `gfortran`, `ifx`, and `nvfortran` compilers will be supported.

Then, from within the `src` subdirectory, call
```bash
make [LIBPVN=../../libpvn] [INT=4|8] [IEEE=0|1] [all|help|test|clean]
```
where `LIBPVN` is the libpvn's directory, `INT` specifies the default integer width (4 or 8 bytes), and `IEEE=1` allows the intrinsic module `IEEE_ARITHMETIC` to be used.

On Windows, please use `nmake.exe` instead of `make` (or `gmake`), which in turn processes `src\Makefile` and expects the Intel's oneAPI toolchain.

The outputs on Windows are:
* `epblas_$(INT)$(IEEE).lib`,
* `eplapack_$(INT)$(IEEE).lib`, and
* `eptmglib_$(INT)$(IEEE).lib`.

Otherwise, the outputs are:
* `libepblas_$(INT)$(IEEE).a`,
* `libeplapack_$(INT)$(IEEE).a`, and
* `libeptmglib_$(INT)$(IEEE).a`.

Several testing executables are also generated in the `exe_$(INT)$(IEEE)` subdirectory.
