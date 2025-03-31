#!/bin/bash

# Set this to your external monitor name from `xrandr`
EXTERNAL_MONITOR="DP-3"

# Required for GUI commands
export DISPLAY=:0
export XDG_RUNTIME_DIR="/run/user/$(id -u)"

# Check if the monitor is connected
if xrandr | grep -q "$EXTERNAL_MONITOR connected"; then
    echo "External monitor '$EXTERNAL_MONITOR' is connected – enabling fractional scaling"
    gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"
else
    echo "External monitor '$EXTERNAL_MONITOR' is NOT connected – disabling fractional scaling"
    gsettings set org.gnome.mutter experimental-features "[]"
fi

