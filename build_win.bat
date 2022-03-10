@echo off

set TOP_DIR=%~dp0\
echo %TOP_DIR%
set Bit=%1%

::if not set 'Bit' Env, Use 64
if "%Bit%" == "64" (
	set Bit=32
	set ARCH=x86
	set AARCH="Win32"
) else (
	set Bit=64
	set ARCH=x64
	set AARCH="x64"
)

set BUILD_DIR="%TOP_DIR%\build"
set INSTALL_DIR="%TOP_DIR%\bin"
rmdir /q /s %BUILD_DIR%
rmdir /q /s %INSTALL_DIR%
if not exist %BUILD_DIR% md %BUILD_DIR%
if not exist %INSTALL_DIR% md %INSTALL_DIR%

set BUILD_TYPE=Release
call :cmake_build
@REM set BUILD_TYPE=Debug
@REM call :cmake_build

goto :eof

:cmake_build
if defined VS2019_HOME (
	if "%Bit%" == "64" (
		call "%VS2019_HOME%\VC\Auxiliary\Build\vcvarsall.bat" %ARCH%
		IF %ERRORLEVEL% NEQ 0 EXIT /B %ERRORLEVEL%
	) else (
		call "%VS2019_HOME%\VC\Auxiliary\Build\vcvarsall.bat" %ARCH%
		IF %ERRORLEVEL% NEQ 0 EXIT /B %ERRORLEVEL%
	)
    cmake -G "Visual Studio 16 2019" -A %AARCH% -B%BUILD_DIR% -DCMAKE_INSTALL_PREFIX=%INSTALL_DIR% -DBUILD_SHARED_LIBS=OFF -H%TOP_DIR%
    cmake --build %BUILD_DIR% --config %BUILD_TYPE% --target install
)
goto :eof