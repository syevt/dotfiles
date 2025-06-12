#!/bin/bash

mapfile -t lines < <(
  niri msg --json windows |
    jq -r '.[] | [.id, .title] | @tsv' |
    while IFS=$'\t' read -r id title; do
      echo "$id|||$title"
    done
)

# Show only titles in fuzzel
titles=$(printf '%s\n' "${lines[@]}" | cut -d '|' -f4-)
choice=$(echo "$titles" | fuzzel --dmenu -l 10)

# Exit if nothing selected
[ -z "$choice" ] && exit

# Find matching ID
id=$(printf '%s\n' "${lines[@]}" | grep "|||$choice$" | cut -d '|' -f1)

# Focus the window
niri msg action focus-window --id "$id"
