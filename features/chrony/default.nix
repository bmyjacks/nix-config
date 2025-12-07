{
  config,
  lib,
  ...
}:
{
  options.custom.chrony.enable = lib.mkEnableOption "Enable Chrony for NTP";

  config = lib.mkIf config.custom.chrony.enable {
    services.chrony = {
      enable = true;
      servers = [
        "pool.ntp.org"
        "time.apple.com"
        "time.windows.com"
      ];
    };
  };
}
