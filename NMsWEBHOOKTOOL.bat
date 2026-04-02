@echo off
cls
title "NOTMONKS WEBHOOK TOOL"
echo --- Discord Webhook Tool ---
set /p WEBHOOK=Enter Webhook URL: 
set /p MESSAGE=Enter Message: 
powershell -Command "$msg='%MESSAGE%'; $hook='%WEBHOOK%'; $body=@{content=$msg} | ConvertTo-Json; Invoke-RestMethod -Uri $hook -Method Post -Body $body -ContentType 'application/json'"
echo Message sent!
timeout /t 1 >nul
echo closing in 2 seconds
timeout /t 2 >nul
exit