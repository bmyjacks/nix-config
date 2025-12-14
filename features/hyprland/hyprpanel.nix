{
  config,
  lib,
  pkgs,
  ...
}:
let
  featureName = "hyprpanel";
  cfg = config.custom.${featureName};

  username = config.custom.username;
in
{
  options.custom.${featureName}.enable = lib.mkEnableOption "Enable ${featureName}";

  config = lib.mkIf cfg.enable {
    services.upower.enable = true;
    home-manager.users.${username} = {
      programs.hyprpanel = {
        enable = true;
        systemd.enable = true;
      };
    };
  };
}
