{
  config,
  lib,
  pkgs,
  ...
}:
let
  featureName = "gpg";
  cfg = config.custom.${featureName};

  username = config.custom.username;

  gpgKeyPath = pkgs.fetchurl {
    url = "https://keys.openpgp.org/vks/v1/by-fingerprint/80C3EF48F190AD69662FCF3EF626405A4B62AA52";
    sha256 = "058ifyr5z7gynrwgxmb9yrz00p1gfvv6qc04qpizghvsf3plq299";
  };
  gpgKeyId = "0xF626405A4B62AA52";
in
{
  options.custom.${featureName}.enable = lib.mkEnableOption "Enable ${featureName}";

  config = lib.mkIf cfg.enable {
    # Enable yubikey support
    services.pcscd.enable = true;
    services.udev.packages = [ pkgs.yubikey-personalization ];

    # 3. Home Manager: GPG Program (Public Keys)
    home-manager.users.${username} = {
      programs.gpg = {
        enable = true;
        mutableKeys = false;
        mutableTrust = false;
        publicKeys = [
          {
            source = gpgKeyPath;
            trust = "ultimate";
          }
        ];
      };
      services.gpg-agent = {
        enable = true;
        pinentry.package = pkgs.pinentry-tty;
      };

      # Make git to sign by default
      programs.git = lib.mkIf config.custom.git.enable {
        signing = {
          key = gpgKeyId;
          signByDefault = true;
        };
      };
    };
  };
}
