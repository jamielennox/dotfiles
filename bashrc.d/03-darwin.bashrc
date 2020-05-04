# vim: set filetype=bash:

if [[ "$OSTYPE" == "darwin"* ]]; then

    source_if_exists "$(brew --prefix)/etc/bash_completion"
    source_if_exists "$(brew --prefix)/etc/profile.d/bash_completion.sh"
    source_if_exists "$(brew --prefix asdf)/asdf.sh"

# source_if_exists '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc'
# source_if_exists '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc'

# export NVM_DIR="$HOME/.nvm"
# source_if_exists "$(brew --prefix nvm)/nvm.sh"

fi
