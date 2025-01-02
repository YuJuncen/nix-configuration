# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, unstable,... }:
{
  imports =
    [
      ../modules/sing-box

      ./use-tuna-mirror.nix
      ./polkit.nix
      ./nix-ld.nix
    ];

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    powerManagement.enable = false;
    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Do not disable this unless your GPU is unsupported or if you have a good reason to.
    open = true;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;

  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernel.sysctl = {
    "vm.swapiness" = 0;
  };

  services.xserver = {
    enable = true;
    displayManager = {
      lightdm = {
        enable = true;
        background = ../uncommon/wallpaper.jpg;
        greeters.gtk = {
          enable = true;
          iconTheme = {
            package = pkgs.fluent-icon-theme.override {
              colorVariants = [ "teal" ];
            };
            name = "Fluent-teal-dark";
          };
          theme = {
            package = pkgs.fluent-gtk-theme.override {
              tweaks = [ "square" ];
              themeVariants = [ "teal" ];
            };
            name = "Fluent-teal-Dark";
          };
          extraConfig = ''
          xft-dpi=192
          '';
        };
      };
    };
    windowManager.i3.enable = true;
  };
  environment.pathsToLink = [ "/libexec" ];
  time.timeZone = "Asia/Shanghai";


  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput = {
    enable = true;
    mouse = {
      naturalScrolling = true;
    };
  };

  users.users.hillium = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" "audio" "docker" "libvirtd" ];
  };
  programs.fish.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    tmux
    git
    fzf
    fish
    lsof
    sysstat

    kitty
    geoclue2

    picom

    nvidia-vaapi-driver
    vaapiVdpau
    libvdpau-va-gl
    egl-wayland
    hyprpaper
    playerctl

    # Some for wayland
    # wayland
    # xdg-utils # for opening default programs when clicking links
    # wl-clipboard

    usbutils
    pciutils
    bluetuith

    gtk4
    cage
  ];

  nixpkgs.config.allowUnfree = true;

  services.xserver.videoDrivers = [ "nvidia" ];
  services.picom.enable = true;

  fonts = {
    packages = with pkgs; [
      apple-fonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
      siji
      ibm-plex
      (nerdfonts.override {
        fonts = [ "Hasklig" "DroidSansMono" "IBMPlexMono" ];
      })
      intel-one-mono
    ];
    fontDir = {
      enable = true;
    };
    fontconfig = {
      antialias = true;
      cache32Bit = true;
      hinting = {
        enable = true;
        autohint = true;
      };

      localConf = ''
        <?xml version='1.0'?>
        <!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>
        <fontconfig>
          <match target="pattern">
            <test qual="any" name="family">
              <string>sans-serif</string>
            </test>
            <edit mode="prepend" binding="strong" name="family">
              <string>Noto Sans</string>
            </edit>
          </match>
          <match target="pattern">
            <test qual="any" name="family">
              <string>serif</string>
            </test>
            <edit mode="prepend" binding="strong" name="family">
              <string>Noto Serif</string>
            </edit>
          </match>
          <match target="pattern">
            <test qual="any" name="family">
              <string>monospace</string>
            </test>
            <edit mode="prepend" binding="strong" name="family">
              <string>IBM Plex Mono</string>
            </edit>
          </match>
          <match>
            <test name="family">
              <string>monospace</string>
            </test>
            <edit name="family" mode="append_last" binding="strong">
              <string>Noto Color Emoji</string>
            </edit>
          </match>
          <!-- Fallback fonts preference order -->
          <alias>
            <family>sans-serif</family>
            <prefer>
              <family>Noto Color Emoji</family>
              <family>Noto Sans CJK SC</family>
            </prefer>
          </alias>
          <alias>
            <family>serif</family>
            <prefer>
              <family>Noto Color Emoji</family>
              <family>Noto Serif CJK SC</family>
            </prefer>
          </alias>
          <alias>
            <family>monospace</family>
            <prefer>
              <family>BlexMono Nerd Font</family>
            </prefer>
          </alias>
        </fontconfig>
      '';
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;

  # Enable networking manager.
  networking = {
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowPing = true;
      extraCommands = "iptables -A INPUT -i 'utun+' -j ACCEPT";
      allowedTCPPorts = [
        53317 /* Local Send */
      ];
      checkReversePath = "loose";
    };
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

  virtualisation = {
    docker = {
    enable = true;
    daemon.settings = {
      registry-mirrors = [ "https://docker.mirrors.ustc.edu.cn/" ];
    };
  };
  libvirtd = {
    enable = true;
  };
  waydroid = {
    enable = true;
  };
  };

  # night shift!
  services.geoclue2.enable = true;
  location.provider = "geoclue2";

  services.redshift = {
    enable = true;
  };


  services.gnome.gnome-keyring.enable = true;
  services.colord.enable = true;

  # Nearly always open bluetooth.
  hardware.bluetooth.enable = true;


  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Home manager doesn't support this, aha.
  programs.gpaste.enable = true;

  # hardware.pulseaudio.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  services.gvfs.enable = true;
  services.dbus.enable = true;
  security.rtkit.enable = true;
  services.self-hosted = {
    sing-box = {
      enable = true;
      configFile = "/var/lib/sing-box/config.json";
    };
  };

  networking.hostName = "structure";
}
