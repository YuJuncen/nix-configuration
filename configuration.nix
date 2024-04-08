# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, unstable, ... }:
{
  imports =
    [
      ./nixos/foundation.nix
    ];

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
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
      gdm = {
        enable = true;
        wayland = true;
      };
    };
  };
  environment.pathsToLink = [ "/libexec" ];
  time.timeZone = "Asia/Shanghai";


  environment.variables = {
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  };


  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput = {
    enable = true;
    mouse = {
      naturalScrolling = true;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hillium = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" "audio" "docker" "libvirtd" ];
    hashedPassword = "$6$FFGkdebWQ9l83MQ3$IsQqoZ9AC7qJSActPp0MnAHLx1cCcQoCbem/VIQmDpwjA83yv5gCzCRMW7LALEN4Z5jPMZtXXlJyCcE1RGWiX.";
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

    glib
    picom

    nvidia-vaapi-driver
    vaapiVdpau
    libvdpau-va-gl
    egl-wayland
    hyprpaper
    playerctl

    # Some for wayland
    wayland
    xdg-utils # for opening default programs when clicking links
    wl-clipboard
    glib # gsettings

    polkit-kde-agent
  ];

  nixpkgs.config.allowUnfree = true;

  services.xserver.videoDrivers = [ "nvidia" ];
  services.picom.enable = true;

  fonts.fonts = with pkgs; [
    noto-fonts-cjk
    noto-fonts-cjk-serif
    noto-fonts-cjk-sans
    noto-fonts-emoji
    siji
    ibm-plex
    (nerdfonts.override {
      fonts = [ "Hasklig" "DroidSansMono" "IBMPlexMono" ];
    })
    intel-one-mono
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;

  # Enable networking manager.
  networking.networkmanager.enable = true;

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
  system.stateVersion = "23.11"; # Did you read the comment?

  i18n.inputMethod = {
    enabled = "fcitx5";
  };

  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      registry-mirrors = [ "https://docker.mirrors.ustc.edu.cn/" ];
    };
  };

  # night shift!
  services.geoclue2.enable = true;
  location.provider = "geoclue2";

  services.redshift = {
    enable = true;
  };


  services.gnome.gnome-keyring.enable = true;

  # Nearly always open bluetooth.
  hardware.bluetooth.enable = true;

  # Virtual machines!
  virtualisation.libvirtd = {
    enable = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.xwayland = {
    enable = true;
  };
  programs.hyprland = {
    enable = true;
    xwayland = {
      enable = true;
    };
    package = unstable.hyprland.override {
      enableXWayland = config.programs.hyprland.xwayland.enable;
    };

  };
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };
  services.gvfs.enable = true;
  services.dbus.enable = true;
  security.rtkit.enable = true;

  # Well, not a good idea.
  systemd.services.nix-daemon.environment = {
    "HTTP_PROXY" = "http://127.0.0.1:7890";
    "HTTPS_PROXY" = "http://127.0.0.1:7890";
  };
}
