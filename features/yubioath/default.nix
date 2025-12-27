{
  config,
  lib,
  pkgs,
  ...
}:
let
  featureName = "yubioath";
  cfg = config.custom.${featureName};

  username = config.custom.username;
in
{
  options.custom.${featureName}.enable = lib.mkEnableOption "Enable ${featureName}";

  config = lib.mkIf cfg.enable {
    # udev rule
    services.udev.packages = [ pkgs.yubikey-personalization ];
    # smartcard
    services.pcscd.enable = true;

    # gui
    home-manager.users.${username} = {
      home.packages = with pkgs; [
        yubioath-flutter
      ];
    };
  };
}
