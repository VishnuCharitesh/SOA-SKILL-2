@REM ----------------------------------------------------------------------------
@REM Maven Start Up Batch script with Smart Java Auto-Detection
@REM ----------------------------------------------------------------------------

@echo off
@setlocal EnableExtensions EnableDelayedExpansion

set "JAVACMD="

if not "%JAVA_HOME%" == "" (
    if exist "%JAVA_HOME%\bin\java.exe" (
        set "JAVACMD=%JAVA_HOME%\bin\java.exe"
    )
)

if "%JAVACMD%" == "" (
    for %%i in (java.exe) do set "JAVACMD=%%~$PATH:i"
)

if "%JAVACMD%" == "" (
    if exist "C:\Program Files\Java\latest\bin\java.exe" (
        set "JAVACMD=C:\Program Files\Java\latest\bin\java.exe"
    ) else if exist "C:\Program Files\Java\jdk-21.0.12\bin\java.exe" (
        set "JAVACMD=C:\Program Files\Java\jdk-21.0.12\bin\java.exe"
    ) else if exist "C:\Program Files\Common Files\Oracle\Java\javapath\java.exe" (
        set "JAVACMD=C:\Program Files\Common Files\Oracle\Java\javapath\java.exe"
    )
)

if "%JAVACMD%" == "" (
    echo [ERROR] java.exe could not be found. Please ensure Java 17 or higher is installed and added to PATH or JAVA_HOME.
    exit /b 1
)

set "DIRNAME=%~dp0"
if "%DIRNAME%" == "" set "DIRNAME=."
set "MAVEN_PROJECTBASEDIR=%DIRNAME%"

set WRAPPER_JAR="%MAVEN_PROJECTBASEDIR%\.mvn\wrapper\maven-wrapper.jar"
set WRAPPER_LAUNCHER=org.apache.maven.wrapper.MavenWrapperMain

if exist %WRAPPER_JAR% goto run

echo Downloading Maven Wrapper...
if not exist "%MAVEN_PROJECTBASEDIR%\.mvn\wrapper" mkdir "%MAVEN_PROJECTBASEDIR%\.mvn\wrapper"
powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object Net.WebClient).DownloadFile('https://repo.maven.apache.org/maven2/org/apache/maven/wrapper/maven-wrapper/3.2.0/maven-wrapper-3.2.0.jar', '%WRAPPER_JAR%')}"
if exist %WRAPPER_JAR% goto run

echo Error: Could not find or download maven-wrapper.jar
exit /b 1

:run
"%JAVACMD%" -Dmaven.multiModuleProjectDirectory="%MAVEN_PROJECTBASEDIR%" -classpath %WRAPPER_JAR% %WRAPPER_LAUNCHER% %*
if ERRORLEVEL 1 exit /b 1
exit /b 0

