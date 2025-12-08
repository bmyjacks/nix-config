{ config, pkgs, ... }:

{
  imports = [
    ./chrony
    ./firefox
    ./fonts
    ./git
    ./gnome
    ./gpg
    ./locale
    ./localsend
    ./systemd-boot
    ./tailscale
    ./tmpUseTmpfs
    ./vscode
    ./zram
    ./zsh
  ];

  config = {
    # Enable Flakes
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    # Enable unfree
    nixpkgs.config.allowUnfree = true;
  };
}
