#!/bin/bash
# !!! has to be run from this directory !!!
if [ -z "${GNU}" ]
then
	cd ../../libpvn/src
	make COMPILER=gcc NDEBUG=3 SAFE=SV2,NRM OPENMP=0 clean #GMP=$HOME/gnu MPFR=$HOME/gnu
	make COMPILER=gcc NDEBUG=3 SAFE=SV2,NRM OPENMP=0 -j #GMP=$HOME/gnu MPFR=$HOME/gnu
	cd ../../epblas/src
	make $1 clean
	make $1 -j test
	cd ../var
else
	cd ../../libpvn/src
	make COMPILER=gcc COMPILER_SUFFIX=${GNU} NDEBUG=3 SAFE=SV2,NRM OPENMP=0 clean #GMP=$HOME/gnu MPFR=$HOME/gnu
	make COMPILER=gcc COMPILER_SUFFIX=${GNU} NDEBUG=3 SAFE=SV2,NRM OPENMP=0 -j #GMP=$HOME/gnu MPFR=$HOME/gnu
	cd ../../epblas/src
	make $1 clean
	make $1 -j test
	cd ../var
fi
