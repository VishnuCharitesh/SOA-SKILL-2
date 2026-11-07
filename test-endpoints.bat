@echo off
setlocal
set TARGET_HOST=%1
if "%TARGET_HOST%" == "" (
    set TARGET_HOST=http://localhost:8080
)

echo ========================================================
echo Testing CloudDeploymentDemo Endpoints on %TARGET_HOST%
echo ========================================================

echo.
echo [1] Testing Endpoint: %TARGET_HOST%/
curl -s -X GET "%TARGET_HOST%/"
echo.

echo.
echo [2] Testing Endpoint: %TARGET_HOST%/health
curl -s -X GET "%TARGET_HOST%/health"
echo.

echo.
echo [3] Testing Endpoint: %TARGET_HOST%/student
curl -s -X GET "%TARGET_HOST%/student"
echo.

echo.
echo ========================================================
echo Testing Completed Successfully!
echo ========================================================
pause

