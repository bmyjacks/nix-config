{
  config,
  lib,
  pkgs,
  ...
}:
let
  featureName = "ly";
  cfg = config.custom.${featureName};

  username = config.custom.username;
in
{
  options.custom.${featureName}.enable = lib.mkEnableOption "Enable ${featureName}";

  config = lib.mkIf cfg.enable {
    services.displayManager.ly = {
      enable = true;
      x11Support = false;
      settings = {
        animation = "matrix";
        battery_id = "BAT0";
        clear_password = true;
      };
    };
  };
}
