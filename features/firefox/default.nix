{
  config,
  lib,
  ...
}:
let
  username = config.custom.username;
in
{
  options.custom.firefox.enable = lib.mkEnableOption "Enable Firefox";

  config = lib.mkIf config.custom.firefox.enable {
    home-manager.users.${username}.programs.firefox = {
      enable = true;
    };
  };
}
