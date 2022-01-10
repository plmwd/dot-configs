#!/bin/zsh
state=$(aws-pipeline-status-ctl.zsh eww)
buttons=$(
  echo $state | \
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
