{ home-manager, pkgs, ... } @ ctx:
{
  home-manager.users.hillium = {
    home = {
      stateVersion = "22.05";
      sessionVariables = {
        EDITOR = "vim";
        PATH = "$PATH:$HOME/.cargo/bin";
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

        cider
        calibre
        goldendict
        thunderbird
      ];
      pointerCursor = {
        gtk.enable = true;
        x11.enable = true;
        package = pkgs.yaru-theme;
        name = "Yaru";
      };
      file = import ./nixos/softwares/i3/scripts.nix ctx;
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
      font = "serif 24";
      theme = "${pkgs.rofi-nord-theme}/nord.rasi";
      plugins = with pkgs; [rofi-calc rofi-pulse-select rofi-power-menu];
      extraConfig = {
        show-icons = true;
        sort = true;
        terminal = "${pkgs.kitty}/bin/kitty";
        modes = "window,drun,run,ssh,calc,ciderctl:${./softwares/rofi/ciderctl.sh}";
      };
    };

    i18n.inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [ fcitx5-gtk fcitx5-chinese-addons ];
    };

    gtk = {
      enable = true;
      iconTheme = {
        package = pkgs.tela-icon-theme;
        name = "Tela";
      };
      theme = {
        package = pkgs.mono-gtk-theme;
        name = "MonoThemeDark";
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
