{ pkgs, unstable, ... } @ ctx: {

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
        modes = "drun,run,ssh,calc,"+
        "playerctl:${./playerctl.sh},"+
        "codenv:${./workspaces.sh}";
      };
    };
}