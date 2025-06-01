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
      "vm.swappiness" = 10;
      "vm.overcommit_memory" = 1;
      "fs.file-max" = 2097152;

      "kernel.kptr_restrict" = 2;
      "net.ipv4.conf.all.rp_filter" = 1;
      "net.ipv4.icmp_echo_ignore_broadcasts" = 1;
    };

    kernelPackages = pkgs.linuxPackages_zen;

    kernelModules = [
      "tun"
      "tproxy"
    ];

    blacklistedKernelModules = [
      "sctp"
      "dccp"
      "rds"
      "tipc"
    ];

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
