{
  config,
  lib,
  ...
}:
let
  featureName = "systemd-boot";

  cfg = config.custom.${featureName};
in
{
  options.custom.${featureName}.enable = lib.mkEnableOption "Enable ${featureName}";

  config = lib.mkIf cfg.enable {
    boot.loader.systemd-boot = {
      enable = true;
      consoleMode = "auto";
    };

    boot.loader.efi.canTouchEfiVariables = true;
  };
}
