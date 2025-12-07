{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.custom.gnome.enable = lib.mkEnableOption "Enable GNOME";

  config = lib.mkIf config.custom.gnome.enable {
    # Enable gdm and gnome pkg
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;

    # Enable needed apps
    services.gnome.core-apps.enable = true;
    environment.gnome.excludePackages = with pkgs; [
      gnome-tour
      gnome-user-docs
      epiphany # Web
      seahorse # Key manager
    ];

    # Add some useful pkgs
    environment.systemPackages = with pkgs; [
      gnome-tweaks
      papirus-icon-theme
      bibata-cursors
    ];
  };
}
