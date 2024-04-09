{ pkgs, ... }:
let workspaces = (import ./common.nix).workspaces;
in
{
  "contextual-run" = {
    executable = true;
    target = "scripts/contextual-run";
    text = ''#! /usr/bin/env bash
get_workspace() {
    ${pkgs.i3}/bin/i3-msg -t get_workspaces | ${pkgs.jq}/bin/jq -r '.[] | select(.focused).name'
}
select=$(cat <<EOF
{ 
    "${workspaces.x}": "kitty",
    "${workspaces.c}": "firefox",
    "${workspaces.v}": "code",
    "${workspaces.virt}": "virt-manager"
}
EOF
)
default_selection="rofi -show drun"
cmd=$(echo "$select" | jq -r --arg ws "$(get_workspace)" --arg default "$default_selection" '.[$ws] // $default')
exec $cmd
'';
  };
}
