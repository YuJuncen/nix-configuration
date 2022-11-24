{
    "run-container" = {
        executable = true;
        target = "scripts/run-container";
        text = ''#! /bin/usr/env bash
docker container start $1 && docker exec -it $1 ${2:-bash}
'';
    };

    "codenv" = {
        executable = true;
        target = "scripts/codenv";
        text = ''#! /bin/usr/env bash
nix-shell -I nixpkgs-unstable=channel:nixpkgs-unstable "$HOME/shells/$1.nix" --command "code $2"
''
    }
}