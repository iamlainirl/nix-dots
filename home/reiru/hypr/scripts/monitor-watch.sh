#!/usr/bin/env bash

SWITCH_SCRIPT="$HOME/.config/hypr/scripts/monitor-switch.sh"
SOCKET="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

bash "$SWITCH_SCRIPT"

socat -U - UNIX-CONNECT:"$SOCKET" | while read -r event; do
  case "$event" in
  monitoradded* | monitorremoved*)
    sleep 1
    bash "$SWITCH_SCRIPT"
    ;;
  esac
done
