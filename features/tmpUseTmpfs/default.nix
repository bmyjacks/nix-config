{
  config,
  lib,
  ...
}:
let
  featureName = "tmpUseTmpfs";

  cfg = config.custom.${featureName};
in
{
  options.custom.${featureName}.enable = lib.mkEnableOption "Enable ${featureName}";

  config = lib.mkIf cfg.enable {
    boot.tmp.useTmpfs = true;
  };
}
