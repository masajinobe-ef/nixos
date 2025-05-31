{
  lib,
  inputs,
  pkgs,
  ...
}:

{
  nixpkgs.overlays = [
    (final: prev: {

      ayugram-desktop = inputs.nixpkgs-unstable.legacyPackages.${prev.system}.ayugram-desktop;

    })
  ];

  environment.systemPackages = lib.mkAfter (
    with pkgs;
    [
      ayugram-desktop
    ]
  );

}
