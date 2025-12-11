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
        "0.pool.ntp.org"
        "1.pool.ntp.org"
        "2.pool.ntp.org"
        "3.pool.ntp.org"
      ];
    };
  };
}
