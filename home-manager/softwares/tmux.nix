{ pkgs, colors, ... }:
let
  minimal = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "minimal";
    version = "unstable";
    src = pkgs.fetchFromGitHub {
      owner = "niksingh710";
      repo = "minimal-tmux-status";
      rev = "ee00ccc15a6fdd42b98567602434f7c9131ef89f";
      hash = "sha256-tC9KIuEpMNbBbM6u3HZF0le73aybvA7agNBWYksKBDY=";
    };
    rtpFilePath = "minimal.tmux";
  };
in
{
  home.packages = with pkgs; [ fish tmux xsel tmux-xpanes ];

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    clock24 = true;
    baseIndex = 1;
    mouse = true;
    extraConfig = ''
      set -g status-style bg=${colors.background},fg=${colors.foreground}
    '';
    # Install plugins: Pfx + I
    plugins = with pkgs; [
      {
        plugin = minimal;
        extraConfig = ''
          set -g @minimal-tmux-bg "${colors.primary}"
          set -g @minimal-tmux-justify "left"
          set -g @minimal-tmux-indicator-str " 󱗼 "
        '';
      }
      # Quick open items in screen: Pfx + f
      tmuxPlugins.fpp
      # General optimizations.
      tmuxPlugins.sensible
      # As its name. Highlight when Pfx key stroked.
      tmuxPlugins.prefix-highlight
      # Quick select items in screen: Pfx + space
      tmuxPlugins.tmux-thumbs
      # Copy & paste to system clipboard.
      tmuxPlugins.yank
    ];
  };
}
