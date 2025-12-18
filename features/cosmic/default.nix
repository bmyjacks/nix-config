{
  config,
  lib,
  pkgs,
  ...
}:
let
  featureName = "cosmic";
  cfg = config.custom.${featureName};

  username = config.custom.username;
in
{
  options.custom.${featureName}.enable = lib.mkEnableOption "Enable ${featureName}";

  config = lib.mkIf cfg.enable {
    services = {
      displayManager.cosmic-greeter.enable = true;
      desktopManager.cosmic.enable = true;

      system76-scheduler.enable = true;
    };
  };
}
