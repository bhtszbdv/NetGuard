@echo off
REM Kill any existing IIS Express processes
taskkill /F /IM iisexpress.exe 2>nul
timeout /t 2 /nobreak >nul

REM Start IIS Express
echo Starting IIS Express on port 50202...
"C:\Program Files (x86)\IIS Express\iisexpress.exe" /config:"%CD%\.vs\Web Development Assignment\config\applicationhost.config" /site:"Web Development Assignment"
