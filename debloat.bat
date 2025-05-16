@echo off
title Xiaomi Debloater
setlocal enabledelayedexpansion

:: Prompt user for ADB path
echo 🔍 Please enter the full path to your ADB executable (e.g., C:\platform-tools\adb.exe):
set /p ADB_PATH=ADB path: 

if not exist "%ADB_PATH%" (
    echo ❌ ADB not found at the specified location. Please check the path and try again.
    pause
    exit /b
)

:: Start ADB server and list devices
"%ADB_PATH%" start-server
"%ADB_PATH%" devices
echo 📱 Ensure your device is connected and authorized.
pause

:: Xiaomi packages to uninstall
set PACKAGES=^
com.miui.analytics com.miui.msa.global com.miui.systemAdSolution com.miui.daemon com.miui.hybrid ^
com.miui.hybrid.accessory com.xiaomi.joyose com.xiaomi.mipicks com.xiaomi.payment com.xiaomi.glgm ^
com.xiaomi.mirecycle com.xiaomi.midrop com.xiaomi.mircs com.xiaomi.scanner com.xiaomi.xmsf ^
com.xiaomi.xmsfkeeper com.miui.player com.miui.videoplayer com.miui.notes com.miui.cleanmaster ^
com.miui.yellowpage com.miui.userguide com.miui.compass com.miui.fm com.miui.bugreport ^
com.duokan.phone.remotecontroller com.duokan.phone.remotecontroller.peel.plugin com.miui.enbbs ^
com.miui.virtualsim com.miui.vsimcore com.miui.translationservice com.miui.mishare.connectivity ^
com.miui.android.fashiongallery com.miui.smarttravel com.miui.voiceassistant com.miui.miservice ^
com.miui.cloudbackup com.miui.cloudservice com.miui.cloudservice.sysbase com.miui.micloudsync ^
com.mi.globalminusscreen com.mi.globalbrowser com.mi.android.globalFileexplorer

echo ⚠️ The following Xiaomi apps will be uninstalled:
for %%P in (%PACKAGES%) do echo  - %%P

set /p confirm=❓ Proceed with uninstalling these apps? (y/n): 
if /I not "%confirm%"=="y" (
    echo ❌ Aborted.
    exit /b
)

for %%P in (%PACKAGES%) do (
    echo 📦 Uninstalling %%P...
    "%ADB_PATH%" shell pm uninstall --user 0 %%P
)

echo ✅ Debloating complete.
echo Rebooting device...
"%ADB_PATH%" reboot
pause
