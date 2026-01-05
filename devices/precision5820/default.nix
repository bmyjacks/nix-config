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
      locale.enable = true;
      ssh-server.enable = true;
      systemd-boot.enable = true;
      tmpUseTmpfs.enable = true;
      zram.enable = true;
      zsh.enable = true;
    };

    networking.hostName = "precision5820";
    networking.networkmanager.enable = true;
    networking.hostId = "58095c8e";

    environment.systemPackages = with pkgs; [
      wget
    ];

    system.stateVersion = "25.11";
  };
}
