{ config, pkgs, ... }:

{
  imports = [
    ./client.nix
    ./server.nix
  ];
}
