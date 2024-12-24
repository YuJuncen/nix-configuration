{ pkgs, unstable, config, ... } @ ctx:
{
  imports = [
    ./softwares/i3
    ./softwares/rofi
    ./softwares/tmux.nix
    ./softwares/wezterm.nix

    ./xdg.nix
    ./hidpi.nix
    ./dotfiles
  ];
  options = { };
  config = {
    home = {
      username = "hillium";
      homeDirectory = "/home/hillium";
      stateVersion = "24.11";
      sessionVariables = {
        EDITOR = "vim";
        PATH = "$PATH:$HOME/scripts";
      };
      packages = with pkgs; [
        dconf
        feh

        openssl
        unzip
        virt-manager
        xclip
        jq
        gh
        emacs-nox
        file
        jless
        wofi
        lazygit
        nil
        gnupg
        ripgrep

        eog
        seahorse
        gnome-bluetooth
        gpaste
        gnome-terminal

        cider
        calibre
        goldendict-ng
        thunderbird

        pavucontrol
        paprefs

        tdesktop
        localsend
        rofi-gpaste
        flameshot
        vlc
        google-chrome
        gtk-engine-murrine

        firefox
        gdb
        rr

        gtk3
        gtk4

        zoom-us
        feishu
        slack

        ffmpeg
        obs-studio
        wireshark

        yesplaymusic
      ] ++ (with unstable; [
        vivaldi
        nautilus
        zenity
        vscode
        netease-cloud-music-gtk
        gnome-system-monitor
      ]);
      pointerCursor = {
        gtk.enable = true;
        x11.enable = true;
        package = pkgs.yaru-theme;
        name = "Yaru";
        size = 64;
      };
      file = import ./softwares/i3/scripts.nix ctx //
        import ./util-scripts.nix // {
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
        package = pkgs.fluent-icon-theme.override {
          colorVariants = [ "teal" ];
        };
        name = "Fluent-teal-dark";
      };
      theme = {
        package = pkgs.fluent-gtk-theme.override {
          tweaks = [ "square" ];
          themeVariants = [ "teal" ];
        };
        name = "Fluent-teal-Dark";
      };
    };
    xdg.configFile = {
      "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
      "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
      "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
    };
    fonts = {
      fontconfig = {
        enable = true;
      };
    };
    qt = {
      enable = true;
      platformTheme = {
        name = "adwaita";
      };
      style = {
        package = pkgs.adwaita-qt;
        name = "adwaita-dark";
      };
    };


    xsession = {
      enable = true;
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
