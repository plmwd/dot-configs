#!/bin/bash

CMD=""
CMD="kitty --config=/home/paulw/.config/kitty/kitty.conf"
[ -n "$1" ] && [ "$1" == "float" ] && CMD="$CMD --class=floating_shell"
[ -n "$1" ] && [ "$1" == "float_portrait" ] && CMD="$CMD --class=floating_shell_portrait"
[ -n "$1" ] && CMD="$CMD ${2:-$1}"

cwd="$( swaymsg -t get_tree | \
  jq '.. | (.nodes? // empty)[] | select(.focused == true).pid? // empty' | \
  xargs pstree -p | grep "\<tmux\>\|\<fish\>\|\<bash\>\|\<zsh\>\|\<sh\>" | \
  grep -o '[0-9]*' | xargs pwdx 2> /dev/null | cut -f2- -d' ' | \
  sort | tail -n 1 | tr -d '\n' )"

CMD="$CMD -d $cwd"

echo $CMD 
swaymsg exec "$CMD"
