#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Disconnect VPN
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🔓
# @raycast.packageName VPN Connection

# Documentation:
# @raycast.description Disconnects from TunnelBlick VPN and quits the application
# @raycast.author Justin Valencia
# @raycast.authorURL https://github.com/nyastin

# Capture the output of the AppleScript
result=$(
  osascript <<EOD
tell application "Tunnelblick"
  if it is running then
    set connections to get name of configurations where state = "CONNECTED"
    if connections is not {} then
      disconnect all
      delay 2 -- Wait for 2 seconds to ensure disconnection completes
      quit
      return "VPN disconnected and Tunnelblick quit successfully"
    else
      quit
      return "No active VPN connections found. Tunnelblick quit."
    end if
  else
    return "Tunnelblick is not running"
  end if
end tell
EOD
)

# Echo the result
echo "$result"

# Set exit status based on the result
if [[ "$result" == "VPN disconnected and Tunnelblick quit successfully" || "$result" == "No active VPN connections found. Tunnelblick quit." ]]; then
  exit 0
else
  exit 1
fi
