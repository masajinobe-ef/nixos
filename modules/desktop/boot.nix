{ pkgs, ... }:

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
    };
    kernelPackages = pkgs.linuxPackages_zen;
    kernelModules = [
      "tun"
      "tproxy"
    ];
    #blacklistedKernelModules = [ "r8169" ];
    supportedFilesystems = [
      "ntfs"
      "vfat"
      "fusefs"
    ];
    kernelParams = [
      "loglevel=4"
      "mitigations=off"
      "nmi_watchdog=0"
      "amd_pstate=active"
      "cpufreq.default_governor=performance"
      "ipv6.disable=1"
      "usbhid.mousepoll=1"
    ];
  };
}
