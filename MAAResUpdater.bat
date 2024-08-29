@ECHO OFF
title MAAResUpdater By wuyilingwei
color 0A
:: ver 0.1.3
:: Release Date: 2024/08/19
:: Preset Url: GitHub; Personal Minnor Wuyilingwei Server

:: dir check
if not exist MAA.exe (
    echo [ERROR] Cannot find MAA.exe, please put this script in the same directory as MAA.exe.
    pause
    exit 3
)

:: bypass url check
:: set url="Put your url here"
:: goto download
echo [NOTICE] Minimal Windows Version require Windows10, higher than 1803 (or curl and tar avaliable).
echo [INFO] Testing internet connection...
ping github.com -n 2 -w 1000 > nul
if not errorlevel 0 (
    echo [ERROR] Cannot directly connect to Github.
) else (
    echo [INFO] Connected to Github.
    set url=https://github.com/MaaAssistantArknights/MaaResource/archive/refs/heads/main.zip
    goto download
)
set errorlevel=0
ping maares.wuyilingwei.com -n 2 -w 1000 > nul
if not errorlevel 0 (
    echo [ERROR] Cannot connect to Minnor Server: maares.wuyilingwei.com.
) else (
    echo [INFO] Connected to maa.wuyilingwei.com.
    set url=http://maares.wuyilingwei.com
    goto download
)
echo [ERROR] Preset servers are all down. Please enter a valid URL to download the resource pack.
set /p url=[INFO] URL:

:download
echo [INFO] Downloading resource pack form %url%...
set errorlevel=0
curl -L -o MAAResource.zip %url%
if not errorlevel 0 (
    echo [ERROR] Failed to download resource pack.
    pause
    exit 2
)
echo [INFO] Resource pack downloaded successfully.
echo [INFO] Extracting resource pack...
tar -xf MAAResource.zip
if not errorlevel 0 (
    echo [ERROR] Failed to extract resource pack.
    pause
    exit 1
)
:: 将 MaaResource-main\cache\和MaaResource-main\resource 下的文件移动到 MAA.exe 所在目录的 cache 文件夹下
echo [INFO] Updating resource pack...
xcopy /s /y MaaResource-main\cache\ cache\
xcopy /s /y MaaResource-main\resource\ resource\
echo [INFO] Resource pack updated successfully.
echo [INFO] Cleaning up...
rmdir /s /q MaaResource-main
del /q MAAResource.zip
echo [INFO] Done.
echo [INFO] Try to pull up Maa.exe
start MAA.exe
echo [INFO] Program will exit in 5 seconds.
timeout /nobreak /t 5 > nul
exit 0


:: ---
change Log

0.1 Release First Version

0.1.1 Add Windows Version Notices

0.1.2 Fix Preset Url Check Problem.

0.1.3 Add Auto Start MAA.exe

:: ---