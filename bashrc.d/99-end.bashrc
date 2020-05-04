# vim: set filetype=bash: 

export ANSIBLE_NOCOWS=1
export EDITOR=`which vim`

command -v thefuck >/dev/null 2>&1 && eval $(thefuck --alias)
command -v asdf >/dev/null 2>&1 && eval "$(asdf exec direnv hook bash)"

set -o vi

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

