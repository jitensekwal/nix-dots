{ pkgs, lib, config, inputs, ... }:

{
  options = {
    hyprland.enable = lib.mkEnableOption "enable hyprland";
  };
  
  config = lib.mkIf config.hyprland.enable {
    
    home.packages = with pkgs; [
      swww
      brightnessctl
      grimblast
      cliphist
      polkit_gnome
      xwaylandvideobridge
      wl-clipboard
      libnotify
    ];

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
      ];
      configPackages = with pkgs; [
        xdg-desktop-portal-hyprland
      ];
    };
    
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$mainMod" = "SUPER";
        "$terminal" = "kitty";
        
        exec-once = [
          "emacs --daemon"
          "swww-daemon"
          "swww img ${config.wallpaper}"
        ];
        
        monitor = ",preferred,auto,1,mirror,eDP-1";

        input = {
          kb_layout = "us" ;
          kb_options = "ctrl:nocaps";
          touchpad = {
            natural_scroll = "yes";
            disable_while_typing = "no";
          };
          sensitivity = 0.1;
        };
        
        general = {
          gaps_in = 2;
          gaps_out = 2;
          border_size = 2;
          layout = "dwindle";
          allow_tearing = false;
        };

        decoration = {
          rounding = 7;
          blur = {
            enabled = true;
            size = 3;
            passes = 1;
          };
        };

        animations = {
          enabled = 1;
          bezier = "overshot,0.13,0.99,0.29,1.1,";
          animation = [
            "fade,1,4,default"
            "workspaces,1,4,default,fade"
            "windows,1,4,overshot,popin 95%"
          ];
        };

        dwindle = {
          pseudotile = "yes";
          preserve_split = "yes";
        };

        gestures.workspace_swipe = "on";
        misc.force_default_wallpaper = 1;

        windowrulev2 = [
          "float, title:^(Firrfox — Sharing Indicator)$"
          "noborder, title:^(Firefox — Sharing Indicator)$"
          "rounding 0, title:^(Firefox — Sharing Indicator)$"
          "float, class:^(firefox)$, title:^(Picture-in-Picture)$"
          "pin, class:^(firefox)$, title:^(Picture-in-Picture)$"
          "move 100%-w-20 100%-w-20, class:^(firefox)$, title:^(Picture-in-Picture)$"
          "float, title:^(Save File)$"
          "pin, title:^(Save File)$"
          "pin, class:^(dragon)$"
          "float, title:^(Torrent Options)$"
          "pin, title:^(Torrent Options)$"
          "opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
          "noanim,class:^(xwaylandvideobridge)$"
          "noinitialfocus,class:^(xwaylandvideobridge)$"
          "maxsize 1 1,class:^(xwaylandvideobridge)$"
          "noblur,class:^(xwaylandvideobridge)$"
        ];

        # layerrule = "blur, waybar";
        
        bind = [
          "$mainMod, t, togglefloating, "
          "$mainMod shift, t, togglesplit,"
          "$mainMod, F, fullscreen, 0"
          "$mainMod, M, fullscreen, 1"
          "$mainMod , Q, killactive, "
          "$mainMod , delete, exit,"
          
          # Apps
          "$mainMod, space, exec, killall rofi || rofi -show-icons -show drun"
          "$mainMod, return, exec, $terminal"
          "$mainMod, B, exec, firefox"
          "$mainMod SHIFT, w, exec, swww img ${config.wallpaper}"
          
          # Screenshooting
          ", Print, exec, grimblast save screen"
          "ALT, Print, exec, grimblast save active"
          "SHIFT, Print, exec, grimblast save area"
          "CONTROL, Print, exec, grimblast copy screen"
          "ALT_CONTROL, Print, exec, grimblast copy active"
          "CONTROL_SHIFT, Print, exec, grimblast copy area "

          # Brightness
          ",XF86MonBrightnessUp,exec,brightnessctl s +5%"
          ",XF86MonBrightnessDown,exec,brightnessctl s 5%-"

          # Audio controls
          ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

          # Player controls
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPause, exec, playerctl play-pause"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPrev, exec, playerctl previous"

          # Windows
          "$mainMod, j, movefocus, d"
          "$mainMod, k, movefocus, u"
          "$mainMod, h, movefocus, l"
          "$mainMod, l, movefocus, r"
          "SUPER_SHIFT,j,movewindow,d"
          "SUPER_SHIFT,k,movewindow,u"
          "SUPER_SHIFT,h,movewindow,l"
          "SUPER_SHIFT,l,movewindow,r"
          "$mainMod, S, togglespecialworkspace, magic"
          "$mainMod SHIFT, S, movetoworkspace, special:magic"
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
        ] ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in [
              "$mainMod, ${ws}, workspace, ${toString (x + 1)}"
              "$mainMod SHIFT, ${ws}, movetoworkspacesilent, ${toString (x + 1)}"
            ]
          )
            10)
        );
        
        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];
      };
    };
  };
}
