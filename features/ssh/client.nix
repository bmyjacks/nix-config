{
  config,
  lib,
  pkgs,
  ...
}:
let
  featureName = "ssh-client";

  cfg = config.custom.${featureName};
in
{
  options.custom.${featureName}.enable = lib.mkEnableOption "Enable ${featureName}";

  config = lib.mkIf cfg.enable {
    programs.ssh = {
      # enableAskPassword = true;
      # startAgent = true;
    };

    environment.systemPackages = with pkgs; [
      libfido2
    ];
  };
}
