export TERM="xterm-256color"
export ZSH=~/.oh-my-zsh

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir vi_mode vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status history root_indicator background_jobs nodenv go_version time)
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
POWERLEVEL9K_RBENV_PROMPT_ALWAYS_SHOW=true
POWERLEVEL9K_RUBY_ICON="\uE791"
POWERLEVEL9K_NODE_ICON="\uE617"
POWERLEVEL9K_JAVA_ICON="\uE738"
POWERLEVEL9K_TIME_ICON="\uF017"
POWERLEVEL9K_NODE_VERSION_FOREGROUND="black"
POWERLEVEL9K_NODENV_FOREGROUND="black"
POWERLEVEL9K_NODENV_BACKGROUND="green"
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='black'
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='green'
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='black'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='magenta'
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='black'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='yellow'
POWERLEVEL9K_VI_INSERT_MODE_STRING=''
POWERLEVEL9K_VI_COMMAND_MODE_STRING='<<<'
POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND='red'
POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND='black'
POWERLEVEL9K_MODE='nerdfont-complete'

export LANG=en_US.UTF-8
export EDITOR='vim'

export FZF_PREVIEW_PREVIEW_BAT_THEME='gruvbox-dark'
export BAT_THEME="gruvbox-dark"

source ~/.bash_aliases
source ~/.tmux/gruvbox-dark.sh

export NODENV_ROOT="$HOME/.nodenv"
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"

# set in the Home Manager `/etc/nixos/hardware-configuration.nix` part
# if you don't use Home Manager, uncomment these lines
# source ~/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme
# source $ZSH/oh-my-zsh.sh
# export FZF_DEFAULT_COMMAND='rg --files'
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# source /usr/share/fzf/key-bindings.zsh
# export FZF_DEFAULT_OPTS='--layout reverse'
#
# git (gitfast), yarn, zsh-autosuggestions goes to `configuration.nix`
# docker-compose is just disabled for the time being
# plugins=(docker-compose git vi-mode yarn zsh-autosuggestions)
