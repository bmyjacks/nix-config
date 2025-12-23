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
  options.custom.zsh.enable = lib.mkEnableOption "Enable Zsh";

  config = lib.mkIf config.custom.zsh.enable {
    # Enable zsh
    programs.zsh.enable = true;

    # Change user shell
    users.users.${username}.shell = pkgs.zsh;

    home-manager.users.${username} = {
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        # oh-my-zsh
        oh-my-zsh = {
          enable = true;
          plugins = [
            "git"
            "sudo"
          ];
          theme = "robbyrussell";
        };

        shellAliases = {
          ll = "ls -alh";
          update = "nix flake update";
        };

        history.size = 10000;
        history.ignoreAllDups = true;
        history.path = "$HOME/.zsh_history";
        history.ignorePatterns = [
          "rm *"
          "pkill *"
          "cp *"
        ];
      };
    };
  };
}
