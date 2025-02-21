{ pkgs, config, lib, inputs, ... }:

{
  imports = [
  ];

  options = {
    stylixConfig = {
      enable = lib.mkEnableOption "enable stylix";
      theme = lib.mkOption { type = lib.types.str; };
    };
    wallpaper = lib.mkOption { type = with lib.types; oneOf [str path package]; };
  };
  config = {
    stylix = {
      enable = true;
      polarity = "dark";

      opacity = {
        terminal = 0.7;
        # applications = 0.7;
      };
      
      base16Scheme = "${pkgs.base16-schemes}/share/themes/${config.stylixConfig.theme}.yaml";
      image = config.wallpaper;
      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
        size = 24;
      };
      
      fonts = {
        serif = {
          package = pkgs.cascadia-code;
	  name = "Cascadia Code NF";
        };

        sansSerif = {
          package = pkgs.cascadia-code;
	  name = "Cascadia Code NF";
        };

        monospace = {
          package = pkgs.cascadia-code;
	  name = "Cascadia Code NF";
        };

        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };
      };
    };
  };
}
