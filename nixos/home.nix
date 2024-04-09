{ pkgs, unstable, ... } @ ctx:
{
  imports = [
    ./softwares/i3
  ];
  options = { };
  config = {
    home = {
      username = "hillium";
      homeDirectory = "/home/hillium";
      stateVersion = "23.11";
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

        grim
        xclip
        cliphist
        wlrctl

        # Because Lark doesn't support Firefox...
        google-chrome
        zoom-us

        gnome.nautilus
        gnome.eog
        gnome.seahorse
        gnome.gnome-bluetooth
        gnome.gnome-weather
        gnome.gpaste
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
        wofi
        lazygit
        nil
        flameshot
        openssl

        ripgrep
        localsend
        gnupg

        rofi-gpaste
      ] ++ (with unstable; [
        vscode
        yesplaymusic
        goldendict-ng
        netease-cloud-music-gtk
      ]);
      pointerCursor = {
        gtk.enable = true;
        x11.enable = true;
        package = pkgs.yaru-theme;
        name = "Yaru";
      };
      file = import ./softwares/i3/scripts.nix ctx //
        import ./util-scripts.nix //
        import ../shells/nixos-files.nix ctx // {
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

    # wayland.windowManager.hyprland = {
    #   enable = true;
    #   extraConfig = import ./softwares/hyprland/config.nix ctx;
    # };

    i18n.inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs;
        [ fcitx5-nord fcitx5-rime fcitx5-gtk fcitx5-chinese-addons libsForQt5.fcitx5-qt ];
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
        name = "Noto Sans CJK SC";
        package = pkgs.noto-fonts;
      };
    };
    fonts = {
      fontconfig = {
        enable = true;
      };
    };
    qt = {
      enable = true;
      platformTheme = "gnome";
      style = {
        package = pkgs.adwaita-qt;
        name = "adwaita";
      };
    };

    xresources.extraConfig = ''
      Xft.dpi: 192
    '';

    xsession = {
      enable = true;
      initExtra = ''
        export QT_IM_MODULE=fcitx
      '';
    };

    services = {
      polybar = import ./softwares/polybar ctx;
      dunst = import ./softwares/dunst.nix ctx;
      mpd = {
        enable = true;
        musicDirectory = "~/Music";
      };
      mpd-mpris.enable = true;
      playerctld.enable = true;
      gammastep = {
        # it seems it cannot modify the gamma now.
        enable = false;
        provider = "geoclue2";
      };
    };
  };
}
