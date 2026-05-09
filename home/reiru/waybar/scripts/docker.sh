#!/usr/bin/env bash

if ! command -v docker >/dev/null 2>&1; then
  echo '{"text":"d no","class":"off","tooltip":"docker command not found"}'
  exit 0
fi

if ! docker info >/dev/null 2>&1; then
  echo '{"text":"d off","class":"off","tooltip":"docker daemon unavailable"}'
  exit 0
fi

running="$(docker ps -q 2>/dev/null | wc -l | tr -d ' ')"
total="$(docker ps -aq 2>/dev/null | wc -l | tr -d ' ')"

echo "{\"text\":\"d $running/$total\",\"class\":\"ok\",\"tooltip\":\"Docker running: $running / total: $total\"}"
