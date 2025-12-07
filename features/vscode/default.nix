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
  options.custom.vscode.enable = lib.mkEnableOption "Enable VSCode";

  config = lib.mkIf config.custom.vscode.enable {
    home-manager.users.${username}.programs.vscode = {
      enable = true;
      profiles.default.extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        pkief.material-icon-theme
        usernamehw.errorlens
        christian-kohler.path-intellisense
        zhuangtongfa.material-theme
      ];
    };
  };
}
