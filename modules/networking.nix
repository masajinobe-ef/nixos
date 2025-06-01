{
  ...
}:

{

  networking = {
    enableIPv6 = false;
    nftables.enable = false;

    networkmanager = {
      enable = true;
      unmanaged = [ ];
    };

    resolvconf.enable = true;
    resolvconf.dnsSingleRequest = true;
    nameservers = [
      "8.8.8.8"
      "8.8.4.4"
    ];

    firewall = {
      enable = true;
      checkReversePath = "loose";
      allowPing = false;
      logRefusedConnections = true;

      allowedTCPPorts = [
        80
        443
        33677
      ];

      allowedUDPPorts = [
        9
      ];

    };

  };

}
