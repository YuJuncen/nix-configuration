{ pkgs, unstable, ... } @ ctx: {
  home.packages = [
    unstable.zenity
    pkgs.jq
    pkgs.kitty
    pkgs.pavucontrol
  ];
  programs.rofi = {
    enable = true;
    font = "Noto Serif CJK SC 24";
    theme = "${pkgs.rofi-nord-theme}/nord.rasi";
    plugins = with pkgs; [ rofi-calc rofi-pulse-select rofi-power-menu ];
    extraConfig = {
      show-icons = true;
      sort = true;
      terminal = "${pkgs.kitty}/bin/kitty";
      modes = "drun,run,ssh," +
        "playerctl:${./playerctl.sh}," +
        "codenv:${./workspaces.sh}," +
        "controlpanel:${./controlpanel.sh}";
    };
  };
}
