{ pkgs, unstable, ... }:
{
  "contextual-run" = {
    executable = true;
    target = "scripts/hypr-contextual-run";
    text = ''#! /usr/bin/env bash
get_workspace() {
    ${unstable.hyprland}/bin/hyprctl activeworkspace -j | ${pkgs.jq}/bin/jq -r '.name'
}
select=$(cat <<EOF
{ 
    "Terminal": "kitty",
    "Browsers": "${pkgs.gtk3}/bin/gtk-launch firefox",
    "1": "${pkgs.gtk3}/bin/gtk-launch code",
    "2": "${pkgs.gtk3}/bin/gtk-launch google-chrome",
    "10": "${pkgs.gtk3}/bin/gtk-launch virt-manager"
}
EOF
)
default_selection="wofi --show drun"
cmd=$(echo "$select" | jq -r --arg ws "$(get_workspace)" --arg default "$default_selection" '.[$ws] // $default')
exec $cmd
'';
  };
}