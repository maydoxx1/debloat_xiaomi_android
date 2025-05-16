#!/usr/bin/env bash

echo "🔍 Checking ADB..."
if ! command -v adb &> /dev/null; then
    echo "❌ ADB not found. Install Android Platform Tools."
    exit 1
fi

adb start-server
adb devices
read -rp "📱 Ensure your device is connected and authorized. Press Enter to continue..."

echo "⚠️ The following Xiaomi apps will be uninstalled:"
echo "
com.miui.analytics
com.miui.msa.global
com.miui.systemAdSolution
com.miui.daemon
com.miui.hybrid
com.miui.hybrid.accessory
com.xiaomi.joyose
com.xiaomi.mipicks
com.xiaomi.payment
com.xiaomi.glgm
com.xiaomi.mirecycle
com.xiaomi.midrop
com.xiaomi.mircs
com.xiaomi.scanner
com.xiaomi.xmsf
com.xiaomi.xmsfkeeper
com.miui.player
com.miui.videoplayer
com.miui.notes
com.miui.cleanmaster
com.miui.yellowpage
com.miui.userguide
com.miui.compass
com.miui.fm
com.miui.bugreport
com.duokan.phone.remotecontroller
com.duokan.phone.remotecontroller.peel.plugin
com.miui.enbbs
com.miui.virtualsim
com.miui.vsimcore
com.miui.translationservice
com.miui.mishare.connectivity
com.miui.android.fashiongallery
com.miui.smarttravel
com.miui.voiceassistant
com.miui.miservice
com.miui.cloudbackup
com.miui.cloudservice
com.miui.cloudservice.sysbase
com.miui.micloudsync
com.mi.globalminusscreen
com.mi.globalbrowser
com.mi.android.globalFileexplorer
"

read -rp "❓ Proceed with uninstalling these apps? (y/n): " confirm
if [[ $confirm != "y" ]]; then
    echo "❌ Aborted."
    exit 0
fi

adb shell "
pm uninstall --user 0 com.miui.analytics && \
pm uninstall --user 0 com.miui.msa.global && \
pm uninstall --user 0 com.miui.systemAdSolution && \
pm uninstall --user 0 com.miui.daemon && \
pm uninstall --user 0 com.miui.hybrid && \
pm uninstall --user 0 com.miui.hybrid.accessory && \
pm uninstall --user 0 com.xiaomi.joyose && \
pm uninstall --user 0 com.xiaomi.mipicks && \
pm uninstall --user 0 com.xiaomi.payment && \
pm uninstall --user 0 com.xiaomi.glgm && \
pm uninstall --user 0 com.xiaomi.mirecycle && \
pm uninstall --user 0 com.xiaomi.midrop && \
pm uninstall --user 0 com.xiaomi.mircs && \
pm uninstall --user 0 com.xiaomi.scanner && \
pm uninstall --user 0 com.xiaomi.xmsf && \
pm uninstall --user 0 com.xiaomi.xmsfkeeper && \
pm uninstall --user 0 com.miui.player && \
pm uninstall --user 0 com.miui.videoplayer && \
pm uninstall --user 0 com.miui.notes && \
pm uninstall --user 0 com.miui.cleanmaster && \
pm uninstall --user 0 com.miui.yellowpage && \
pm uninstall --user 0 com.miui.userguide && \
pm uninstall --user 0 com.miui.compass && \
pm uninstall --user 0 com.miui.fm && \
pm uninstall --user 0 com.miui.bugreport && \
pm uninstall --user 0 com.duokan.phone.remotecontroller && \
pm uninstall --user 0 com.duokan.phone.remotecontroller.peel.plugin && \
pm uninstall --user 0 com.miui.enbbs && \
pm uninstall --user 0 com.miui.virtualsim && \
pm uninstall --user 0 com.miui.vsimcore && \
pm uninstall --user 0 com.miui.translationservice && \
pm uninstall --user 0 com.miui.mishare.connectivity && \
pm uninstall --user 0 com.miui.android.fashiongallery && \
pm uninstall --user 0 com.miui.smarttravel && \
pm uninstall --user 0 com.miui.voiceassistant && \
pm uninstall --user 0 com.miui.miservice && \
pm uninstall --user 0 com.miui.cloudbackup && \
pm uninstall --user 0 com.miui.cloudservice && \
pm uninstall --user 0 com.miui.cloudservice.sysbase && \
pm uninstall --user 0 com.miui.micloudsync && \
pm uninstall --user 0 com.mi.globalminusscreen && \
pm uninstall --user 0 com.mi.globalbrowser && \
pm uninstall --user 0 com.mi.android.globalFileexplorer
"

echo "✅ Debloating complete."

adb reboot
