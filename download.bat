@echo off
cls
title Web Downloader v.1
set year=%date:~10,4%
set month=%date:~4,2%
set day=%date:~7,2%
set hour=%time:~0,2%
set minute=%time:~3,2%
set current=%year%_%month%_%day%_%hour%_%minute%
echo %1|find /i "http://" >nul && goto download
net session>nul 2>&1
if %errorlevel% == 0 goto beginning
echo This program might not work unless it is started as an administrator
echo Type yes to continue anyways
set /p confirm-run=
if "%confirm-run%"=="yes" goto beginning
exit
:beginning
cls
if not exist "%userprofile%\web_downloads" mkdir "%userprofile%\web_downloads"
::This program was created by Maxwell Fisher
echo Please type the url of the website that you would like to download:
:start
set /p site=
set "site"="%site:https=http%"
set "site"="%site%%1"
echo %site%|find /i "http://" >nul && goto download
cls&& echo Please type the websites url again, making sure that you include http://&& goto start
:download
bitsadmin /transfer myDownloadJob /download /priority normal %site% %userprofile%\web_downloads\%current%.html >nul
cls
if exist %userprofile%\web_downloads\%current%.html if "%errorlevel%"=="0" goto success
if "%errorlevel%"=="-2145386477" echo An error has occured. 0x80200013
echo Unable to save :(
goto end
:success
echo Your website has been downloaded as %userprofile%\web_downloads\%current%.html
:end
echo Press any key to close
pause >nul