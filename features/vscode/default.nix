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
      package = pkgs.vscode-fhs;
      profiles.default = {
        # Disable update
        #enableUpdateCheck = false;
        #enableExtensionUpdateCheck = false;

        # Enable some useful extensions
        #extensions = with pkgs.vscode-extensions; [
        #  github.copilot-chat
        #  jnoortheen.nix-ide
        #  pkief.material-icon-theme
        #  usernamehw.errorlens
        #  christian-kohler.path-intellisense
        #  zhuangtongfa.material-theme
        #  golang.go
        # mkhl.direnv
        #];

        # Settings
        userSettings = {
          "editor.fontSize" = 18;
          "files.autoSave" = "onFocusChange";
          "editor.fontFamily" = "'Maple Mono NF CN', monospace";
          "workbench.colorTheme" = "One Dark Pro";
          "workbench.iconTheme" = "material-icon-theme";
        };
      };
    };
  };
}
