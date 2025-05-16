@echo off
echo 🔍 Checking for ADB...

where adb >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ ADB not found. Please install Android Platform Tools.
    pause
    exit /b
)

adb start-server
adb devices
echo 📱 Ensure your device is connected and authorized.
pause

:: Xiaomi packages to uninstall
setlocal enabledelayedexpansion
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
    adb shell pm uninstall --user 0 %%P
)

echo ✅ Debloating complete.
echo Rebooting
adb reboot
pause
