#!/bin/bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
agent="$HOME/Library/LaunchAgents/com.alexvt.whisperinputmlx.plist"

echo "Installing launch agent to $agent"
mkdir -p "$(dirname "$agent")"

sed "s#__REPO_ROOT__#${repo_root}#g" \
  "$repo_root/com.alexvt.whisperinputmlx.plist.in" > "$agent"

launchctl bootout gui/$(id -u)/com.alexvt.whisperinputmlx >/dev/null 2>&1 || true
launchctl bootstrap gui/$(id -u) "$agent"

echo "Launch agent installed."
