{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.custom.locale.enable = lib.mkEnableOption "Enable locale";

  config = lib.mkIf config.custom.locale.enable {
    # Timezone control
    time.timeZone = "America/Chicago";
    time.hardwareClockInLocalTime = false;

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
  };
}
