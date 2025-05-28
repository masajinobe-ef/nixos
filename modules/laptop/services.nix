{ lib, ... }:

{
  services = {
    auto-cpufreq.enable = lib.mkAfter true;
    acpid.enable = lib.mkAfter true;
  };
}
