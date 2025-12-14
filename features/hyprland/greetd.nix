{
  config,
  lib,
  pkgs,
  ...
}:
let
  featureName = "greetd";
  cfg = config.custom.${featureName};

  username = config.custom.username;
in
{
  options.custom.${featureName}.enable = lib.mkEnableOption "Enable ${featureName}";

  config = lib.mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings = {
        # The "Initial Session" happens only once on boot.
        # We use it to auto-login your user.
        initial_session = {
          command = "uwsm start default";
          user = "bmyjacks"; # <--- Replace with your actual username!
        };

        # The "Default Session" is what happens if you logout of Hyprland.
        # It falls back to a text greeter so you aren't stuck in a loop.
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd 'uwsm start default'";
          user = "greeter";
        };
      };
    };
  };
}
