#!/bin/bash

load_emu() {
  # If an emulator is already running, don't start another
  if adb devices 2>/dev/null | grep -q emulator; then
    echo "ℹ️ Emulator already running"
    return 0
  fi

  local avd
  avd=$(emulator -list-avds | head -n 1)

  if [[ -z "$avd" ]]; then
    echo "❌ No Android emulators found"
    return 1
  fi

  echo "🚀 Starting emulator: $avd"

  emulator -avd "$avd" \
    -no-snapshot-load \
    -no-boot-anim \
    -gpu host \
    -netfast \
    -accel auto \
    -camera-back none \
    -camera-front none \
    -no-audio
}


openurl_eum() {
  local suffix="$1"
  local mode="$2"

  if [[ -z "$suffix" ]]; then
    echo "❌ Usage: openurl_eum <suffix|url> [mode]"
    echo "Modes:"
    echo "  0 → developer page"
    echo "  1 → bottomsheet"
    echo "  2 → direct url"
    echo "  default → page"
    return 1
  fi

  local base_url="https://www.indmoney.com/widget/"
  local final_url=""

  if [[ "$mode" == "0" ]]; then
    final_url="https://www.indmoney.com/developer_page"
  elif [[ "$mode" == "1" ]]; then
    final_url="${base_url}bottomsheet?page=${suffix}"
  elif [[ "$mode" == "2" ]]; then
    final_url="$suffix"
  else
    final_url="${base_url}page?page=${suffix}"
  fi

  echo "🔗 URL for emulator => $final_url"

  # Ensure emulator is running
  if ! adb devices 2>/dev/null | grep -q emulator; then
    load_emu || return 1
  fi

  adb shell am start \
    -a android.intent.action.VIEW \
    -d "$final_url"
}