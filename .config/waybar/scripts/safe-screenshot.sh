#!/usr/bin/env bash

# Select area with slurp
area=$(slurp)
[ -z "$area" ] && exit 1  # User hit escape or cancelled

# Pipe grim output directly into wl-copy
grim -g "$area" - | wl-copy --type image/png

# Optional notification
notify-send "📸 Screenshot" "Copied to clipboard"

