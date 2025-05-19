{ ... }:

{
  imports = [
    # Shared
    ../modules/shared/core.nix
    ../modules/shared/services.nix
    ../modules/shared/pkgs.nix
    ../modules/shared/env.nix

    # Laptop
    ../hosts/laptop/default.nix
    ../modules/laptop/boot.nix
    ../modules/laptop/env.nix
    ../modules/laptop/pkgs.nix
    ../modules/laptop/networking.nix
    ../modules/laptop/services.nix

    # Custom
    #./modules/sing-box.nix
    #./modules/zapret.nix
  ];

  system.stateVersion = "24.11";
}

