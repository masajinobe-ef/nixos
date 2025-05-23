{ lib, pkgs, ... }:

{
  environment.systemPackages = lib.mkAfter (
    with pkgs;
    [
      megasync
      #linuxKernel.packages.linux_zen.r8168
    ]
  );
}
