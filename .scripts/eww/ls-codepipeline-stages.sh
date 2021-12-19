#!/bin/zsh
buttons=$(
  cat /tmp/aws_eww | \
  jq -r 'map(@text "(button
    :class \"item\" 
    :onclick \"xdg-open \\\"\(.url)\\\" &\" 
    \"\(.status)\t\(.name)\")")[]')

printf '(box 
  :orientation "v" 
  :spacing 5 
  :class "apps" 
  :halign "center" 
  :valign "center" 
  %s)' "$buttons"
