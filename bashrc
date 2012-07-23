# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

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
export CSCOPE_EDITOR=gvim
export EDITOR="gvim -f"

alias givm='gvim'
alias sl='ls'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
