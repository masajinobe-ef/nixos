{
  lib,
  pkgs,
  ...
}:

{

  environment.systemPackages = lib.mkAfter (
    with pkgs;

    [
      kicad-small
    ]

  );

}
