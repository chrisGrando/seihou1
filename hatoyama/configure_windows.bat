@echo off

:: Checking if MSVC is avaliable
if not defined VCINSTALLDIR (
	echo Error: The build must be run from within Visual Studio's `x64_x86 Cross Tools Command Prompt`.
	exit /b 1
)

:: Searching for default installation of Git For Windows if not set already
if not defined GIT_PATH (
	:: 32 Bits
	if exist "%SYSTEMDRIVE%\Program Files (x86)\Git\bin\sh.exe" set GIT_PATH="%SYSTEMDRIVE%\Program Files (x86)\Git\bin\sh.exe"
	:: 64 Bits
	if exist "%SYSTEMDRIVE%\Program Files\Git\bin\sh.exe" set GIT_PATH="%SYSTEMDRIVE%\Program Files\Git\bin\sh.exe"

	:: Abort if Git For Windows is absent
	if not defined GIT_PATH (
		echo Error: Git for Windows not found...
		exit /b 1
	)
)

:: Set up dependencies sub-modules
call "%PROGRAMFILES%\Git\bin\sh.exe" --login "%~dp0submodules_check.sh" ^
	"%~dp0libs\9xcompat" ^
	"%~dp0libs\BLAKE3" ^
	"%~dp0libs\dr_libs" ^
	"%~dp0libs\libogg" ^
	"%~dp0libs\libvorbis" ^
	"%~dp0libs\libwebp_lossless" ^
	"%~dp0libs\miniaudio" ^
	"%~dp0libs\printf" ^
	"%~dp0libs\SDL3" ^
	"%~dp0libs\tupblocks"

exit /b
