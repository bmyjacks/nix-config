{ config, pkgs, ... }:

{
  imports = [
    ./chrome
    ./chrony
    ./firefox
    ./fonts
    ./git
    ./gnome
    ./gpg
    ./hyprland
    ./kde
    ./locale
    ./localsend
    ./neovim
    ./ssh
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

    nix.settings.download-buffer-size = 524288000;

    # Enable unfree
    nixpkgs.config.allowUnfree = true;
  };
}
