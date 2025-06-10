{
  pkgs,
  lib,
  ...
}:

{

  boot = {

    kernelParams = lib.mkForce [

      "loglevel=4"
      "mitigations=off"

      "nmi_watchdog=0"
      "nowatchdog"

      "ipv6.disable=1"

      "intel_pstate=disable"
      "intel_iommu=off"
      "i915.enable_fbc=1"
      "intel_idle.max_cstate=5"
      "processor.max_cstate=5"

      "usbcore.autosuspend=1"
      "usbhid.mousepoll=1"

    ];

    initrd.kernelModules = lib.mkForce [

      "vfat"
      "i915"

    ];

    extraModprobeConfig = lib.mkForce ''

      options hid_apple fnmode=2 iso_layout=1
      options usbcore autosuspend=1
      options i915 enable_fbc=1

    '';

  };

}
