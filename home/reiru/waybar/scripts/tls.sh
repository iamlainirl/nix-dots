#!/usr/bin/env bash

if curl -4 -fsSI --max-time 8 https://example.com >/dev/null 2>&1; then
  echo '{"text":"tls ok","class":"ok","tooltip":"HTTPS handshake works"}'
else
  echo '{"text":"tls dead","class":"critical","tooltip":"HTTPS handshake failed"}'
fi
