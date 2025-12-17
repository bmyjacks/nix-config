{
  config,
  lib,
  pkgs,
  ...
}:
let
  featureName = "devenvir";
  cfg = config.custom.${featureName};

  username = config.custom.username;
in
{
  options.custom.${featureName}.enable = lib.mkEnableOption "Enable ${featureName}";

  config = lib.mkIf cfg.enable {
    home-manager.users.${username} = {
      # Devenv
      home.packages = with pkgs; [
        devenv
      ];

      # Direnv
      programs.direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
      };

    };
  };
}
