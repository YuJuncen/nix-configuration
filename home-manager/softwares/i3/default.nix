# Place: home-manager

{ pkgs, lib, colors, unstable, ... }:

let
  common = import ./common.nix;
  workspaces = common.workspaces;
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
      {
        command = "resize set 640 480";
        criteria = {
          window_role = "pop_up";
        };
      }
      {
        command = "resize set 640 480";
        criteria = {
          window_role = "task_dialog";
        };
      }
      {
        command = "floating enable";
        criteria = {
          window_role = "pop_up";
        };
      }
      {
        command = "floating enable";
        criteria = {
          window_role = "task_dialog";
        };
      }
    ];
  };
  m = "Mod1";
  mm = "Mod1+Shift";
  vimConsistent = {
    bindings = {
      "${mm}+h" = "focus left";
      "${mm}+j" = "focus down";
      "${mm}+k" = "focus up";
      "${mm}+l" = "focus right";

      "${mm}+Ctrl+h" = "move left";
      "${mm}+Ctrl+j" = "move down";
      "${mm}+Ctrl+k" = "move up";
      "${mm}+Ctrl+l" = "move right";

      "${mm}+g" = "split h";
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
      "Mod4+Ctrl+q" = "exec dm-tool lock";
      "Mod4+Shift+Ctrl+s" = "exec flameshot gui -p ~/Images/Screenshots";
      "Mod4+Shift+s" = "exec flameshot gui";
      "Mod4+v" = "exec ${pkgs.rofi-gpaste}/bin/rofi-gpaste";
    };
  };
  personalWorkspaceConfig = {
    bindings = with workspaces; {
      "${mm}+c" = "workspace ${c}";
      "${mm}+Ctrl+c" = "move to workspace ${c}; workspace ${c}";
      "${mm}+x" = "workspace ${x}";
      "${mm}+Ctrl+x" = "move to workspace ${x}; workspace ${x}";
      "${mm}+v" = "workspace ${v}";
      "${mm}+Ctrl+v" = "move to workspace ${v}; workspace ${v}";
      "${mm}+1" = "workspace ${ext}";
      "${mm}+2" = "workspace ${misc}";
      "${mm}+z" = "workspace ${virt}";
      "${mm}+Ctrl+z" = "move to workspace ${virt}; workspace ${virt}";
      "${mm}+f" = "floating toggle";
      "${mm}+t" = "sticky toggle";
      "${mm}+Ctrl+f" = "floating enable; move to workspace ${ext}; workspace ${ext}";
      "${mm}+Ctrl+g" = "floating disable; move to workspace ${misc}";
      "${mm}+Return" = "fullscreen toggle";
      "${m}+Return" = "exec --no-startup-id $HOME/scripts/contextual-run";
      "${mm}+q" = "kill";
    };
  };
  startup = [
    {
      command = "${pkgs.flameshot}/bin/flameshot";
      notification = false;
    }
    {
      command = "${pkgs.feh}/bin/feh --bg-fill ~/.background-image";
      notification = false;
    }
    {
      # FIXME: Or goldendict exits with code zero.
      command = "${pkgs.goldendict-ng}/bin/goldendict";
      notification = false;
    }
    {
      command = "systemctl restart --user polybar";
      notification = false;
    }
    {
      command = "dbus-update-activation-environment --all";
      notification = false;
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
    "${m}+space" = "exec --no-startup-id rofi -show drun";
    "${mm}+a" = "exec --no-startup-id rofi -show window";
    "${m}+Shift+space" = "exec --no-startup-id rofi -show run";
    "${m}+m" = "exec --no-startup-id rofi -show playerctl";
    "${m}+p" = "exec --no-startup-id rofi -show controlpanel";
  };
  mergeAll = builtins.foldl' (a: b: a // b) { };
in
{
  xsession.windowManager.i3 = {
    enable = true;

    extraConfig = ''
      ${colorSchema}
      workspace_layout tabbed
      focus_follows_mouse no
      tiling_drag titlebar
      
      for_window [title="Feishu Meetings" instance="^(?!Main_Meeting).*"] floating enable, sticky enable
      for_window [urgent="latest"] focus
    '';
    config = {
      inherit fonts window startup;

      terminal = "kitty";
      keybindings = mergeAll [
        vimConsistent.bindings
        macOSConsistent.bindings
        rofiInsteadOfDMenu
        personalWorkspaceConfig.bindings
      ];
      modes = lib.mkOptionDefault vimConsistent.modes;
      modifier = m;

      floating = {
        criteria = [
          { class = "GoldenDict"; }
          { workspace = "^1:"; }
          { class = "org.gnome.Nautilus"; }
          { instance = "calibre-ebook-viewer"; }
          { class = "Bytedance-feishu"; title = "^(?!Feishu).*"; }
          { class = "SystemCtl"; }
          { instance = "pavucontrol"; }
        ];
        border = 0;
      };

      # We are going to use polybar, disable the default bar.
      bars = lib.mkForce [ ];
    };
  };
}
