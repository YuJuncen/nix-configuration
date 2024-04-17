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
    "$title\0nonselectable\x1ftrue\x1fpermanent\x1ftrue\x1ficon\x1fmedia-album-track"
    "$album\0nonselectable\x1ftrue\x1fpermanent\x1ftrue\x1ficon\x1ffilename-album-amarok"
    "$artist\0nonselectable\x1ftrue\x1fpermanent\x1ftrue\x1ficon\x1famarok_artist"
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