#!/bin/bash
# !!! has to be run from this directory !!!
cd ../../libpvn/src
make COMPILER=icx NDEBUG=3 SAFE=SV2,NRM OPENMP=0 clean
make COMPILER=icx NDEBUG=3 SAFE=SV2,NRM OPENMP=0 -j
cd ../../epblas/src
make $1 clean
make $1 -j test
cd ../var
