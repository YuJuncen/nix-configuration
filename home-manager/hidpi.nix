{ ... }: {
  home.sessionVariables = {
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "0.5";
    QT_AUTO_SCREEN_SCALE_FACTOR = 1;
    QT_ENABLE_HIGHDPI_SCALING = 1;
  };
  xresources.properties = {
    "Xft.dpi" = 192;
    "Xft.autohint" = 0;
    "Xft.lcdfilter" = "lcddefault";
    "Xft.hintstyle" = "hintfull";
    "Xft.hinting" = 1;
    "Xft.antialias" = 1;
    "Xft.rgba" = "rgb";
  };
  gtk.gtk4.extraConfig = {
    gtk-font-name = "PingFang CJK SC 6";
  };
}
