{ home-manager, pkgs, ... } @ ctx:
{
  home-manager.users.hillium = {
    home = {
      stateVersion = "22.05";
      sessionVariables = {
        EDITOR = "vim";
        PATH = "$PATH:$HOME/.cargo/bin:$HOME/scripts";
      };
      packages = with pkgs; [
        dconf
        feh

        firefox
        vscode
        openssl
        unzip
        virt-manager
        jq
        gh

        flameshot
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
        goldendict
        thunderbird

        tdesktop

        emacs-nox

        pavucontrol
        paprefs
      ];
      pointerCursor = {
        gtk.enable = true;
        x11.enable = true;
        package = pkgs.yaru-theme;
        name = "Yaru";
      };
      file = import ./softwares/i3/scripts.nix ctx //
        import ./util-scripts.nix //
        import ../shells/nixos-files.nix;
    };


    xsession = {
      windowManager.i3 = import ./softwares/i3 ctx;
      numlock = { enable = true; };
      enable = true;
    };

    xresources.extraConfig = ''
      Xft.dpi: 192
    '';

    programs.rofi = {
      enable = true;
      font = "Noto Serif CJK SC 24";
      theme = "${pkgs.rofi-nord-theme}/nord.rasi";
      plugins = with pkgs; [ rofi-calc rofi-pulse-select rofi-power-menu ];
      extraConfig = {
        show-icons = true;
        sort = true;
        terminal = "${pkgs.kitty}/bin/kitty";
        modes = "window,drun,run,ssh,calc,ciderctl:${./softwares/rofi/ciderctl.sh}";
      };
    };

    i18n.inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [ fcitx5-gtk fcitx5-chinese-addons libsForQt5.fcitx5-qt  ];
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
