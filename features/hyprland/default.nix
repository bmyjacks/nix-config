{
  config,
  lib,
  pkgs,
  ...
}:
let
  featureName = "hyprland";

  cfg = config.custom.${featureName};
in
{
  options.custom.${featureName}.enable = lib.mkEnableOption "Enable ${featureName}";

  config = lib.mkIf cfg.enable {
    # Enable Hyprland
    programs.hyprland = {
      enable = true;
      withUWSM = true; # recommended for most users
      xwayland.enable = true; # Xwayland can be disabled.
    };

    # Essential "Mouseless" tools
    environment.systemPackages = with pkgs; [
      # Launcher (replace your start menu)
      rofi-wayland # or wofi, fuzzel

      # Terminal (fast, keyboard centric)
      kitty # or alacritty, foot

      # Status Bar
      waybar

      # Notifications
      dunst # or mako

      # Clipboard manager (essential for keyboard copy/paste)
      wl-clipboard
    ];

    # Optional: Hint Electron apps (VS Code, Discord) to use Wayland
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
