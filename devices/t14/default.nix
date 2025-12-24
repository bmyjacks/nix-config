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
      cosmic.enable = true;
      devenvir.enable = true;
      firefox.enable = true;
      fonts.enable = true;
      git.enable = true;
      gpg.enable = true;
      locale.enable = true;
      localsend.enable = true;
      neovim.enable = true;
      ssh-client.enable = true;
      systemd-boot.enable = true;
      tailscale.enable = true;
      tlp.enable = true;
      tmpUseTmpfs.enable = true;
      zram.enable = true;
      zsh.enable = true;
    };

    boot.kernelPackages = pkgs.linuxPackages_latest;

    networking.hostName = "t14";
    networking.networkmanager.enable = true;
    networking.hostId = "58095c8e";

    environment.systemPackages = with pkgs; [
      wget
      htop
      btop
      compsize
      gcc
    ];

    system.stateVersion = "25.11";
  };
}
