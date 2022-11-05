{ home-manager, pkgs,... } :
{
home-manager.users.hillium = {
    home.stateVersion = version;

    home.packages = with pkgs; [
       cider 
       dconf
       gnome.seahorse
       feh
    ];

   i18n.inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [fcitx5-rime fcitx5-gtk fcitx5-chinese-addons];
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