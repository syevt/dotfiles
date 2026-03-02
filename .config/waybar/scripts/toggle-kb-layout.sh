#!/usr/bin/env bash

LAYOUT_FILE="/tmp/current_layout"
CURRENT=$(cat "$LAYOUT_FILE" 2>/dev/null || echo "🏴󠁧󠁢󠁥󠁮󠁧󠁿")

if [[ "$CURRENT" == "🏴󠁧󠁢󠁥󠁮󠁧󠁿" ]]; then
    NEXT="🇺🇦"
else
    NEXT="🏴󠁧󠁢󠁥󠁮󠁧󠁿"
fi

echo "$NEXT" > "$LAYOUT_FILE"
niri msg action switch-layout 'next'
pkill -RTMIN+8 waybar
