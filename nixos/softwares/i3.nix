# Place: home-manager

{ pkgs, lib, colors, ... }:

let
  fonts = {
    names = [ "Noto Serif CJK SC" "Noto Sans CJK SC" "monospace" ];
    style = "Bold";
    size = 10.0;
  };
  window = {
    border = 2;
    titlebar = true;
    commands = [
      {
        command = "title_window_icon off";
        criteria = {
          all = true;
        };
      }
    ];
  };
  # Super as mod.
  m = "Mod4";
  vimConsistent = {
    bindings = {
      "${m}+h" = "focus left";
      "${m}+j" = "focus down";
      "${m}+k" = "focus up";
      "${m}+l" = "focus right";

      "${m}+Shift+h" = "move left";
      "${m}+Shift+j" = "move down";
      "${m}+Shift+k" = "move up";
      "${m}+Shift+l" = "move right";

      "${m}+g" = "split h";
    };
    modes.resize = {
      h = "resize shrink width 10 px";
      j = "resize grow height 10 px";
      k = "resize shrink height 10 px";
      l = "resize grow width 10 px";
    };
  };
  macOSConsistent = {
    bindings = {
      "${m}+Ctrl+q" = "exec dm-tool lock";
    };
  };
  startup = [
    {
      command = "${pkgs.feh}/bin/feh --bg-fill ~/.background-image";
    }
  ];
  colorSchema = with colors; ''
    #                       Background          Border              Text     Indictor           Child Boarder 
    client.focused          ${primary-16}       ${primary}          ${white} ${secondary}       ${primary}
    client.focused_inactive ${primary-dim}      ${primary-dimmer}   ${white} ${secondary}       ${primary-dimmer}
    client.unfocused        ${background}       ${background}       ${white} ${background}      ${background}
    client.urgent           ${alert}            ${background}       ${white} ${alert}           ${alert} 
  '';
  rofiInsteadOfDMenu = {
    "${m}+d" = "exec --no-startup-id rofi -show drun";
    "${m}+Shift+d" = "exec --no-startup-id rofi -show run";
  };
  mergeAll = builtins.foldl' (a: b: a // b) { };
in
{
  enable = true;

  extraConfig = "${colorSchema}";
  config = {
    inherit fonts window startup;

    terminal = "kitty";
    keybindings = lib.mkOptionDefault (mergeAll [
      vimConsistent.bindings
      macOSConsistent.bindings
      rofiInsteadOfDMenu
    ]);
    modes = lib.mkOptionDefault vimConsistent.modes;
    modifier = m;

    # We are going to use polybar, disable the default bar.
    bars = lib.mkForce [ ];
  };
}
