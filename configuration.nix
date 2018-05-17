# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # networking
  networking.hostName = "ml";
  #networking.wireless.enable = true;
  networking.dhcpcd.enable = true;
  networking.networkmanager.enable = true;

  i18n = {
#    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # timezone
  time.timeZone = "America/Recife";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # packages
  environment.systemPackages = with pkgs; [
    wget curl
    neovim
    git
    python
    python3
    gcc
    gdb
    valgrind
    ghc
    stack
    cabal-install
    nodejs
    go
    sbcl
    elixir
  ];

  nixpkgs.config = {
    allowUnfree = true;
  };
  
  # programs
  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;

  # services
  services.openssh.enable = true;

  # audio
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # security
  security.sudo.enable = true;
  
  # x11
  services.xserver = {
    enable = true;
    layout = "br,us";
    displayManager = {
      lightdm.enable = true;
    };
    desktopManager = {
      xfce.enable = true;
      default = "xfce";
      xterm.enable = false;
    };
    synaptics = {
      enable = true;
      buttonsMap = [ 1 3 2 ];
      tapButtons = true;
      twoFingerScroll = true;
      vertEdgeScroll = false;
      minSpeed = "4";
      #maxSpeed = "60";
      #accelFactor = "0.0075";
    };
  };

  # users
  users.extraUsers.d = {
    name = "d";
    group = "users";
    extraGroups = [
      "wheel" "disk" "audio" "video" "networkmanager" "systemd-journal"
    ];
    createHome = true;
    home = "/home/d";
    uid = 1000;
    shell = "/run/current-system/sw/bin/zsh";
  };

  # version 
  system.stateVersion = "18.03"; # Did you read the comment?
}
