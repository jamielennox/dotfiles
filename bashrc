
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [ -d "$DIR/bashrc.d" ]; then
  for file in $DIR/bashrc.d/*.bashrc; do
    source "$file"
  done
fi
