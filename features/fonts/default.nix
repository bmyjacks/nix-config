{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.custom.fonts.enable = lib.mkEnableOption "Enable custom fonts";

  config = lib.mkIf config.custom.fonts.enable {
    fonts.packages = with pkgs; [
      maple-mono.NF-CN
    ];
  };
}
