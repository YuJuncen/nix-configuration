#! /usr/bin/env bash

set -eu

base="$HOME/shells"

if [ "$*" ] && [ -e "$base/$*" ]; then
    cd "$base/$*"
    nix develop --impure --command code
    exit 0
elif [ "$*" == "Current Env" ]; then
    code
    exit 0
fi

ls "$base" | xargs -I% echo -e '%\0icon\x1ffolder'
echo -e 'Current Env\0icon\x1fcode'