# https://wiki.archlinux.org/title/Awesome#Autostart

#!/usr/bin/env bash

function run {
  if ! pgrep -f $1 ;
  then
    $@&
  fi
}

run devmon --unmount-on-exit

