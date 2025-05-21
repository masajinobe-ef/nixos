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

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      sops-nix,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      commonModules = [

        #./modules/custom/secrets.nix

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
        (
          { config, pkgs, ... }:
          {

            nixpkgs.overlays = [

              (final: prev: {
                sing-box = prev.stdenv.mkDerivation rec {
                  pname = "sing-box";
                  version = "1.11.7";
                  src = builtins.fetchTarball {
                    url = "https://github.com/SagerNet/sing-box/releases/download/v${version}/sing-box-${version}-linux-amd64.tar.gz";
                    sha256 = "1gmgj1bpakdpwwpaj2zjy33mgjbvf3zi2wssbcmqnih5qlh2mhza";
                  };
                  nativeBuildInputs = [ prev.autoPatchelfHook ];
                  sourceRoot = ".";
                  dontConfigure = true;
                  dontBuild = true;
                  installPhase = ''
                    install -Dm755 */sing-box $out/bin/sing-box
                  '';
                  meta = {
                    description = "A high-performance proxy for various protocols.";
                    homepage = "https://github.com/SagerNet/sing-box";
                    license = prev.lib.licenses.mit;
                    mainProgram = "sing-box";
                  };
                };

              })
            ];

            # Packages
            environment.systemPackages = with pkgs; [
              nixpkgs-unstable.legacyPackages.${config.nixpkgs.system}.ayugram-desktop
              sing-box
            ];

            # Font
            fonts.packages = with nixpkgs-unstable.legacyPackages.${config.nixpkgs.system}; [
              nerd-fonts.jetbrains-mono
            ];
          }
        )
      ];

    in
    # Desktop & Laptop
    {
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
