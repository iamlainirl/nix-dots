#!/usr/bin/env bash

INTERNAL="eDP-1"

EXTERNALS=("HDMI-A-1" "DP-1" "DP-2" "DP-3")

connected_external=""

for mon in "${EXTERNALS[@]}"; do
  if hyprctl monitors all | grep -q "^Monitor $mon"; then
    connected_external="$mon"
    break
  fi
done

if [ -n "$connected_external" ]; then
  hyprctl keyword monitor "$connected_external,preferred,auto,1"
  sleep 0.3
  hyprctl keyword monitor "$INTERNAL,disable"

  notify-send "monitor" "external: $connected_external"
else
  hyprctl keyword monitor "$INTERNAL,preferred,auto,1"

  notify-send "monitor" "internal: $INTERNAL"
fi
