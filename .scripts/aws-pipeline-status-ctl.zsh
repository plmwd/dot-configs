#!/bin/zsh

pipe_send=/tmp/awspipe_server
pipe=/tmp/awspipe_client

cmd=$1

case $cmd in
  next | refresh | toggle | eww)
    echo $cmd
    echo $cmd >$pipe_send
    ;;
  *)
    echo "Unknown command '$1'"
    ;;
esac

case $cmd in
  eww)
    cat /tmp/aws_eww
    ;;
  *)
    ;;
esac
