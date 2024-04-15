#! /usr/bin/env bash

set -eu

title="$(playerctl metadata title || echo "N/A")"
album="$(playerctl metadata album || echo "N/A")"
artist="$(playerctl metadata artist || echo "N/A")"
options=(
    "Pause / Play\0icon\x1fmedia-playback-start"
    "Replay\0icon\x1fmedia-playlist-repeat"
    "Previous\0icon\x1fmedia-seek-backward"
    "Next\0icon\x1fmedia-seek-forward"
    "━━━┫ Now Playing ┣━━━\0nonselectable\x1ftrue\x1fpermanent\x1ftrue"
    "Title ┃ $title\0nonselectable\x1ftrue\x1fpermanent\x1ftrue"
    "Album ┃ $album\0nonselectable\x1ftrue\x1fpermanent\x1ftrue"
    "Artist ┃ $artist\0nonselectable\x1ftrue\x1fpermanent\x1ftrue"
)

success=1
case $* in
    "Pause / Play")  playerctl play-pause ;;
    "Previous") playerctl previous ;;
    "Replay") playerctl position 0 ;;
    "Next") playerctl next;;
    "Quit") exit 0;;
    *) success=0
esac

if [ "$success" == 1 ]; then 
    exit 0
fi

for opt in "${options[@]}"; do
    echo -e $opt
done