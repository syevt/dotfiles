# alias vim='nvim'
alias vim='nvim +"silent! source .git/session"'
alias svim='nvim -S .git/session.vim'
alias fvim='nvim -o `fzp`'
# alias fzp="fzf --layout reverse --preview='head {}' --preview-window=down --preview 'bat --style=numbers --theme=base16 --color=always {} | head -500'"
alias fzp="rg --files --hidden | fzf --layout reverse --preview='head {}' --preview-window=down --preview 'bat --style=numbers --color=always {} | head -500'"
alias wttr='clear && curl "v2.wttr.in/Dnipro?lang=uk"'
alias tr='trans :en -speak -no-ansi'

alias tm='tmux -u new -ADs 0'
nd() {
  nix develop "$@" --command zsh
}
