# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export TERM="xterm-256color"
# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="agnoster"

# ZSH_THEME="powerlevel10k/powerlevel10k"
# ZSH_THEME="powerlevel10k/powerlevel01k"
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir rbenv nodeenv rspec_stats vcs)
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir vi_mode vcs)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs time)
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
# POWERLEVEL9K_NODE_VERSION_BACKGROUND='blue'
# POWERLEVEL9K_RBENV_FOREGROUND='blue'
# POWERLEVEL9K_RBENV_BACKGROUND='yellow'
# POWERLEVEL9K_OS_ICON_BACKGROUND='black'
# POWERLEVEL9K_OS_ICON_FOREGROUND='red'
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

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(docker-compose git vi-mode yarn zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
#
# NVM
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# for lsp
# PATH=”/usr/local/bin:$PATH”

# NODENV
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"

# npx
# source <(npx --shell-auto-fallback zsh)

# export GOPATH=$HOME/go
# export GOENV_ROOT="$HOME/.goenv"
# export PATH="$GOENV_ROOT/bin:$PATH"
# eval "$(goenv init -)"
# export PATH="$GOROOT/bin:$PATH"
# export PATH="$GOPATH/bin:$PATH"
#export PATH="$HOME/.rbenv/bin:$PATH"
#eval "$(rbenv init -)"
#export TERM="xterm-256color-italic"
#export EVERNOTE_DEV_TOKEN=$(cat $HOME/.evernote_dev_token)
#eval $(keychain -q --eval id_rsa)
#export XDG_CONFIG_HOME="/home/syevt"
# export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_DEFAULT_OPTS='--layout reverse'
export FZF_PREVIEW_PREVIEW_BAT_THEME='gruvbox-dark'
source ~/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme
export BAT_THEME="gruvbox-dark"
source ~/.bash_aliases
source ~/.tmux/gruvbox-dark.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source /usr/share/fzf/key-bindings.zsh

[ -f "/home/syevt/.ghcup/env" ] && source "/home/syevt/.ghcup/env" # ghcup-env
