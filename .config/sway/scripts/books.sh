#!/bin/zsh

books=$(fd -L -t f -e pdf . $HOME/Books)
choice=$(echo $books | rofi -i -dmenu)
[[ ! -z "$choice" ]] && zathura $choice &

