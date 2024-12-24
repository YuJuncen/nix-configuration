{ pkgs, ... }:

{
  imports = [ ];
  options = { };
  config = {
    programs.wezterm = {
      enable = true;
      extraConfig = builtins.readFile ../dotfiles/wezterm.lua;
      package = pkgs.wezterm-master;
    };
  };
}