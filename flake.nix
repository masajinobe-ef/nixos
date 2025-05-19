{
  description = "Masa's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, sops-nix, ... }@inputs:
    let
      system = "x86_64-linux";
      commonModules = [
        #sops-nix.nixosModules.sops
        #./system/secrets.nix

        #./system/sing-box.nix
        #./system/zapret.nix

        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.masa = ./users/masa/home.nix;
            extraSpecialArgs = { inherit inputs; };
          };
        }
      ];
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
