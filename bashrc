# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# if you get __git_ps1 not found on fedora 18 do:
# sudo ln -s /usr/share/git-core/contrib/completion/git-prompt.sh  /etc/profile.d/
# or add to .bashrc
# info: https://bugzilla.redhat.com/show_bug.cgi?id=878428

#PS1='\[\033[1;32m\][\u@\h \[\033[31m\]\W\[\033[34m\]$(__git_ps1 " (%s)")\[\033[1;32m\]]\\$\[\033[m\] '
# PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '

export PS1="$ "
export PROMPT_COMMAND=__prompt_command

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
   PS1+="$(__git_ps1 ' (%s)')"

   PS1+="]\$ "
}


# # local_prefix is not a standard term, just something this uses.
# export LOCAL_PREFIX=$HOME/usr
#
# # User specific aliases and functions
# export CONFIG_SITE=$HOME/config.site
# export CMAKE_PREFIX_PATH=$LOCAL_PREFIX
# export CMAKE_INSTALL_PREFIX=$LOCAL_PREFIX
# export PKG_CONFIG_PATH=$LOCAL_PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH
# export PATH=$LOCAL_PREFIX/bin:$PATH:/var/lib/gems/1.8/bin
# export GI_TYPELIB_PATH=$LOCAL_PREFIX/lib/girepository-1.0/:$GI_TYPELIB_PATH
# export LD_LIBRARY_PATH=$LOCAL_PREFIX/lib/:$LD_LIBRARY_PATH
# export PERL5LIB=$LOCAL_PREFIX/share/perl5:$PERL5LIB
# export CSCOPE_EDITOR=gvim
# export PSA_ROOT=$LOCAL_PREFIX/share/psa

export EDITOR="/usr/bin/vim"
export ANSIBLE_NOCOWS=1

alias givm='gvim'
alias gvmi='gvim'
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

function source_if_exists() {
    [[ -s $1 ]] && source $1
}

if [ "$TERM" == "xterm" ] ; then
  xprop -f _GTK_THEME_VARIANT 8u -set _GTK_THEME_VARIANT "dark" -id `xprop -root | awk '/^_NET_ACTIVE_WINDOW/ {print $5}'`
fi

source_if_exists "/usr/bin/virtualenvwrapper.sh"
source_if_exists "$HOME/.rvm/scripts/rvm"  # Load RVM into a shell session *as a function*

[ -d $HOME/.local/bin ] && export PATH=$HOME/.local/bin:$PATH

# if thefuck is installed then setup its alias
command -v thefuck >/dev/null 2>&1 && eval $(thefuck --alias)
