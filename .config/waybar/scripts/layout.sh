#!/usr/bin/env bash

LAYOUT=$(cat /tmp/current_layout 2>/dev/null)

case "$LAYOUT" in
  us) echo "🏴󠁧󠁢󠁥󠁮󠁧󠁿" ;;
  ua) echo "🇺🇦" ;;
  *) echo "⌨️" ;;  # fallback
esac
