@echo off
cd /d "%~dp0"

set TEMP=%cd%
cd ../../
echo %cd%
set ROOT=%cd%
cd %TEMP%

set AdminName=ruoyi-admin
set MonitorAdminName=ruoyi-monitor-admin
set SnailjobName=ruoyi-snailjob-server

set Namespace=ruoyi-tdesign
set Version=1.4.0

ECHO.
	ECHO.  [1] docker build %AdminName%.jar
	ECHO.  [2] docker build %MonitorAdminName%.jar
	ECHO.  [3] docker build %SnailjobName%.jar
	ECHO.  [0] exit
ECHO.

ECHO.Please enter the serial number of the selected item:
set /p ID=
	IF "%id%"=="1" GOTO admin
	IF "%id%"=="2" GOTO monitoradmin
	IF "%id%"=="3" GOTO snailjob
	IF "%id%"=="0" EXIT
PAUSE

:admin
    set __IMAGE_NAME=%Namespace%/%AdminName%:%Version%
    set __DOCKERFILE_PATH=%ROOT%/%AdminName%/Dockerfile
    set __PATH=%ROOT%/%AdminName%
    set __BUILD_ARG=target/%AdminName%.jar
goto exec

:monitoradmin
    set __IMAGE_NAME=%Namespace%/%MonitorAdminName%:%Version%
    set __DOCKERFILE_PATH=%ROOT%/ruoyi-extend/%MonitorAdminName%/Dockerfile
    set __PATH=%ROOT%/ruoyi-extend/%MonitorAdminName%
    set __BUILD_ARG=target/%MonitorAdminName%.jar
goto exec

:snailjob
    set __IMAGE_NAME=%Namespace%/%SnailjobName%:%Version%
    set __DOCKERFILE_PATH=%ROOT%/ruoyi-extend/%SnailjobName%/Dockerfile
    set __PATH=%ROOT%/ruoyi-extend/%SnailjobName%
    set __BUILD_ARG=target/%SnailjobName%.jar
goto exec

:exec
echo Building %__IMAGE_NAME%...

echo docker build -t %__IMAGE_NAME% -f "%__DOCKERFILE_PATH%" %__PATH% --build-arg JAR_FILE="%__BUILD_ARG%" --no-cache

docker build -t %__IMAGE_NAME% -f "%__DOCKERFILE_PATH%" %__PATH% --build-arg JAR_FILE="%__BUILD_ARG%" --no-cache
goto:eof

PAUSE
