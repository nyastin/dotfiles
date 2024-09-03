#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Connect VPN
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🔒
# @raycast.packageName VPN Connection

# Documentation:
# @raycast.description Launches TunnelBlick and connects to vpnconfig
# @raycast.author Justin Valencia
# @raycast.authorURL https://github.com/nyastin

osascript <<EOD
tell application "Tunnelblick"
  launch
  connect "vpnconfig"
end tell
EOD

if [ $? -eq 0 ]; then
  echo "VPN connection initiated successfully"
else
  echo "Failed to initiate VPN connection"
  exit 1
fi
