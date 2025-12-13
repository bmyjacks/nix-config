{
  config,
  lib,
  ...
}:
let
  username = config.custom.username;
  fullname = config.custom.fullname;
  email = config.custom.email;
in
{
  options.custom.git.enable = lib.mkEnableOption "Enable Git";

  config = lib.mkIf config.custom.git.enable {
    home-manager.users.${username}.programs.git = {
      enable = true;
      settings = {
        init.defaultBranch = "master";
        user = {
          name = "${fullname}";
          email = "${email}";
        };
      };
    };
  };
}
