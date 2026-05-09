#!/usr/bin/env bash

emit() {
  local text="$1"
  local class="$2"
  local tooltip="$3"

  jq -nc \
    --arg text "$text" \
    --arg class "$class" \
    --arg tooltip "$tooltip" \
    '{text:$text, class:$class, tooltip:$tooltip}'
}

default_dev="$(ip route show default 2>/dev/null | awk '{for (i=1;i<=NF;i++) if ($i=="dev") print $(i+1); exit}')"

# 1. NetworkManager VPN / WireGuard
nm_line="$(
  nmcli -t -f TYPE,NAME,DEVICE connection show --active 2>/dev/null |
    awk -F: '$1=="wireguard" || $1=="vpn" {print; exit}'
)"

if [ -n "$nm_line" ]; then
  IFS=':' read -r type name dev <<<"$nm_line"

  proto="VPN"
  [ "$type" = "wireguard" ] && proto="WG"

  if echo "$name" | grep -Eiq 'amnezia|awg'; then
    proto="AWG"
  fi

  route_note="split / unknown route"
  [ "$dev" = "$default_dev" ] && route_note="default route"

  emit "$proto on" "on" "$proto via NetworkManager
name: $name
device: $dev
route: $route_note"
  exit 0
fi

# 2. AmneziaWG через awg-tools, если есть awg
if command -v awg >/dev/null 2>&1; then
  awg_ifaces="$(awg show interfaces 2>/dev/null)"

  if [ -n "$awg_ifaces" ]; then
    iface="$(echo "$awg_ifaces" | awk '{print $1}')"
    endpoint="$(awg show "$iface" endpoints 2>/dev/null | awk 'NF {print $2; exit}')"

    route_note="split / unknown route"
    [ "$iface" = "$default_dev" ] && route_note="default route"

    emit "AWG on" "on" "AmneziaWG
iface: $iface
endpoint: ${endpoint:-unknown}
route: $route_note"
    exit 0
  fi
fi

# 3. Обычный WireGuard через wg-tools
if command -v wg >/dev/null 2>&1; then
  wg_ifaces="$(wg show interfaces 2>/dev/null)"

  if [ -n "$wg_ifaces" ]; then
    iface="$(echo "$wg_ifaces" | awk '{print $1}')"
    endpoint="$(wg show "$iface" endpoints 2>/dev/null | awk 'NF {print $2; exit}')"

    route_note="split / unknown route"
    [ "$iface" = "$default_dev" ] && route_note="default route"

    emit "WG on" "on" "WireGuard
iface: $iface
endpoint: ${endpoint:-unknown}
route: $route_note"
    exit 0
  fi
fi

# 4. Tailscale
if ip -o link show up 2>/dev/null | awk -F': ' '{print $2}' | cut -d@ -f1 | grep -qx 'tailscale0'; then
  emit "TS on" "on" "Tailscale
iface: tailscale0"
  exit 0
fi

# 5. Fallback: ищем подозрительные VPN-интерфейсы
iface="$(
  ip -o link show up 2>/dev/null |
    awk -F': ' '{print $2}' |
    cut -d@ -f1 |
    grep -Ei '^(awg|amnezia|amn|wg|tun|tap)' |
    head -n1
)"

if [ -n "$iface" ]; then
  proto="VPN"

  case "$iface" in
  awg* | amnezia* | amn*)
    proto="AWG"
    ;;
  wg*)
    proto="WG"
    ;;
  tun* | tap*)
    proto="VPN"
    ;;
  esac

  route_note="split / unknown route"
  [ "$iface" = "$default_dev" ] && route_note="default route"

  emit "$proto on" "on" "$proto detected by interface
iface: $iface
route: $route_note"
  exit 0
fi

emit "vpn off" "off" "No active VPN detected"
