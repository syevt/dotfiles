#!/bin/bash
# File to save the screenshot
# file="$HOME/Pictures/screenshot_$(date +%Y%m%d_%H%M%S).png"

# Use slurp to select an area and grim to capture it
# area=$(slurp)
# [ -z "$area" ] && exit 1  # cancel if user didn't select

# grim -g "$area" "$file"

# Optionally, copy to clipboard
# wl-copy < "$file"

# Optionally, open in an image viewer
# swayimg "$file"

# Select area with slurp
area=$(slurp)
[ -z "$area" ] && exit 1  # User hit escape or cancelled

# Pipe grim output directly into wl-copy
grim -g "$area" - | wl-copy --type image/png

# Optional notification
notify-send "📸 Screenshot" "Copied to clipboard"

