{ ... }:

{
  imports = [
    # Shared
    ../modules/shared/core.nix
    ../modules/shared/services.nix
    ../modules/shared/pkgs.nix
    ../modules/shared/env.nix

    # Include hardware configuration
    /etc/nixos/hardware-configuration.nix

    # Desktop
    ../modules/desktop/boot.nix
    ../modules/desktop/env.nix
    ../modules/desktop/pkgs.nix
    ../modules/desktop/networking.nix
    ../modules/desktop/services.nix
  ];

  system.stateVersion = "24.11";
}
