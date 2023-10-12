_cx: ''# See https://wiki.hyprland.org/Configuring/Monitors/
  monitor=,preferred,auto,2


  # See https://wiki.hyprland.org/Configuring/Keywords/ for more

  # Execute your favorite apps at launch
  # exec-once = waybar & hyprpaper & firefox

  # Source a file (multi-file configs)
  # source = ~/.config/hypr/myColors.conf

  # Some default env vars.
  env = WLR_NO_HARDWARE_CURSORS,1
  env = QT_QPA_PLATFORM,wayland
  # For VSCode.
  env = NIXOS_OZONE_WL,1

  env = QT_AUTO_SCREEN_SCALE_FACTOR,1
  env = QT_ENABLE_HIGHDPI_SCALING,1
  env = GDK_BACKEND,wayland

  env = INPUT_METHOD,fcitx
  env = QT_IM_MODULE,fcitx
  env = GTK_IM_MODULE,fcitx
  env = XMODIFIERS,@im=fcitx
  env = XIM_SERVERS,fcitx

  # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
  input {
      kb_layout = us
      kb_variant =
      kb_model =
      kb_options =
      kb_rules =

      follow_mouse = 2

      natural_scroll = true
      numlock_by_default = true

      sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
  }

  general {
      # See https://wiki.hyprland.org/Configuring/Variables/ for more

      gaps_in = 0
      gaps_out = 0
      border_size = 2
      col.active_border = rgb(429d71)
      col.inactive_border = rgb(575c58)

      layout = dwindle
  }

  group {
    col.border_inactive = rgb(575c58)
    col.border_active = rgb(86c166)
    groupbar {
        render_titles = false
    }
  }

  decoration {
      # See https://wiki.hyprland.org/Configuring/Variables/ for more

      rounding = 0

      drop_shadow = yes
      shadow_range = 4
      shadow_render_power = 3
      col.shadow = rgba(1a1a1aee)
  }

  animations {
      enabled = yes

      # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

      bezier = myBezier, 0.05, 0.9, 0.1, 1.05

      animation = windows, 1, 7, myBezier
      animation = windowsOut, 1, 7, default, popin 80%
      animation = border, 1, 10, default
      animation = borderangle, 1, 8, default
      animation = fade, 1, 7, default
      animation = workspaces, 1, 6, default
  }

  dwindle {
      # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
      pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
      preserve_split = yes # you probably want this
  }

  master {
      # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
      new_is_master = true
  }

  gestures {
      # See https://wiki.hyprland.org/Configuring/Variables/ for more
      workspace_swipe = off
  }

  exec-once = hyprpaper
  exec-once = fcitx5 -d
  exec-once = systemctl --user restart waybar
  exec-once = clash-verge
  exec-once = wl-paste --type text --watch cliphist store #Stores only text data
  exec-once = wl-paste --type image --watch cliphist store #Stores only image data

  # Example windowrule v1
  # windowrule = float, ^(kitty)$
  # Example windowrule v2
  # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
  # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more


  # See https://wiki.hyprland.org/Configuring/Keywords/ for more
  $mainMod = SUPER

  windowrulev2 = bordercolor rgb(ff7700),xwayland:1
  windowrulev2 = float,class:^kitty-floating$
  windowrulev2 = float,workspace:name:Extra
  windowrulev2 = float,class:^clash-verge$
  windowrulev2 = float,class:^org\.gnome\.
  windowrulev2 = float,class:^seahorse$

  bindn = CTRL,F11,pass,^GoldenDict-ng$
  bindn = $mainMod CTRL,C,exec,wl-paste | xargs goldendict
  bind = SUPER SHIFT,S,exec,QT_SCREEN_SCALE_FACTORS="0.5" flameshot gui
  bind = ALT, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy


  # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
  bind = $mainMod, RETURN, exec, ~/scripts/hypr-contextual-run
  bind = $mainMod SHIFT, Q, killactive
  bind = $mainMod, M, exit, 
  bind = $mainMod, E, exec, dolphin
  bind = $mainMod, V, togglefloating, 
  bind = $mainMod, D, exec, wofi --show drun
  bind = $mainMod SHIFT, D, exec, wofi --show run
  bind = $mainMod, P, pseudo, # dwindle
  bind = $mainMod, S, togglesplit, # dwindle
  bind = $mainMod, T, togglegroup
  bind = $mainMod, F, fullscreen

  # Move focus with mainMod + arrow keys
  bind = $mainMod, H, movefocus, l
  bind = $mainMod, L, movefocus, r
  bind = $mainMod, K, movefocus, u
  bind = $mainMod, J, movefocus, d

  bind = $mainMod, I, changegroupactive, p
  bind = $mainMod, O, changegroupactive, f
  bind = $mainMod SHIFT, I, togglegroup, p
  bind = $mainMod SHIFT, O, moveoutofgroup, f

  # Switch workspaces with mainMod + [0-9]
  bind = $mainMod, 1, workspace, 1
  bind = $mainMod, 2, workspace, 2
  bind = $mainMod, 3, workspace, 3
  bind = $mainMod, 4, workspace, 4
  bind = $mainMod, 5, workspace, 5
  bind = $mainMod, 6, workspace, 6
  bind = $mainMod, z, workspace, name:Terminal
  bind = $mainMod, x, workspace, name:Extra 
  bind = $mainMod, c, workspace, name:Browsers
  bind = $mainMod, 0, workspace, 10

  # Move active window to a workspace with mainMod + SHIFT + [0-9]
  bind = $mainMod SHIFT, 1, movetoworkspace, 1
  bind = $mainMod SHIFT, 2, movetoworkspace, 2
  bind = $mainMod SHIFT, 3, movetoworkspace, 3
  bind = $mainMod SHIFT, 4, movetoworkspace, 4
  bind = $mainMod SHIFT, 5, movetoworkspace, 5
  bind = $mainMod SHIFT, 6, movetoworkspace, 6
  bind = $mainMod SHIFT, z, movetoworkspace, name:Terminal
  bind = $mainMod SHIFT, x, movetoworkspace, name:Extra
  bind = $mainMod SHIFT, c, movetoworkspace, name:Browsers
  bind = $mainMod SHIFT, 0, movetoworkspace, 10

  # Scroll through existing workspaces with mainMod + scroll
  bind = $mainMod, mouse_down, workspace, e+1
  bind = $mainMod, mouse_up, workspace, e-1

  # Move/resize windows with mainMod + LMB/RMB and dragging
  bindm = $mainMod, mouse:272, movewindow
  bindm = $mainMod, mouse:273, resizewindow
''
