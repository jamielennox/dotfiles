# vim: set filetype=bash: 

# if you get __git_ps1 not found on fedora 18 do:
# sudo ln -s /usr/share/git-core/contrib/completion/git-prompt.sh  /etc/profile.d/
# or add to .bashrc
# info: https://bugzilla.redhat.com/show_bug.cgi?id=878428

#PS1='\[\033[1;32m\][\u@\h \[\033[31m\]\W\[\033[34m\]$(__git_ps1 " (%s)")\[\033[1;32m\]]\\$\[\033[m\] '
# PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '

export PS1="$ "
export PROMPT_COMMAND=__prompt_command

if [[ "$OSTYPE" == "darwin"* ]]; then
    source "$(brew --prefix kube-ps1)/share/kube-ps1.sh"
fi

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
