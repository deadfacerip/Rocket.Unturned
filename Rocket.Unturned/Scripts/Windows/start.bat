@ECHO OFF 
REM This script installs and starts a Unturned 3 server on Windows machines
REM To just start servers with this script place it next to Unturned.exe
REM Syntax: start.bat <instance name>
REM Author: fr34kyn01535

IF [%1]==[] GOTO restart

IF "%~1"=="-FIXED_CTRL_C" (
   SHIFT
) ELSE (
   CALL <NUL %0 -FIXED_CTRL_C %*
   GOTO :EOF
)

SET INSTANCENAME=%1

SET UNTURNEDHOME=%~dp0..\
SET STEAMHOME=%~dp0..\..\Steam\

ECHO Steam directory: %STEAMHOME%
ECHO Unturned directory: %UNTURNEDHOME%

IF NOT EXIST %STEAMHOME% (
	update.bat
)
CD %UNTURNEDHOME%

:unturned
ECHO [%time%] Unturned started.
Unturned.exe -logFile "Servers\%INSTANCENAME%\Rocket\Unturned.log" -nographics -batchmode -silent-crashes +secureserver/%INSTANCENAME%
ECHO [%time%] WARNING: Unturned closed or crashed, restarting.
ping 1.1.1.1 -n 1 -w 3000 >nul
GOTO unturned

:restart
SET /p INSTANCENAME= "Instance: "
%0 %INSTANCENAME%
