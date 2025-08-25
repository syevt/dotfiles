#!/usr/bin/env bash

runSegment() {
  echo -n $(tmux display-message -p '#S')
}
