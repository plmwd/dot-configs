export XDG_CONFIG_HOME=$HOME/.config
export XDG_PICTURES_DIR=$HOME/Pictures

export SCRIPTS_DIR=$HOME/.scripts

export EDITOR=nvim
export TERMINAL=kitty
export GOPATH=$HOME/.go
. "$HOME/.cargo/env"

secrets="${HOME}/.secrets.zsh"
[[ -f "${secrets}" ]] && source $secrets
