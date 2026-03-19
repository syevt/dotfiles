# alias vim='nvim'
alias vim='nvim +"silent! source .git/session"'
alias svim='nvim -S .git/session.vim'
alias fvim='nvim -o `fzp`'
# alias fzp="fzf --layout reverse --preview='head {}' --preview-window=down --preview 'bat --style=numbers --theme=base16 --color=always {} | head -500'"
alias fzp="rg --files --hidden | fzf --layout reverse --preview='head {}' --preview-window=down --preview 'bat --style=numbers --color=always {} | head -500'"
alias wttr='clear && curl "v2n.wttr.in/Dnipro?lang=ua"'
alias tr='trans :en -speak -no-ansi'
alias notify-send='notify-send -i help-about'
alias batt60='echo 60 | sudo tee /sys/class/power_supply/BAT0/charge_control_end_threshold'
alias batt80='echo 80 | sudo tee /sys/class/power_supply/BAT0/charge_control_end_threshold'
alias batt100='echo 100 | sudo tee /sys/class/power_supply/BAT0/charge_control_end_threshold'

alias tm='tmux -u new -ADs 0'
nd() {
  nix develop "$@" --command zsh
}
