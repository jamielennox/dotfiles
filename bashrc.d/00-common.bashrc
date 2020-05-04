# vim: set filetype=bash:

function source_if_exists() {
    [[ -s $1 ]] && source $1
}

function path_if_exists() {
    [[ -d $1 ]] && export PATH=$1:$PATH
}


path_if_exists "$HOME/.local/bin"
