@echo off
setlocal

rem
rem NSSM Lightstreamer NT service install script
rem

REM the service display name
set SERVICE_DISPLAY_NAME="Lightstreamer Server"

REM the service description
set SERVICE_DESCRIPTION="Delivers real-time data over the Web"

REM the service start type. Allowed values: Automatic, Manual, Disabled
set SERVICE_START_TYPE=Automatic

if "%OS%"=="Windows_NT" goto nt
echo This script only works with NT-based versions of Windows.
goto :end

:nt

echo This script must be run as Administrator.
echo Once the service is installed, do not move nssm*.exe files!
echo ...
echo Please check the output below
echo ...

rem Install the service
if "%PROCESSOR_ARCHITECTURE%" == "AMD64" goto amd64nssm
goto x86nssm

:x86nssm
"%~dp0\nssm.exe" install Lightstreamer %SERVICE_DISPLAY_NAME% %SERVICE_DESCRIPTION% %SERVICE_START_TYPE% "%~dp0\LS.bat" silent
goto :startserv

:amd64nssm
"%~dp0\nssm_x64.exe" install Lightstreamer %SERVICE_DISPLAY_NAME% %SERVICE_DESCRIPTION% %SERVICE_START_TYPE% "%~dp0\LS.bat" silent
goto :startserv

:startserv
if NOT "%SERVICE_START_TYPE%" == "Automatic" goto end
net start Lightstreamer

:end
pause
