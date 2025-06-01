{ ... }:

{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 2;
    };
    kernel.sysctl = {
      "user.max_user_namespaces" = 10000;
      "net.ipv4.ip_unprivileged_port_start" = 0;
      "vm.swappiness" = 10;
      "vm.overcommit_memory" = 1;
      "fs.file-max" = 2097152;
    };
    kernelModules = [
      "tun"
      "tproxy"
    ];
    supportedFilesystems = [
      "ntfs"
      "vfat"
      "fusefs"
    ];
    initrd.kernelModules = [
      "vfat"
      "i915"
    ];
    kernelParams = [
      "loglevel=4"
      "mitigations=off"
      "nmi_watchdog=0"
      "ipv6.disable=1"
      "intel_pstate=disable"
      "intel_iommu=off"
      "i915.enable_fbc=1"
      "intel_idle.max_cstate=5"
      "processor.max_cstate=5"
      "usbcore.autosuspend=1"
      "usbhid.mousepoll=1"
    ];
    blacklistedKernelModules = [
      "ssb"
      "mmc_core"
      "b43"
      "brcmsmac"
      "brcmutil"
      "cordic"
      "mac80211"
      "bcma"
      "iTCO_wdt"
      "iTCO_vendor_support"
      #"r8169"
    ];
    extraModprobeConfig = ''
      options hid_apple fnmode=2 iso_layout=1
      options usbcore autosuspend=1
      options i915 enable_fbc=1
    '';
  };
}
