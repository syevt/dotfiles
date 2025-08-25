#!/usr/bin/env bash

# no longer needed since `niri` does have the appropriate module
# left here just for reference
niri msg --json event-stream | while read -r line; do
    if echo "$line" | jq -e 'has("WindowFocusChanged")' >/dev/null; then
        title=$(niri msg --json focused-window | jq -r '.title // ""')
        # Truncate if too long (optional)
        short_title=$(echo "$title" | cut -c1-80)
        echo "{\"text\": \"$short_title\"}"
    fi
done
