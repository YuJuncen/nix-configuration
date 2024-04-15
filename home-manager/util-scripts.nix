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
if [ -f env-init ]; then . env-init; fi
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

  "ggpr" = {
    executable = true;
    target = "scripts/ggpr";
    text = ''
      #! /usr/bin/env fish
      set res (gh pr list --author "@me" | fzf | awk '{print $1}')
      if [ "$res" ]
          gh pr checkout "$res"
      end
    '';
  };

  "ggcp" = {
    executable = true;
    target = "scripts/ggcp";
    text = ''
      #! /usr/bin/env fish
      set v $argv[1]
      set res (gh pr list --assignee 'YuJuncen' -l "type/cherry-pick-for-release-$v" | fzf | awk '{print $1}')
      if [ "$res" ]
          gh pr checkout "$res"
      end
    '';
  };
}
