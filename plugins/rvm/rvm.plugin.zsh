# add rvm completion function to path
fpath=($ZSH/plugins/rvm $fpath)
autoload -U compinit
compinit -i
