# vim: set filetype=bash: 

function source_if_exists() {
    [[ -s $1 ]] && source $1
}

[ -d $HOME/.local/bin ] && export PATH=$HOME/.local/bin:$PATH
