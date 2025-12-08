{
  config,
  lib,
  ...
}:
let
  featureName = "localsend";

  cfg = config.custom.${featureName};
in
{
  options.custom.${featureName}.enable = lib.mkEnableOption "Enable ${featureName}";

  config = lib.mkIf cfg.enable {
    programs.localsend.enable
  };
}
