#!/bin/bash

# Desired layout index (0 = Dvorak, 1 = Ukrainian)
LAYOUT_INDEX="$1"

# Get the first non-virtual keyboard device
KEYBOARD=$(hyprctl devices | awk '
  $1 == "Name:" { name = substr($0, index($0,$2)) }
  $1 == "Type:" && $2 == "keyboard" {
    print name
    exit
  }
')

# Fallback if nothing is found
if [ -z "$KEYBOARD" ]; then
  echo "No keyboard found!" >&2
  exit 1
fi

# Run the layout switch
hyprctl switchxkblayout "$KEYBOARD" "$LAYOUT_INDEX"
