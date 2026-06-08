@echo off

set "CURRENT_VERSION=2.00"

set "API_URL=https://api.github.com/repos/NotMonk1/NMsWebhookTool/releases/latest"
set "TEMP_FILE=%TEMP%\gh_version.txt"

echo Checking for updates...

curl -s -H "Accept: application/vnd.github+json" "%API_URL%" | findstr /i "tag_name" > "%TEMP_FILE%"

set /p RAW_LINE=<"%TEMP_FILE%"
del "%TEMP_FILE%"

for /f "tokens=2 delims=:," %%A in ("%RAW_LINE%") do set "LATEST_RAW=%%~A"

set "LATEST_VERSION=%LATEST_RAW: =%"
set "LATEST_VERSION=%LATEST_VERSION:"=%"
if /i "%LATEST_VERSION:~0,1%"=="v" set "LATEST_VERSION=%LATEST_VERSION:~1%"

echo Current version : %CURRENT_VERSION%
echo Latest version  : %LATEST_VERSION%

if "%CURRENT_VERSION%"=="%LATEST_VERSION%" (
    goto start
) else (
    goto update
)

endlocal

:start
cls
echo ============================================================================================
echo           /$$      /$$ /$$$$$$$$ /$$$$$$$  /$$   /$$  /$$$$$$   /$$$$$$  /$$   $$/
echo         ^| $$  /$ ^| $$^| $$_____/^| $$__  $$^| $$  ^| $$ /$$__  $$ /$$__  $$^| $$  /$$/
echo         ^| $$ /$$$^| $$^| $$      ^| $$  \ $$^| $$  ^| $$^| $$  \ $$^| $$  \ $$^| $$ /$$/ 
echo         ^| $$/$$ $$ $$^| $$$$$   ^| $$$$$$$ ^| $$$$$$$$^| $$  ^| $$^| $$  ^| $$^| $$$$$/  
echo         ^| $$$$_  $$$$^| $$__/   ^| $$__  $$^| $$__  $$^| $$  ^| $$^| $$  ^| $$^| $$  $$  
echo         ^| $$$/ \  $$$^| $$      ^| $$  \ $$^| $$  ^| $$^| $$  ^| $$^| $$  ^| $$^| $$\  $$ 
echo         ^| $$/   \  $$^| $$$$$$$$^| $$$$$$$/^| $$  ^| $$^|  $$$$$$/^|  $$$$$$/^| $$ \  $$
echo          ^|__/     \__/^|________/^|_______/ ^|__/  ^|__/ \______/  \______/ ^|__/  \__/
echo.
echo.
echo                          /$$$$$$$$ /$$$$$$   /$$$$$$  /$$
echo                         ^|__  $$__//$$__  $$ /$$__  $$^| $$
echo                            ^| $$  ^| $$  \ $$^| $$  \ $$^| $$
echo                            ^| $$  ^| $$  ^| $$^| $$  ^| $$^| $$
echo                            ^| $$  ^| $$  ^| $$^| $$  ^| $$^| $$
echo                            ^| $$  ^| $$  ^| $$^| $$  ^| $$^| $$
echo                            ^| $$  ^|  $$$$$$/^|  $$$$$$/^| $$$$$$$$
echo                            ^|__/   \______/  \______/ ^|________/
echo ============================================================================================
echo                         Made by: NotMonk (@notmonk.idiot on discord)
echo ============================================================================================
echo  ^|                               Click 1 To start                                           ^|
echo ============================================================================================
set /p "StartupSelection= "
if "%StartupSelection%"=="1" goto main
:main
cls
echo ================================================================================
echo [1] Webhook Message Sender ^|	Sends A Message To A Webhook
echo [2] Webhook Spammer	   ^|	Sends A LOT of Messages To A Webhook
echo [3] Webhook Deleter	   ^|	Deletes A Webhook
echo ============================
echo .
echo .
echo .
echo .
echo .
echo .
echo ================================================================================
set /p "Selection= "
if "%Selection%"=="1" goto WebhookSender
if "%Selection%"=="2" goto WebhookSpammer
if "%Selection%"=="3" goto WebhookDeleter
if "%Selection%"=="4" goto Update

:WebhookSender
@echo off
set /p "WEBHOOK_URL=WEBHOOK URL: "
set /p "msg=Message: "

curl -s -X POST -H "Content-Type: application/json" ^
     -d "{\"content\": \"%msg%\"}" ^
     "%WEBHOOK_URL%"

echo.
echo Sent.
pause
goto main
:WebhookSpammer
@echo off
set /p "WEBHOOK_URL=WEBHOOK URL: "
set /p "msg=Message: "

echo hit CTRL + C to stop
:SpamLoop
curl -s -X POST -H "Content-Type: application/json" ^
     -d "{\"content\": \"%msg%\"}" ^
     "%WEBHOOK_URL%"
     
goto SpamLoop

:WebhookDeleter
set /p "WEBHOOK_URL=Paste webhook URL: "

echo Deleting...
curl -s -o nul -w "%%{http_code}" -X DELETE "%WEBHOOK_URL%"

echo.
echo Done. (204 = success, 404 = not found, 401 = no permission)
pause
goto main

:Update
cls
echo ================================================================================
echo Hello! A new update has been detected. Please dowload it that way you can
echo continue using the program without any issues.
echo                                                                        - NotMonk
echo .
echo [1] Open GitHub Page
echo [2] Exit
echo [3] Update Info
echo ================================================================================
set /p "Selection= "
if "%Selection%"=="1" start https://github.com & exit
if "%Selection%"=="2" exit
if "%Selection%"=="3" echo Update info: %LATEST_VERSION% (current: %CURRENT_VERSION%) & timeout /t 5 & goto Update

