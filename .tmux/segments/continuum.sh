#!/bin/bash

runSegment() {
  st=$(source "$HOME/.tmux/plugins/tmux-continuum/scripts/continuum_status.sh")
  echo -n ": ${st}"
}
