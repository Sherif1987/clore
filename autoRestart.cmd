:loop
tasklist /FI "IMAGENAME eq libclient.exe" 2>NUL | find /I /N "libclient.exe">NUL
if "%ERRORLEVEL%"=="0" goto :libclientRunning

tasklist /FI "IMAGENAME eq librunner.exe" 2>NUL | find /I /N "librunner.exe">NUL
if "%ERRORLEVEL%"=="0" goto :librunnerRunning

tasklist /FI "IMAGENAME eq qpro-miner.exe" 2>NUL | find /I /N "qpro-miner.exe">NUL
if "%ERRORLEVEL%"=="0" goto :qproMinerRunning

echo Process is not running up. Restarting in 5s...
taskkill /F /IM libclient.exe
taskkill /F /IM librunner.exe
taskkill /F /IM qpro-miner.exe
timeout /t 5
start qpro-miner.exe
goto :loop

:libclientRunning
:librunnerRunning
:qproMinerRunning
timeout /t 60
goto :loop