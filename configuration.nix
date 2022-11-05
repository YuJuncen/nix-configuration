# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, home-manager, ... }:
{
  imports =
    [ 
      home-manager.nixosModule
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.xserver.enable = true;
  services.xserver.windowManager.i3 = {
    enable = true;
    extraPackages = with pkgs; [
      dmenu
      i3blocks
      i3lock
      rofi
    ];
  };
  environment.pathsToLink = [ "/libexec" ];


  time.timeZone = "Asia/Shanghai";
  

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };
  services.xserver.dpi = 192;
  environment.variables = {
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "0.5";
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  };


  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  nixpkgs.config.pulseaudio = true;

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
     packages = with pkgs; [
       firefox
       virt-manager
     ];
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
    
    konsole
    vscode
    kitty
    
    geoclue2
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "vscode"
  ];

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
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
  system.stateVersion = "22.05"; # Did you read the comment?

  nix.settings.substituters = ["https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"];
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      registry-mirrors = ["https://docker.mirrors.ustc.edu.cn/"];
    };
  };

  # night shift!
  services.geoclue2.enable = true;
  location.provider = "geoclue2";
 
  services.redshift = {
    enable = true;
  };

  # Perhaps we can use a more lightweighted key ring manager here. 
  programs.gnupg.agent = {
    enable = true;
  };
  services.gnome.gnome-keyring.enable = true;

  # Nearly always open bluetooth.
  hardware.bluetooth.enable = true;

  # Virtual machines!
  virtualisation.libvirtd = {
    enable = true;
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  
}
