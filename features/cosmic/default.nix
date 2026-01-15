{
  config,
  lib,
  ...
}:
let
  featureName = "cosmic";
  cfg = config.custom.${featureName};

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
