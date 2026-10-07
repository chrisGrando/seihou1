@echo off

:: If you use a non-default installation path for Git For Windows, please insert it in the variable below (within the quotation marks)!
set "GIT_PATH="

:: Checking if MSVC is avaliable
if not defined VCINSTALLDIR goto MSVC_NOT_FOUND

:: Searching for default installation of Git For Windows if not specified already
if "%GIT_PATH%" == "" (
	:: 32 Bits
	if exist "%SYSTEMDRIVE%\Program Files (x86)\Git\bin\sh.exe" set "GIT_PATH=%SYSTEMDRIVE%\Program Files (x86)\Git\bin\sh.exe"
	:: 64 Bits
	if exist "%SYSTEMDRIVE%\Program Files\Git\bin\sh.exe" set "GIT_PATH=%SYSTEMDRIVE%\Program Files\Git\bin\sh.exe"
)

:: Abort if Git For Windows is absent
if "%GIT_PATH%" == "" goto GIT_NOT_FOUND

:: Abort if Git For Windows path is incorrect
if not exist "%GIT_PATH%" goto GIT_NOT_FOUND

:: If no error occurred => Build project
goto BUILD

:GIT_NOT_FOUND
echo Error: Git for Windows not found...
goto ABORT_BUILD

:MSVC_NOT_FOUND
echo Error: The build must be run from within Visual Studio's `x64_x86 Cross Tools Command Prompt`.

:ABORT_BUILD
pause
exit /b 1

:BUILD
:: Setup dependencies and building project
call "%~dp0hatoyama\configure_windows.bat"
if %errorlevel% neq 0 exit /b %errorlevel%

call "%GIT_PATH%" --login "%~dp0hatoyama\version_from_git.sh"
tup %*
exit /b
