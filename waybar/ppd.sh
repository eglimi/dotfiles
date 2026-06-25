#!/bin/sh
# Power-profiles-daemon status for waybar (custom module).
cur=$(powerprofilesctl get 2>/dev/null)
case "$cur" in
    performance) icon="" ;;
    balanced)    icon="" ;;
    power-saver) icon="" ;;
    *)           icon=""; cur="unknown" ;;
esac
printf '{"text":"%s","tooltip":"Power profile: %s","class":"%s"}\n' "$icon" "$cur" "$cur"
