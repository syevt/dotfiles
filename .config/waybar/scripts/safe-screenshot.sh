#!/usr/bin/env bash

# Select area with slurp
area=$(slurp -d)
[ -z "$area" ] && exit 1  # User hit escape or cancelled

# Pipe grim output directly into wl-copy
# grim -g "$area" - | wl-copy --type image/png
grim -g "$area" - | satty -f -
