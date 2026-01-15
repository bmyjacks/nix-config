{
  config,
  pkgs,
  inputs,
  ...
}:
let
  username = config.custom.username;
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  config = {
    users.users.${username} = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };

    home-manager = {
      extraSpecialArgs = { inherit inputs; };
      useGlobalPkgs = true;
      useUserPackages = true;

      users.${username} = {
        home.username = "bmyjacks";
        home.homeDirectory = "/home/bmyjacks";

        home.stateVersion = "25.11";
      };
    };
  };
}
