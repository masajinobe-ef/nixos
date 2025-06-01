{
  pkgs,
  ...
}:

{

  boot = {

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 2;
    };

    kernel.sysctl = {
      "user.max_user_namespaces" = 10000;
      "vm.swappiness" = 10;
      "vm.overcommit_memory" = 1;
      "fs.file-max" = 2097152;
    };

    kernelModules = [
      "tun"
      "tproxy"
    ];

    blacklistedKernelModules = [
      "sctp"
      "dccp"
      "rds"
      "tipc"
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
      "sctp"
      "dccp"
      "rds"
      "tipc"
      #"r8169"
    ];

    supportedFilesystems = [
      "ntfs"
      "vfat"
    ];

  };

}
