{
  "run-container" = {
    executable = true;
    target = "scripts/run-container";
    text = ''#! /usr/bin/env bash
docker container start $1 && docker exec -it $1 ''${2:-bash}
'';
  };

  "codenv" = {
    executable = true;
    target = "scripts/codenv";
    text = ''#! /usr/bin/env bash
cd $HOME/shells/$1
shift
nix develop -c code "$@"
'';
  };

  "gg" = {
    executable = true;
    target = "scripts/gg";
    text = ''
      #! /usr/bin/env bash
      git checkout "$@"
    '';
  };
}
