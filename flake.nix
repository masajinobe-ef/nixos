{
  description = "Masa's NixOS Configuration";

  inputs = {
    # Stable NixOS
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    # Unstable channel for latest packages
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home manager for user configurations
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";

      # Base modules shared across all systems
      baseModules = [

        (
          { modulesPath, ... }:
          {
            imports = [
              (modulesPath + "/installer/scan/not-detected.nix")
              (
                if builtins.pathExists /etc/nixos/hardware-configuration.nix then
                  /etc/nixos/hardware-configuration.nix
                else
                  ./hardware/default.nix
              )
            ];
          }
        )

        ./modules/core.nix
        ./modules/services.nix
        ./modules/pkgs.nix
        ./modules/overlays.nix
        ./modules/env.nix
        ./modules/fonts.nix
      ];

      # Host-specific module paths
      hostModules = host: [
        ./modules/${host}/boot.nix
        ./modules/${host}/networking.nix
        ./modules/${host}/env.nix
        ./modules/${host}/pkgs.nix
        ./modules/${host}/services.nix
      ];

      # Common Home Manager configuration
      homeManagerModule = {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "backup";
          extraSpecialArgs = { inherit inputs nixpkgs-unstable; };
          users.masa = ./users/masa/home.nix;
        };
      };

      # System builder function
      mkSystem =
        hostName:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs self nixpkgs-unstable; };
          modules =
            baseModules
            ++ hostModules hostName
            ++ [ home-manager.nixosModules.home-manager ]
            ++ [ homeManagerModule ];
        };

    in
    {
      nixosConfigurations = {
        desktop = mkSystem "desktop";
        laptop = mkSystem "laptop";
      };
    };
}
