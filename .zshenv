export XDG_CONFIG_HOME=$HOME/.config
export XDG_PICTURES_DIR=$HOME/Pictures

export SCRIPTS_DIR=$HOME/.scripts

export EDITOR=nvim
export TERMINAL=kitty
export GOPATH=$HOME/.go
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

secrets="${HOME}/.secrets"
[[ -f "${secrets}" ]] && source $secrets
