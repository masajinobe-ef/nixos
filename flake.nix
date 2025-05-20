{
  description = "Masa's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, sops-nix, ... }@inputs:
    let
      system = "x86_64-linux";
      commonModules = [

        # Home Manager
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.masa = ./users/masa/home.nix;
            extraSpecialArgs = { inherit inputs; };
          };
        }

        # Unstable packages
        ({ config, pkgs, ... }: {

            # Font
            fonts.packages = with nixpkgs-unstable.legacyPackages.${config.nixpkgs.system}; [
              nerd-fonts.jetbrains-mono
            ];

            # Packages
          environment.systemPackages = with pkgs; [
            nixpkgs-unstable.legacyPackages.${config.nixpkgs.system}.ayugram-desktop
        ];
        })
      ];

    # Desktop & Laptop
    in {
      nixosConfigurations = {

        desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./system/desktop.nix ] ++ commonModules;
          specialArgs = { inherit self inputs; };
        };

        laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./system/laptop.nix ] ++ commonModules;
          specialArgs = { inherit self inputs; };
        };
      };
    };
}
