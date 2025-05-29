{
  lib,
  inputs,
  pkgs,
  ...
}:

{
  nixpkgs.overlays = [
    (final: prev: {
      inherit (inputs.nixpkgs-unstable.legacyPackages.${prev.system})
        ayugram-desktop
        ;
    })
  ];

  environment.systemPackages = lib.mkAfter (
    with pkgs;
    [
      ayugram-desktop
    ]
  );
}
