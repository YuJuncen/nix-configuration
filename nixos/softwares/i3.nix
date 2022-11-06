{ pkgs, lib, ... }:

let
  fonts = {
    names = [ "Noto Serif CJK SC", "Noto Sans CJK SC", "monospace" ];
    size = 10.0;
  };
  window = {
    border = 0;
    titlebar = true;
    commands = [
      {
        command = "title_window_icon on";
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
      h = "resize shrink width 10 px or 10 ppt";
      j = "resize grow height 10 px or 10 ppt";
      k = "resize shrink height 10 px or 10 ppt";
      l = "resize grow width 10 px or 10 ppt";
    };
  };
  macOSConsistent = {
    bindings = {
      "${m}+Ctrl+q" = "exec dm-tool lock";
    };
  };
  startup = [
    {
      command = "feh --bg-fill ~/.background-image";
      always = true;
    }
  ];
in
{
  i3 = {
    enable = true;

    config = {
      inherit fonts, window, startup;
      terminal = "kitty";
      keybindings = lib.mkOptionDefault (
        vimConsistent.bindings // macOSConsistent.bindings
      );
      mods = lib.mkOptionDefault vimConsistent.modes
      
      # We are going to use polybar, disable the default bar.
      bar = lib.mkForce [ ];
    };
  };
}
