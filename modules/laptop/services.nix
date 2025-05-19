{ lib, ... }:

{
  #services = lib.mkAfter { auto-cpufreq.enable = true; };
}
