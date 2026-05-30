@echo off
title NetGuard - IIS Express Launcher
echo Stopping any existing IIS Express instances...
taskkill /F /IM iisexpress.exe 2>nul
timeout /t 2 /nobreak >nul

echo Starting NetGuard web application on port 50202...
"C:\Program Files (x86)\IIS Express\iisexpress.exe" ^
  /config:"%~dp0.vs\Web Development Assignment\config\applicationhost.config" ^
  /site:"Web Development Assignment"

echo.
echo IIS Express has stopped. Press any key to exit.
pause
