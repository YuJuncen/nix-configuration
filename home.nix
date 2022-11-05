{ home-manager, pkgs,... } :
{
home-manager.users.hillium = {
    home.stateVersion = "22.05";

    home.packages = with pkgs; [
       cider 
       dconf
       gnome.seahorse
       feh
    ];

    programs.rofi = {
        enable = true;
        font = "serif 24";
        theme = "${pkgs.rofi-nord-theme}/nord.rasi";
        extraConfig = {
            show-icons = true;
            sort = true;
        };
    };

   i18n.inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [fcitx5-gtk fcitx5-chinese-addons];
    }; 

    gtk = {
      enable = true;
      iconTheme = {
        package = pkgs.tela-icon-theme;
        name = "Tela";
      };
      theme = {
        package = pkgs.orchis-theme;
        name = "Orchis";
      };
    };

    qt = {
      enable = true;
      platformTheme = "gnome";
      style = {
        package = pkgs.adwaita-qt;
        name = "adwaita-dark";
      };
    };
  };
}