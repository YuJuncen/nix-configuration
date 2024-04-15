{ pkgs, ... }:
{
  home.packages = with pkgs; [ fish tmux xsel ];

  programs.tmux = {
    enable = true;
    shell = "fish";
    keyMode = "vi";
    clock24 = true;
    baseIndex = 1;
    mouse = true;
    # Install plugins: Pfx + I
    plugins = with pkgs; [
      # Save state of tmux. Pfx + ^s/r to save / restore.
      tmuxPlugins.resurrect
      # Auto save / restore the state.
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
        '';
      }
      # Quick open items in screen: Pfx + f
      tmuxPlugins.fpp
      # General optimizations.
      tmuxPlugins.sensible
      # As its name. Highlight when Pfx key stroked.
      tmuxPlugins.prefix-highlight
      # Quick select items in screen: Pfx + F
      tmuxPlugins.tmux-thumbs
      # Copy & paste to clipboard.
      # Copy mode: directly stroke y
      # Copy $PWD: Pfx + Y 
      tmuxPlugins.yank
    ];
  };
}
