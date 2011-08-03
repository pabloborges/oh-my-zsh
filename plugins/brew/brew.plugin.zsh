alias brews='brew list -1'

# add brew completion function to path
fpath=($ZSH/plugins/brew $fpath)
autoload -U compinit
compinit -i

# update, install outdated and cleanup in one command
function brewup() {
  brew update
  if [[ -n $(brew outdated 2> /dev/null) ]]; then
    brew install `brew outdated`
    brew cleanup
  fi
}
