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
      profiles.default = {
        containersForce = true;
        search = {
          force = true;
          default = "google";
        };

        # Set default
        isDefault = true;
        id = 0;
      };

      # Install bitwarden
      policies = {
        ExtensionSettings = {
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            default_area = "navbar";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };
        };

        # Disable auto updates
        ExtensionUpdate = false;
      };
    };
  };
}
