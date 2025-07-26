{ ...
}:
{
  networking = {
    networkmanager.enable = true;
    enableIPv6 = false;
    nftables.enable = false;
    useDHCP = false;
    resolvconf.enable = false;
    resolvconf.dnsSingleRequest = true;
    nameservers = [ "8.8.8.8" "8.8.4.4" ];
    firewall = {
      enable = false;
      checkReversePath = "loose";
      allowPing = false;
      logRefusedConnections = true;
      allowedTCPPorts = [
        6668
      ];
      allowedUDPPorts = [
        9
      ];
    };
  };
}
