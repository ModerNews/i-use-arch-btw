#!/bin/bash
swayidle -w timeout 300 'hyprlock' \
            timeout 360 'sleep 1; hyprctl dispatch dpms off' \
            resume 'hyprctl dispatch dpms on' \
            timeout 600 'systemctl suspend' \
            before-sleep 'hyprlock' & disown
