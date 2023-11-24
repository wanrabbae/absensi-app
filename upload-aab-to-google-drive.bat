@echo off
cls
set app=Hora
set gdrive=%GOOGLE_DRIVE_YMEET%
rem Preparing version label
for /F "tokens=*" %%g in ('cider version') do (set version=%%g)
for /F "usebackq tokens=1,2 delims==" %%i in (`wmic os get LocalDateTime /VALUE 2^>NUL`) do if '.%%i.'=='.LocalDateTime.' set ldt=%%j
set ldt=%ldt:~0,4%%ldt:~4,2%%ldt:~6,2%.%ldt:~8,2%%ldt:~10,2%
rem Renaming app bundle with version and timestamp
ren .\build\app\outputs\bundle\release\app-release.aab %app%-v%version%-%ldt%.aab &&^
rem Moving app bundle into Google Drive
move .\build\app\outputs\bundle\release\%app%-v%version%-%ldt%.aab "%gdrive%\%app%\APK" &&^
rem Open explorer
explorer %gdrive%\%app%\APK
