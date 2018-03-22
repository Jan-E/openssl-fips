echo off
cd \OpenSSL-dev\openssl-fips-%2

if "%3"=="x64" goto x64

:x86

if "%vstudio%"=="VS2008" call "C:\Program Files (x86)\Microsoft Visual Studio 9.0\VC\vcvarsall.bat" x86
if "%vstudio%"=="VS2012" call "C:\Program Files (x86)\Microsoft Visual Studio 11.0\VC\vcvarsall.bat" x86
if "%vstudio%"=="VS2013" call "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat" x86
if "%vstudio%"=="VS2015" call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" x86 8.1
where cl
set path=%PATH%;"C:\Program Files\NASM"
set PROCESSOR_ARCHITECTURE=x86
if exist \usr\local\ssl rd \usr\local\ssl /s /q
if exist out32dll rd out32dll /s /q
if exist tmp32dll rd tmp32dll /s /q
perl -pi.bak -e "s/pause//gi" ms\do_fips.bat
if exist ms\do_fips.bat.bak del ms\do_fips.bat.bak
call ms\do_fips.bat

goto done

:x64

if "%vstudio%"=="VS2008" call "C:\Program Files (x86)\Microsoft Visual Studio 9.0\VC\vcvarsall.bat" x86_amd64
if "%vstudio%"=="VS2012" call "C:\Program Files (x86)\Microsoft Visual Studio 11.0\VC\vcvarsall.bat" x86_amd64
if "%vstudio%"=="VS2013" call "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat" x86_amd64
if "%vstudio%"=="VS2015" call "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat" x86_amd64 8.1
where cl
set PROCESSOR_ARCHITECTURE=AMD64
if exist \usr\local\ssl rd \usr\local\ssl /s /q
if exist out32dll rd out32dll /s /q
if exist tmp32dll rd tmp32dll /s /q
perl -pi.bak -e "s/pause//gi" ms\do_fips.bat
if exist ms\do_fips.bat.bak del ms\do_fips.bat.bak
call ms\do_fips.bat no-asm

:done