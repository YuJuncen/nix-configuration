{ home-manager, pkgs, unstable, hyprland-flake, ... } @ ctx:
{
  home-manager.extraSpecialArgs = { inherit unstable; };
  home-manager.users.hillium =
    {
      home = {
        stateVersion = "23.05";
        sessionVariables = {
          EDITOR = "vim";
          PATH = "$PATH:$HOME/.cargo/bin:$HOME/scripts";
        };
        packages = with pkgs; [
          dconf
          feh

          firefox
          openssl
          unzip
          virt-manager
          jq
          gh

          flameshot-hyprland
          clipmenu
          xclip

          # Because Lark doesn't support Firefox...
          google-chrome
          zoom-us

          gnome.nautilus
          gnome.eog
          gnome.seahorse
          gnome.gnome-bluetooth
          gnome.gnome-weather
          gtk4

          cider
          calibre
          thunderbird

          tdesktop

          emacs-nox

          pavucontrol
          paprefs

          file
          jless
          clash-verge
          wofi
          lazygit
        ] ++ (with unstable; [
          vscode
          goldendict-ng
        ]);
        pointerCursor = {
          gtk.enable = true;
          x11.enable = true;
          package = pkgs.yaru-theme;
          name = "Yaru";
        };
        file = import ./softwares/i3/scripts.nix ctx //
          import ./util-scripts.nix //
          import ./softwares/hyprland/scripts.nix ctx //
          import ../shells/nixos-files.nix // {
            electron-wayland = {
              target = ".config/electron25-flags.conf";
              text = ''
--enable-features=WaylandWindowDecorations
--ozone-platform-hint=auto
--enable-wayland-ime
              '';
            };
          };
      };


      xsession = {
        windowManager.i3 = import ./softwares/i3 ctx;
        numlock = { enable = true; };
        enable = true;
      };

      programs.waybar =
        {
          enable = true;
          systemd.enable = true;
          package = (pkgs.waybar.override {
            swaySupport = false;
          }).overrideAttrs (oldAttrs: rec {
            version = "e30fba0b8f875c7f35e3173be2b9f6f3ffe3641e";
            src = pkgs.fetchFromGitHub {
              owner = "Alexays";
              repo = "Waybar";
              rev = version;
              sha256 = "sha256-9LJDA+zrHF9Mn8+W9iUw50LvO+xdT7/l80KdltPrnDo=";
            };
            buildInputs = oldAttrs.buildInputs ++ [ pkgs.wayland-protocols pkgs.libappindicator-gtk3 pkgs.libinput pkgs.jack2 ];
            mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" "-Dcava=disabled" ];
          });
        };

      programs.rofi = {
        enable = true;
        font = "Noto Serif CJK SC 24";
        theme = "${pkgs.rofi-nord-theme}/nord.rasi";
        plugins = with pkgs; [ rofi-calc rofi-pulse-select rofi-power-menu ];
        package = pkgs.rofi-wayland;
        extraConfig = {
          show-icons = true;
          sort = true;
          terminal = "${pkgs.kitty}/bin/kitty";
          modes = "drun,run,ssh,calc,ciderctl:${./softwares/rofi/ciderctl.sh}";
        };
      };

      i18n.inputMethod = {
        enabled = "fcitx5";
        fcitx5.addons = with pkgs; 
          [ fcitx5-gtk fcitx5-chinese-addons libsForQt5.fcitx5-qt ];
      };

      programs.kitty = {
        enable = true;
        font = {
          package = pkgs.ibm-plex;
          name = "IBM Plex Mono";
        };
        settings = {
          scrollback_lines = 10000;
          enabled_layouts = "grid,tall,stack";
          shell_integration = "enabled";
        };
      };

      gtk = {
        enable = true;
        iconTheme = {
          package = pkgs.tela-icon-theme;
          name = "Tela";
        };
        theme = {
          package = pkgs.mono-gtk-theme;
          name = "MonoTheme";
        };
        font = {
          package = pkgs.noto-fonts-cjk;
          name = "Noto Sans CJK SC";
        };
      };

      fonts.fontconfig.enable = true;

      qt = {
        enable = true;
        platformTheme = "gnome";
        style = {
          package = pkgs.adwaita-qt;
          name = "adwaita-dark";
        };
      };

      services = {
        polybar = import ./softwares/polybar ctx;
        dunst = import ./softwares/dunst.nix ctx;
      };
    };
}
