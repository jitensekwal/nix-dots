{ config, pkgs, lib , ... }:

let

shellAliases = {
".." = "cd ..";
ll = "ls -al";
gc = "cd ~/.dotfiles";
nos = "sudo nixos-rebuild switch --flake .";
not = "sudo nixos-rebuild test --flake .";
};

in
{
  imports = [
    ./modules/hyprland.nix
    ./modules/stylix.nix
  ];

  # Enable hyprland (custom option declared in ./modules/hyprland.nix)
  hyprland.enable = true;
  wallpaper = ./wallpapers/1340411.jpeg;
  stylixConfig.enable = true;
  stylixConfig.theme = "catppuccin-mocha";

  home.username = "jiten";
  home.homeDirectory = "/home/jiten";

  home.packages = [
  ];

  programs.git = {
    enable = true;
    userName = "jitensekwal";
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
    enableBashIntegration = true;
  };

  programs.kitty = {
  enable = true;
  font.package = lib.mkDefault pkgs.cascadia-code;
  font.name = lib.mkDefault "Cascadia Code NF";
  };

  programs.bash = {
  enable = true;
  inherit shellAliases;
  };

  programs.go.enable = true;

  programs.rofi = {
  enable = true;
  location = "center";
  font = lib.mkDefault "Cascadia Code NF";
  };

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

}
