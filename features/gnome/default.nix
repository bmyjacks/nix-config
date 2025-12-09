{
  config,
  lib,
  pkgs,
  ...
}:
let
  featureName = "gnome";

  cfg = config.custom.${featureName};
in
{
  options.custom.${featureName}.enable = lib.mkEnableOption "Enable ${featureName}";

  config = lib.mkIf cfg.enable {
    # Enable gdm and gnome pkg
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;

    # Enable needed apps
    services.gnome = {
      core-apps.enable = true;
      localsearch.enable = false;
      tinysparql.enable = false;
    };
    environment.gnome.excludePackages = with pkgs; [
      gnome-tour
      gnome-user-docs
      epiphany # Web
      seahorse # Key manager
      geary # Mail client
    ];

    # Add some useful pkgs
    environment.systemPackages = with pkgs; [
      gnome-tweaks
      papirus-icon-theme
      bibata-cursors
    ];
  };
}
