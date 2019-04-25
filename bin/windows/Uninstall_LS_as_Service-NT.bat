@echo off
setlocal

rem
rem NSSM Lightstreamer NT service uninstall script
rem

if "%OS%"=="Windows_NT" goto nt
echo This script only works with NT-based versions of Windows.
goto :end

:nt

echo This script must be run as Administrator.
echo Once the service is installed, do not move nssm*.exe files!
echo ...
echo Please check the output below
echo ...

rem Try to stop the service
net stop Lightstreamer

rem Remove the service
if "%PROCESSOR_ARCHITECTURE%" == "AMD64" goto amd64nssm
goto x86nssm

:x86nssm
"%~dp0\nssm.exe" remove Lightstreamer confirm
goto :end

:amd64nssm
"%~dp0\nssm_x64.exe" remove Lightstreamer confirm

:end
pause
