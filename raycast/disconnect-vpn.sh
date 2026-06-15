#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Disconnect VPN
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🔓
# @raycast.packageName VPN Connection

# Documentation:
# @raycast.description Disconnects the FGI VPN
# @raycast.author Justin Valencia
# @raycast.authorURL https://github.com/nyastin

PIDFILE="/tmp/openvpn-fgi.pid"

if [ ! -f "$PIDFILE" ]; then
  echo "VPN not running"
  exit 0
fi

sudo kill "$(cat "$PIDFILE")" && rm -f "$PIDFILE"
echo "VPN disconnected"
