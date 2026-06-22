#!/usr/bin/env bash
# fuzzel-based power menu for niri
set -euo pipefail

lock="  Lock"
logout="  Logout"
suspend="  Suspend"
reboot="  Reboot"
shutdown="  Shutdown"

chosen=$(printf '%s\n' "$lock" "$logout" "$suspend" "$reboot" "$shutdown" \
  | fuzzel --dmenu --prompt "Power: " --lines 5 --width 14)

case "$chosen" in
  "$lock")     swaylock -f ;;
  "$logout")   niri msg action quit ;;
  "$suspend")  systemctl suspend ;;
  "$reboot")   systemctl reboot ;;
  "$shutdown") systemctl poweroff ;;
esac
