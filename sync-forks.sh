#!/usr/bin/env bash
set -euo pipefail

gh repo list stevelerner --fork --limit 1000 --json nameWithOwner --jq '.[].nameWithOwner' |
while read -r repo; do
  echo "Syncing $repo..."
  if ! gh repo sync "$repo"; then
    echo "  FAILED: $repo (likely diverged — needs manual merge)" >&2
  fi
done
