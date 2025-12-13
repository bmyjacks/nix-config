{
  config,
  lib,
  pkgs,
  ...
}:
let
  featureName = "hyprland";
  cfg = config.custom.${featureName};

  username = config.custom.username;
in
{
  options.custom.${featureName}.enable = lib.mkEnableOption "Enable ${featureName}";

  imports = [
    ./ly.nix
  ];

  config = lib.mkIf cfg.enable {
    # Enable ly
    custom.options.ly.enable = true;

    # Enable Hyprland
    programs.hyprland = {
      enable = true;
      withUWSM = true; # recommended for most users
      xwayland.enable = true; # Xwayland can be disabled.
    };

    home-manager.users.${username} = {
      wayland.windowManager.hyprland = {
        enable = true;
        settings = {
          monitor = ",preferred,auto,1";
          input.touchpad.natural_scroll = true;
          "$mainMod" = "SUPER";
          bind = [
            # Basic System
            "$mainMod, Q, exec, kitty"
            "$mainMod, C, killactive,"
            "$mainMod, V, togglefloating,"
            "$mainMod, R, exec, hyprlauncher"
            "$mainMod, P, pseudo," # dwindle
            "$mainMod, J, togglesplit," # dwindle

            # Focus Movement (Vim style)
            "$mainMod, left, movefocus, l"
            "$mainMod, right, movefocus, r"
            "$mainMod, up, movefocus, u"
            "$mainMod, down, movefocus, d"
          ];
        };
      };
    };

    # Essential "Mouseless" tools
    environment.systemPackages = with pkgs; [
      # Launcher
      hyprlauncher

      # Console
      kitty
    ];

    # Optional: Hint Electron apps (VS Code, Discord) to use Wayland
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
