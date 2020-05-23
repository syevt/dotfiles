# put this to $ZSH_CUSTOM/<any-name>.zsh
# and set in .zshrc plugins(... zsh-autosuggestions)
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=40
bindkey '^ ' autosuggest-accept
d='dirs -v | head -10'
alias -g G='| grep -i'
alias -g F='| fzf'
