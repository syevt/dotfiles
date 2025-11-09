#!/usr/bin/env bash

# Select an area on the screen
area=$(slurp)
[ -z "$area" ] && exit 1  # exit if canceled

# Take a screenshot of that region and run OCR
# (Assumes Tesseract has both English and Ukrainian language packs)
text=$(grim -g "$area" - | tesseract - - -l eng+ukr 2>/dev/null)

# Trim whitespace
cleaned=$(echo "$text" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | tr -s ' ')

# Copy to clipboard
if [ -n "$cleaned" ]; then
  echo -n "$cleaned" | wl-copy
  notify-send "📋 OCR Result" "Copied to clipboard: $cleaned"
else
  notify-send "⚠️ OCR failed" "No text recognized."
fi
