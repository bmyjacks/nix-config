{
  config,
  lib,
  pkgs,
  ...
}:
let
  featureName = "tlp";
  cfg = config.custom.${featureName};

  username = config.custom.username;
in
{
  options.custom.${featureName}.enable = lib.mkEnableOption "Enable ${featureName}";

  config = lib.mkIf cfg.enable {
    services = {
      power-profiles-daemon = false;
    };
  };
}
