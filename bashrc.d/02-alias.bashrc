alias sl='ls'
alias grpe='grep'
alias exti='exit'

alias g='git'
alias ga='git add'
alias gc='git checkout'
alias gs='git status'
alias sg='git status'
alias gd='git diff'
alias gpr='git pull --rebase'
alias gr='git review'
alias grc='git rebase --continue'

alias pttr='python -m testtools.run'
alias pttd='python -m testtools.run discover'

alias k="kubectl"
alias kg="kubectl get"
alias kns="kubens"
alias kctl="kubectl"
alias kctx="kubectx"

complete -o default -o nospace -F _git g
