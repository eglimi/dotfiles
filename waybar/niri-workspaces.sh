#!/usr/bin/env bash
# Emit focused-output workspace indicator as waybar JSON; updates via niri event stream.
# Indicator only (no click-to-switch). Active workspace highlighted via pango markup.
set -euo pipefail

emit() {
  niri msg --json workspaces 2>/dev/null | python3 -c '
import sys, json, html
try:
    ws = json.load(sys.stdin)
except Exception:
    print('"'"'{"text":""}'"'"'); sys.exit(0)

# focused output = output of the workspace with is_focused
out = next((w["output"] for w in ws if w.get("is_focused")), None)
mine = sorted((w for w in ws if w["output"] == out), key=lambda w: w["idx"])

parts = []
for w in mine:
    label = w["name"] or str(w["idx"])
    label = html.escape(label)
    if w.get("is_active"):
        parts.append(f"<span foreground=\"#fabd2f\"><b>{label}</b></span>")
    elif w.get("is_urgent"):
        parts.append(f"<span foreground=\"#fb4934\">{label}</span>")
    else:
        parts.append(f"<span foreground=\"#928374\">{label}</span>")

print(json.dumps({"text": "  ".join(parts)}))
'
}

# Wait for niri IPC to be ready (autostart can launch waybar before niri's socket).
until niri msg --json workspaces >/dev/null 2>&1; do
  sleep 0.5
done

# Initial state
emit

# Follow workspace changes (push-based; blocks until an event arrives).
# Reconnect if the stream drops so the module never goes permanently empty.
while true; do
  niri msg --json event-stream 2>/dev/null | while read -r line; do
    case "$line" in
      *Workspace*|*WindowsChanged*|*WindowOpenedOrChanged*)
        emit
        ;;
    esac
  done
  sleep 1
done
