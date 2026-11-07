@echo off
setlocal
echo ========================================================
echo Building and Running CloudDeploymentDemo Locally
echo ========================================================

cd /d "%~dp0"

echo [1/2] Compiling and Packaging Spring Boot Application...
if exist "mvnw.cmd" (
    call mvnw.cmd clean package -DskipTests
) else (
    call mvn clean package -DskipTests
)

if not exist "target\CloudDeploymentDemo-0.0.1-SNAPSHOT.jar" (
    echo.
    echo [ERROR] Build failed or target JAR not found!
    pause
    exit /b 1
)

echo.
echo [2/2] Starting application on port 8080...
echo Access endpoints once started:
echo   Home:        http://localhost:8080/
echo   Health:      http://localhost:8080/health
echo   Student:     http://localhost:8080/student
echo ========================================================

java -jar target\CloudDeploymentDemo-0.0.1-SNAPSHOT.jar
pause

