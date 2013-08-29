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
PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '

# local_prefix is not a standard term, just something this uses.
export LOCAL_PREFIX=$HOME/usr

# User specific aliases and functions
export CONFIG_SITE=$HOME/config.site
export CMAKE_PREFIX_PATH=$LOCAL_PREFIX
export CMAKE_INSTALL_PREFIX=$LOCAL_PREFIX
export PKG_CONFIG_PATH=$LOCAL_PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH
export PATH=$LOCAL_PREFIX/bin:$PATH:/var/lib/gems/1.8/bin
export GI_TYPELIB_PATH=$LOCAL_PREFIX/lib/girepository-1.0/:$GI_TYPELIB_PATH
export LD_LIBRARY_PATH=$LOCAL_PREFIX/lib/:$LD_LIBRARY_PATH
export PYTHONPATH=$LOCAL_PREFIX/lib/python2.7/dist-packages/:$LOCAL_PREFIX/lib/python2.7/site-packages/:$PYTHONPATH
export PERL5LIB=$LOCAL_PREFIX/share/perl5:$PERL5LIB
export CSCOPE_EDITOR=gvim
export PSA_ROOT=$LOCAL_PREFIX/share/psa

export EDITOR="/usr/bin/gvim -f"

alias givm='gvim'
alias sl='ls'
alias grpe='grep'


alias g='git'
alias ga='git add'
alias gc='git checkout'
alias gs='git status'
alias gd='git diff'
alias gpr='git pull --rebase'
alias gr='git review'

complete -o default -o nospace -F _git g

function vssh() {
    ssh `sudo ~/virt-addr.py $1`
}

set -o vi

# virsh connect to the qemu:///system by default
export VIRSH_DEFAULT_CONNECT_URI="qemu:///system"

function source_if_exists() {
    [[ -s $1 ]] && source $1
}

source_if_exists "/usr/bin/virtualenvwrapper.sh"
source_if_exists "$HOME/.rvm/scripts/rvm"  # Load RVM into a shell session *as a function*
