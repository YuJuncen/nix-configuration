#! /usr/bin/env bash

set -eu

base="$HOME/shells"

if [ "$*" ] && [ -e "$base/$*" ]; then
    cd "$base/$*"
    coproc nix develop --impure --command code
    exit 0
elif [ "$*" == "Current Env" ]; then
    code
    exit 0
fi

find "$base" -maxdepth 1 -mindepth 1 -print0 | xargs -0 -I% basename % | xargs -I% echo -e '%\0icon\x1ffolder'
echo -e 'Current Env\0icon\x1fcode'