{
  config,
  lib,
  pkgs,
  ...
}:
let
  featureName = "ssh-server";

  cfg = config.custom.${featureName};
in
{
  options.custom.${featureName}.enable = lib.mkEnableOption "Enable ${featureName}";

  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;
    };
  };
}
