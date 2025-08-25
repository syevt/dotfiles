#!/usr/bin/env bash

runSegment() {
  # st=$(source "$HOME/.tmux/plugins/tmux-continuum/scripts/continuum_status.sh")
  #
  # with `home manager` `~/.tmux/plugins` is no longer a valid path
  # need to set this explicitly
  # see the `home manager` `tmux` part in `configuration.nix`
  st=$(source "${TMUX_CONTINUUM_PATH}/scripts/continuum_status.sh")
  echo -n ": ${st}"
}
