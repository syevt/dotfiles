# alias rc='rails c'
# alias rtc='RAILS_ENV=test rails c'
# alias rs='rails s'
# alias rg='rails g'
# alias rr='rails routes'
# alias rnb='rails new -d postgresql -T'
# alias rmg='rails db:migrate'
# alias rmgv0='rails db:migrate VERSION=0'
# alias rtmg='RAILS_ENV=test rails db:migrate'
# alias rtmgv0='RAILS_ENV=test rails db:migrate VERSION=0'
# alias geeknote='python2 ~/.local/bin/geeknote'
alias vim='nvim'
alias svim='nvim -S .git/Session.vim'
alias fvim='nvim -o `fzp`'
# alias fzp="fzf --layout reverse --preview='head {}' --preview-window=down --preview 'bat --style=numbers --theme=base16 --color=always {} | head -500'"
alias fzp="rg --files --hidden | fzf --layout reverse --preview='head {}' --preview-window=down --preview 'bat --style=numbers --color=always {} | head -500'"
alias geeknote='/usr/local/bin/geeknote'
alias wttr='curl "v2.wttr.in/Dnipro?lang=uk"'

# alias tmux='tmux -2'
alias mux='tmuxinator'
# alias tmux='TERM=screen-256-color-bce tmux'
alias tm='tmux -u new -ADs 0'

# browsers
alias gcs='google-chrome-stable'
alias gcu='google-chrome-unstable --auto-open-devtools-for-tabs'
alias ff='firefox'
