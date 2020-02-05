# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

function source_if_exists() {
    [[ -s $1 ]] && source $1
}

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
    source_if_exists "/etc/profile.d/vte.sh"
fi

source_if_exists "$(brew --prefix)/etc/bash_completion"

# if you get __git_ps1 not found on fedora 18 do:
# sudo ln -s /usr/share/git-core/contrib/completion/git-prompt.sh  /etc/profile.d/
# or add to .bashrc
# info: https://bugzilla.redhat.com/show_bug.cgi?id=878428

#PS1='\[\033[1;32m\][\u@\h \[\033[31m\]\W\[\033[34m\]$(__git_ps1 " (%s)")\[\033[1;32m\]]\\$\[\033[m\] '
# PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '

export PS1="$ "
export PROMPT_COMMAND=__prompt_command

# source "$(brew --prefix kube-ps1)/share/kube-ps1.sh"

GIT_PS1_SHOWDIRTYSTATE=TRUE
GIT_PS1_SHOWSTASHSTATE=TRUE
GIT_PS1_SHOWUNTRACKEDFILES=TRUE
GIT_PS1_SHOWUPSTREAM="verbose"

function __prompt_command() {
   local EXIT="$?"             # This needs to be first

   PS1=""
   if [ "$VIRTUAL_ENV" ]
   then
       PS1+="(`basename $VIRTUAL_ENV`)"
   fi

   PS1+="[\u@\h "

   if [ "$EXIT" = "0" ]
   then
       PS1+="\[$(tput setaf 2)\]:)"
   else
       PS1+="\[$(tput setaf 1)\]:("
   fi

   PS1+="\[$(tput sgr0)\] \W"
   PS1+=" "
   PS1+="$(__git_ps1 '(%s)')"
   # PS1+="$(kube_ps1)"

   PS1+="]\$ "

   if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
       # https://gnunn1.github.io/tilix-web/manual/vteconfig/
       PS1="$PS1$(__vte_osc7)"
   fi
}

export EDITOR=`which vim`
export ANSIBLE_NOCOWS=1

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

alias ":q"="exit"

alias k="kubectl"
alias kg="kubectl get"
alias kns="kubens"
alias kctl="kubectl"
alias kctx="kubectx"

complete -o default -o nospace -F _git g

# go back to the root of my git tree
function cdg () {
    TEMP_PWD=`pwd`
    while [ ! -d .git ]
    do
        if [ `pwd` == '/' ]; then
            cd $TEMP_PWD
            return 1
        fi
        cd ..
    done
    OLDPWD=$TEMP_PWD
}

function tp () {
    V=`python -c "import sys; print '%d%d' % (sys.version_info.major, sys.version_info.minor)"`
    tox -e py$V
}

function fixssh() {
    eval $(tmux show-env | sed -n 's/^\(SSH_[^=]*\)=\(.*\)/export \1="\2"/p')
}

set -o vi

# virsh connect to the qemu:///system by default
export VIRSH_DEFAULT_CONNECT_URI="qemu:///system"

if [ "$TERM" == "xterm" ] ; then
  xprop -f _GTK_THEME_VARIANT 8u -set _GTK_THEME_VARIANT "dark" -id `xprop -root | awk '/^_NET_ACTIVE_WINDOW/ {print $5}'`
fi

# source_if_exists "/usr/bin/virtualenvwrapper.sh"
# source_if_exists "$HOME/.rvm/scripts/rvm"  # Load RVM into a shell session *as a function*

# source_if_exists '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc'
# source_if_exists '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc'

# export NVM_DIR="$HOME/.nvm"
# source_if_exists "$(brew --prefix nvm)/nvm.sh"

[ -d $HOME/.local/bin ] && export PATH=$HOME/.local/bin:$PATH

if [ -d "$HOME/.bashrc.d" ]; then
  for file in $HOME/.bashrc.d/*.bashrc; do
    source "$file"
  done
fi

source_if_exists "$(brew --prefix asdf)/asdf.sh"

# if thefuck is installed then setup its alias
command -v thefuck >/dev/null 2>&1 && eval $(thefuck --alias)
command -v asdf >/dev/null 2>&1 && eval "$(asdf exec direnv hook bash)"

# A common place to dump all go building
# export GOPATH=~/go
# export PATH=$GOPATH/bin:$PATH
