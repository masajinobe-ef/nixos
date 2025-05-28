{ lib, pkgs, ... }:

{
  environment.systemPackages = lib.mkAfter (
    with pkgs;
    [
      megasync
    ]
  );
}
