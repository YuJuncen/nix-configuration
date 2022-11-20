#! /usr/bin/env bash
api=http://localhost:9000/api/playback
options=(
    "Pause / Play\0icon\x1fmedia-playback-start"
    "Replay\0icon\x1fmedia-playlist-repeat"
    "Previous\0icon\x1fmedia-seek-backward"
    "Next\0icon\x1fmedia-seek-forward"
    Quit
)
playctl() {
    curl -Ls "$api/$1" >/dev/null
}

success=1
case $* in
    "Pause / Play")  playctl playpause;;
    "Previous") playctl previous;;
    "Replay") playctl next && playctl previous;;
    "Next") playctl next;;
    "Quit") exit 0;;
    *) success=0
esac

if [ "$success" == 1 ]; then 
    exit 0
fi

for opt in "${options[@]}"; do
    echo -e $opt
done