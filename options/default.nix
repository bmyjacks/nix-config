{ lib, ... }:
{
  options.custom = {
    username = lib.mkOption {
      type = lib.types.str;
      default = "bmyjacks";
      description = "The primary user of this system";
    };

    fullname = lib.mkOption {
      type = lib.types.str;
      default = "Mingyi BAO";
      description = "Fullname of the primary user";
    };

    email = lib.mkOption {
      type = lib.types.str;
      default = "bmyjacks@outlook.com";
      description = "The primary email for git and identification";
    };
  };
}
