#!/bin/bash
set -euo pipefail

engine="$(modelctl engine --format=json | jq -r .name)"

exec "$SNAP/engines/$engine/server" "$@"
