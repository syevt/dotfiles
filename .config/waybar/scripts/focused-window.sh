#!/bin/bash
# niri msg --json event-stream | while read -r line; do
    # if echo "$line" | jq -e 'has("WindowFocusChanged")' > /dev/null; then
        # title=$(niri msg --json focused-window | jq -r '.title // \"\"')
        # echo "$title"
    # fi
# done

# niri msg --json event-stream | while read -r line; do
    # if echo "$line" | jq -e 'has("WindowFocusChanged")' > /dev/null; then
        # title=$(niri msg focused-window 2>/dev/null)
        # # In case there's no title (maybe no window focused), fallback to empty
        # echo "{\"text\": \"${title:-}\"}"
    # fi
# done

# niri msg --json event-stream | while read -r line; do
    # if echo "$line" | jq -e 'has("WindowFocusChanged")' > /dev/null; then
        # title=$(niri msg focused-window --json | jq -r '.title // empty')
        # # Output empty string if no title
        # echo "{\"text\": \"${title}\"}"
    # fi
# done

# niri msg --json event-stream | while read -r line; do
    # id=$(echo "$line" | jq -r '.WindowFocusChanged.id // empty')
    # if [[ -n "$id" ]]; then
        # echo "{\"text\": \"🪟 $id\"}"
    # fi
# done

niri msg --json event-stream | while read -r line; do
    if echo "$line" | jq -e 'has("WindowFocusChanged")' >/dev/null; then
        title=$(niri msg --json focused-window | jq -r '.title // ""')
        # Truncate if too long (optional)
        short_title=$(echo "$title" | cut -c1-80)
        echo "{\"text\": \"$short_title\"}"
    fi
done
