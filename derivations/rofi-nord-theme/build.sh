#! /bin/bash

PATH=$PATH:"$busybox/bin"

mkdir -p $out
echo "$COLOR_SCHEMA"
cat "$COLOR_SCHEMA" "$src" > "$out/nord.rasi"