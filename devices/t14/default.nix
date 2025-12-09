{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./hardware.nix
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14-intel-gen1

    # Options
    ../../options

    # Users
    ../../modules/users/bmyjacks

    # Features
    ../../features
  ];

  config = {
    custom = {
      # Set username and email
      username = "bmyjacks";
      email = "bmyjacks@outlook.com";

      # Enable features
      chrony.enable = true;
      firefox.enable = true;
      fonts.enable = true;
      git.enable = true;
      gpg.enable = true;
      gnome.enable = true;
      locale.enable = true;
      localsend.enable = true;
      systemd-boot.enable = true;
      tailscale.enable = true;
      tmpUseTmpfs.enable = true;
      vscode.enable = true;
      zram.enable = true;
      zsh.enable = true;
    };

    networking.hostName = "t14";
    networking.networkmanager.enable = true;
    networking.hostId = "58095c8e";

    environment.systemPackages = with pkgs; [
      vim
      wget
      htop
      btop
    ];

    system.stateVersion = "25.05";
  };
}
