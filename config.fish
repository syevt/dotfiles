# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

# Load Oh My Fish configuration.
source $OMF_PATH/init.fish
# set -g theme_color_scheme base16
# set -g theme_color_scheme zenburn
# set -g theme_color_scheme solarized-dark
# set -g theme_color_scheme gruvbox
# set -g theme_display_ruby yes
set -g theme_display_vi no

if status is-interactive
  set PATH $HOME/.rbenv/bin $PATH
  . (rbenv init - | psub)
end
