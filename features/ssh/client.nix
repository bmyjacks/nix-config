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
    environment.systemPackages = with pkgs; [
      ssh-askpass-fullscreen
      libfido2
    ];

    programs.ssh = {
      enableAskPassword = true;
      askPassword = "${pkgs.ssh-askpass-fullscreen}/bin/ssh-askpass-fullscreen";
      startAgent = true;
    };

    services.gnome.gcr-ssh-agent.enable = false;
  };
}
