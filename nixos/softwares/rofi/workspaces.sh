#! /usr/bin/env bash

set -eu

base="$HOME/shells"

if [ "$*" ] && [ -e "$base/$*" ]; then
    cd "$base/$*"
    nix develop --command code
    exit 0
fi

ls "$base" | xargs -I% echo -e '%\0icon\x1fcode'