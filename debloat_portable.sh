#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

echo "🔧 Xiaomi Debloater Script (Portable Bash)"
read -rp "👉 Enter full path to your adb executable (e.g., /usr/bin/adb): " ADB_PATH

if [[ ! -x "$ADB_PATH" ]]; then
  echo "❌ ADB not found or not executable at: $ADB_PATH"
  exit 1
fi

echo "📱 Starting ADB server and listing devices..."
"$ADB_PATH" start-server
"$ADB_PATH" devices
read -rp "⚠️ Ensure your device is connected and authorized. Press Enter to continue..."

# Define packages to uninstall
PACKAGES=(
com.miui.analytics com.miui.msa.global com.miui.systemAdSolution com.miui.daemon com.miui.hybrid
com.miui.hybrid.accessory com.xiaomi.joyose com.xiaomi.mipicks com.xiaomi.payment com.xiaomi.glgm
com.xiaomi.mirecycle com.xiaomi.midrop com.xiaomi.mircs com.xiaomi.scanner com.xiaomi.xmsf
com.xiaomi.xmsfkeeper com.miui.player com.miui.videoplayer com.miui.notes com.miui.cleanmaster
com.miui.yellowpage com.miui.userguide com.miui.compass com.miui.fm com.miui.bugreport
com.duokan.phone.remotecontroller com.duokan.phone.remotecontroller.peel.plugin com.miui.enbbs
com.miui.virtualsim com.miui.vsimcore com.miui.translationservice com.miui.mishare.connectivity
com.miui.android.fashiongallery com.miui.smarttravel com.miui.voiceassistant com.miui.miservice
com.miui.cloudbackup com.miui.cloudservice com.miui.cloudservice.sysbase com.miui.micloudsync
com.mi.globalminusscreen com.mi.globalbrowser com.mi.android.globalFileexplorer
)

echo "📦 The following Xiaomi apps will be uninstalled:"
for pkg in "${PACKAGES[@]}"; do echo " - $pkg"; done

read -rp "❓ Proceed with uninstalling these apps? (y/n): " confirm
if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
  echo "🚫 Aborted by user."
  exit 0
fi

for pkg in "${PACKAGES[@]}"; do
  echo "🚮 Uninstalling $pkg..."
  if "$ADB_PATH" shell pm list packages | grep -q "$pkg"; then
    "$ADB_PATH" shell pm uninstall --user 0 "$pkg" || echo "⚠️ Failed to uninstall $pkg"
  else
    echo "ℹ️ $pkg not found. Skipping."
  fi
done

# Disable some stubborn system apps (if still exist)
DISABLE_LIST=(
  com.xiaomi.midrop
  com.miui.notes
  com.miui.compass
)

for pkg in "${DISABLE_LIST[@]}"; do
  echo "🛑 Attempting to disable $pkg..."
  if "$ADB_PATH" shell pm list packages | grep -q "$pkg"; then
    "$ADB_PATH" shell pm disable-user --user 0 "$pkg" || echo "⚠️ Could not disable $pkg"
  else
    echo "ℹ️ $pkg not found. Skipping."
  fi
done

echo "✅ Debloating complete. Rebooting..."
"$ADB_PATH" reboot
