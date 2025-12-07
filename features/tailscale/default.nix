{
  config,
  lib,
  pkgs,
  ...
}:
let
  username = config.custom.username;
in
{
  options.custom.tailscale.enable = lib.mkEnableOption "Enable Tailscale";

  config = lib.mkIf config.custom.tailscale.enable {
    services.tailscale.enable = true;

    networking.firewall.allowedUDPPorts = [ 41641 ];
    networking.networkmanager.unmanaged = [ "tailscale0" ];
  };
}
