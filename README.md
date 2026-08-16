# epblas
Extra Precisions BLAS etc.

This is an extension of [LAPACK](https://github.com/Reference-LAPACK/lapack) to extra precisions, i.e., beyond the single and double ones.

Currently, the following parts are in progress of being converted, alongside some additions:
* INSTALL (partially),
* BLAS (TBD, started),
* MATGEN (TBD).

The original source code has been modified and adapted, but the existing interfaces will stay unchanged.

Sometimes a new algorithm has been implemented for an existing interface, e.g., `NRM2` has been provided following [VecNrmP](https://github.com/venovako/VecNrmP).

In several other cases, the basic algorithm has been heavily reworked, but remained in the same spirit, e.g., `AXPBY`, the complex `IAMAX`, and `XERBLA`.

## Building

First, clone and build [libpvn](https://github.com/venovako/libpvn).

Then, from within the `src` subdirectory, call
```bash
make [LIBPVN=../../libpvn] [INT=4|8] [IEEE=0] [all|help|clean]
```
where `LIBPVN` is the libpvn's directory, `INT` specifies the default integer width (4 or 8 bytes), and `IEEE` set to a non-zero value allows the intrinsic module `IEEE_ARITHMETIC` to be used.

On Windows, use `nmake` instead of `make`.

(... work in progress ...)
