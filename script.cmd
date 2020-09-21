@echo off

set /A steam_game_id=252950
set path_program=D:\Documents\My Games\Rocket League
set exe_name_mod=BakkesMod.exe
set steam_path=C:\Program Files (x86)\Steam

set /A time_sleep=2

echo Running mod ...
start "" "%path_program%\%exe_name_mod%"

REM Waiting mod is running ...
timeout /t %time_sleep% /nobreak > nul

echo Running steam game ...
"%steam_path%\steam.exe" "-applaunch" "%steam_game_id%"

REM Waiting game is running ...
:loop 
FOR /F "tokens=2* skip=2" %%a in ('reg query "HKEY_CURRENT_USER\SOFTWARE\Valve\Steam" /v "RunningAppID"') do set /A HKEY_IDGAME=%%b
if "0" EQU "%HKEY_IDGAME%" ( 
   timeout /t %time_sleep% /nobreak > nul 
   goto :loop 
)

echo Check if steam game is running ...
:loop2 
FOR /F "tokens=2* skip=2" %%a in ('reg query "HKEY_CURRENT_USER\SOFTWARE\Valve\Steam" /v "RunningAppID"') do set /A HKEY_IDGAME=%%b
if "%steam_game_id%" EQU "%HKEY_IDGAME%" ( 
   timeout /t %time_sleep% /nobreak > nul 
   goto :loop2 
)

echo Exiting program ...
taskkill /IM "%exe_name_mod%"
