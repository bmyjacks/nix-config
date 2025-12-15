{
  config,
  lib,
  pkgs,
  ...
}:
let
  featureName = "chrome";
  cfg = config.custom.${featureName};

  username = config.custom.username;
in
{
  options.custom.${featureName}.enable = lib.mkEnableOption "Enable ${featureName}";

  config = lib.mkIf cfg.enable {
    home-manager.users.${username}.home.packages = with pkgs; [
      google-chrome
    ];
  };
}
