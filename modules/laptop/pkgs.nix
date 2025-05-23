{ lib, pkgs, ... }:

{
  environment.systemPackages = lib.mkAfter (
    with pkgs;
    [
      auto-cpufreq
      brightnessctl
    ]
  );
}
