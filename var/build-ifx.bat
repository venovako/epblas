@ECHO OFF
REM has to be run from this directory
CD ..\..\libpvn\src
nmake.exe /nologo NDEBUG=3 clean all
CD ..\..\epblas\src
nmake.exe /nologo IEEE=%1 clean test
CD ..\var
