#!/bin/sh

# https://wiki.archlinux.org/title/Awesome#Autostart
run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

run udiskie
run noisetorch -i

