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
    services.gnome.gnome-keyring.enable = lib.mkForce false;

    environment.systemPackages = with pkgs; [
      ssh-askpass-fullscreen
      libfido2
    ];

    programs.ssh = {
      enableAskPassword = true;
      askPassword = "${pkgs.ssh-askpass-fullscreen}/bin/ssh-askpass-fullscreen";
      startAgent = true;
    };
  };
}
