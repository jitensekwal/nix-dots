{ config, pkgs, system, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Define hostname
  networking.hostName = "nixos";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account
  users.users.jiten = {
    isNormalUser = true;
    description = "Jiten";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Packages
  environment.systemPackages = with pkgs; [
   neovim
   kitty
   wget
   git
   pavucontrol
   blueman
   brightnessctl
   playerctl
   waybar
   eww
   swww
   hyprlock
   go
   zig
   yazi
   tree
   fzf
   spotify
  ];

  # Enable firefox
  programs.firefox.enable = true;
  # Enable Hyprland
  programs.hyprland.enable = true;
  # Enable bluetooth
  hardware.bluetooth.enable = true;
  # Enable pipewire
  services.pipewire = {
	enable = true;
	alsa.enable = true;
	alsa.support32Bit = true;
	pulse.enable = true;
  };
  # Enable flakes and nix-command
  nix.settings.experimental-features = ["nix-command" "flakes"];
  # enabl sddm
  services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
  };

  stylix.enable = true;
  stylix.image = ./home/images.jpg;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

  system.stateVersion = "24.11";

}
