#!/usr/bin/env bash

state=/tmp/niri-focused
: > "$state"   # create/clear file

niri msg --json event-stream | while read -r line; do
  case "$line" in
    *WindowFocusChanged*)
      echo "$line"
      if [[ "$line" == *'"id":null'* ]]; then
        echo "0" > "$state"
      else
        echo "1" > "$state"
      fi
      pkill -SIGRTMIN+8 waybar
      ;;
  esac
done
