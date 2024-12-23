{ ... }:

{
  imports = [ ];
  options = { };
  config = {
    programs.wezterm = {
      enable = true;
      enableFishIntegration = true;
      extraConfig = builtins.readFile ../dotfiles/wezterm/wezterm.lua;
    };
  };
}