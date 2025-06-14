{ pkgs
, lib
, ...
}:
{
  boot = {
    kernelPackages = lib.mkForce pkgs.linuxPackages_zen;
    kernelParams = lib.mkForce [
      "loglevel=4"
      "mitigations=off"

      "nmi_watchdog=0"
      "nowatchdog"

      "amd_pstate=active"
      "cpufreq.default_governor=performance"

      "ipv6.disable=1"

      "usbhid.mousepoll=1"
    ];
    initrd.kernelModules = lib.mkForce [
      "vfat"
    ];
  };
}
