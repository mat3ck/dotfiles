#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null
do
    sleep 1
done

# Launch main bar
if type "xrandr"
then
    for monitor in $(xrandr --query | grep " connected" | cut -d" " -f1)
    do
        MONITOR=$monitor polybar --reload main &
    done
else
    polybar --reload main &
fi

echo "polybar launched"

