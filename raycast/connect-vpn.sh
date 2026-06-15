#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Connect VPN
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🔒
# @raycast.packageName VPN Connection

# Documentation:
# @raycast.description Connects to FGI VPN via OpenVPN CLI
# @raycast.author Justin Valencia
# @raycast.authorURL https://github.com/nyastin

CONFIG="$HOME/.openvpn/FGI.ovpn"
PIDFILE="/tmp/openvpn-fgi.pid"
LOGFILE="/tmp/openvpn-fgi.log"
OPENVPN="$(command -v openvpn || echo /opt/homebrew/sbin/openvpn)"

if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
  echo "VPN already connected (pid $(cat "$PIDFILE"))"
  exit 0
fi

if [ ! -f "$CONFIG" ]; then
  echo "Config not found: $CONFIG"
  exit 1
fi

sudo "$OPENVPN" \
  --config "$CONFIG" \
  --daemon \
  --writepid "$PIDFILE" \
  --log "$LOGFILE"

if [ $? -eq 0 ]; then
  echo "VPN connection initiated successfully"
else
  echo "Failed to initiate VPN connection"
  exit 1
fi
