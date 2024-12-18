#! /usr/bin/env bash

set -eu

options='[
    {
        "show": "Network Control",
        "icon": "network-wireless",
        "cmd": [ "kitty", "--title", "Network Control", "--class", "SystemCtl", "--detach", "nmtui" ]
    },
    {
        "show": "Volume",
        "icon": "multimedia-volume-control",
        "cmd": [ "pavucontrol" ]
    },
    {
        "show": "Bluetooth",
        "icon": "bluetooth-active",
        "cmd": [ "kitty", "--title", "Bluetooth Control", "--class", "SystemCtl", "--detach", "bluetuith" ]
    },
    {
        "show": "Shutdown",
        "icon": "xfsm-shutdown",
        "cmd": [ "bash", "-c", "zenity --question --title \"\" --icon \"xfsm-shutdown\" --text \"Shutdown now?\" && systemctl poweroff" ]
    },
    {
        "show": "Reboot",
        "icon": "xfsm-reboot",
        "cmd": [ "bash", "-c", "zenity --question --title \"\" --icon \"xfsm-reboot\" --text \"Reboot now?\" && systemctl reboot" ]
    }
]'

@jq() {
    echo "$options" | jq "$@"
}

if [ "$*" ]; then
    item="$*"
    query="$(@jq -r --arg i "$item" '.[] | select(.show | startswith($i)) | .cmd | @sh')"
    if [ "$query" ] && [ "$(echo "$query" | wc -l)" -eq 1 ]; then
        echo "coproc $query" | bash 
        exit 0
    fi
fi

@jq -r '.[] | "\(.show)\u0000icon\u001f\(.icon)"'
