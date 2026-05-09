#!/usr/bin/env bash

repo="$HOME/nix-config"

if [ ! -d "$repo/.git" ]; then
  echo '{"text":"NIX no repo","class":"critical","tooltip":"~/nix-config is not a git repo"}'
  exit 0
fi

dirty=""
ahead=""

git -C "$repo" diff --quiet || dirty="1"
git -C "$repo" diff --cached --quiet || dirty="1"

branch="$(git -C "$repo" branch --show-current 2>/dev/null)"
[ -z "$branch" ] && branch="main"

if git -C "$repo" rev-parse --abbrev-ref --symbolic-full-name @{u} >/dev/null 2>&1; then
  ahead_count="$(git -C "$repo" rev-list --count @{u}..HEAD 2>/dev/null)"
  [ "$ahead_count" != "0" ] && ahead="1"
fi

if [ -n "$dirty" ]; then
  echo "{\"text\":\"NIX dirty\",\"class\":\"dirty\",\"tooltip\":\"~/nix-config has uncommitted changes\"}"
elif [ -n "$ahead" ]; then
  echo "{\"text\":\"NIX push\",\"class\":\"ahead\",\"tooltip\":\"branch $branch has unpushed commits\"}"
else
  echo "{\"text\":\"NIX clean\",\"class\":\"clean\",\"tooltip\":\"~/nix-config clean on $branch\"}"
fi
