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
    "Refresh\0icon\x1refresh"
    "Quit"
    "\0message\x1f$title, $album, $artist"
    # "━━━┫ Now Playing ┣━━━\0nonselectable\x1ftrue\x1fpermanent\x1ftrue"
    # "$title\0nonselectable\x1ftrue\x1fpermanent\x1ftrue\x1ficon\x1fmedia-album-track"
    # "$album\0nonselectable\x1ftrue\x1fpermanent\x1ftrue\x1ficon\x1ffilename-album-amarok"
    # "$artist\0nonselectable\x1ftrue\x1fpermanent\x1ftrue\x1ficon\x1famarok_artist"
)

case $* in
    "Pause / Play")  playerctl play-pause ;;
    "Previous") playerctl previous ;;
    "Replay") playerctl position 0 ;;
    "Next") playerctl next;;
    "Quit") exit 0;;
esac

for opt in "${options[@]}"; do
    echo -e $opt
done
