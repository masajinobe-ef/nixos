{ config, pkgs, lib, ... }:

{
  services.sing-box.enable = false;

  systemd.services.sing-box = {
    environment = {
      ENABLE_DEPRECATED_TUN_ADDRESS_X = "true";
    };
    serviceConfig = {
      Restart = "on-failure";
      RestartSec = "5s";
      DeviceAllow = "/dev/net/tun rw";
      # ExecStartPre = lib.mkForce [
      #   "${pkgs.iproute2}/bin/ip route del default via 192.168.0.1 dev enp42s0"
      #   "${pkgs.iproute2}/bin/ip route add default via 172.19.0.1 dev tun0 metric 0"
      # ];
      # ExecStopPost = lib.mkForce [
      #   "${pkgs.iproute2}/bin/ip route add default via 192.168.0.1 dev enp42s0 metric 0"
      #   "${pkgs.iproute2}/bin/ip route del default via 172.19.0.1 dev tun0"
      # ];
    };
    after = lib.mkForce [
     "network.target"
     # "sops-nix.service"
    ];
  };

  # sops.secrets = {
  #   sing-box-uuid = { };
  #   sing-box-public-key = { };
  #   sing-box-short-id = { };
  # };

  services.sing-box.settings = {
  dns = {
    independent_cache = true;
    rules = [
      {
        domain = [
          "access.temnomor.ru"
          "dns.google"
        ];
        server = "dns-direct";
      }
      {
        outbound = [ "any" ];
        server = "dns-direct";
      }
    ];
    servers = [
      {
        address = "https://dns.google/dns-query";
        address_resolver = "dns-direct";
        strategy = "ipv4_only";
        tag = "dns-remote";
      }
      {
        address = "https://223.5.5.5/dns-query";
        address_resolver = "dns-local";
        detour = "direct";
        strategy = "ipv4_only";
        tag = "dns-direct";
      }
      {
        address = "local";
        detour = "direct";
        tag = "dns-local";
      }
      {
        address = "rcode://success";
        tag = "dns-block";
      }
    ];
  };

  inbounds = [
    {
      domain_strategy = "";
      endpoint_independent_nat = true;
      inet4_address = [ "172.19.0.1/28" ];
      mtu = 1500;
      sniff = true;
      sniff_override_destination = false;
      stack = "gvisor";
      tag = "tun-in";
      type = "tun";
    }
    {
      domain_strategy = "";
      listen = "127.0.0.1";
      listen_port = 2080;
      sniff = true;
      sniff_override_destination = false;
      tag = "mixed-in";
      type = "mixed";
    }
  ];

  log.level = "info";

  outbounds = [
    {
      flow = "xtls-rprx-vision";
      packet_encoding = "";
      server = "access.temnomor.ru";
      server_port = 443;
      tls = {
        enabled = true;
        insecure = false;
        reality = {
          enabled = true;
          public_key = "";
          short_id = "";
        };
        server_name = "www.google.com";
        utls = {
          enabled = true;
          fingerprint = "chrome";
        };
      };
      uuid = "";
      type = "vless";
      domain_strategy = "prefer_ipv4";
      tag = "proxy";
    }
    {
      tag = "direct";
      type = "direct";
    }
    {
      tag = "bypass";
      type = "direct";
    }
  ];

  route = {
    auto_detect_interface = true;
    rule_set = [];
    rules = [
      {
        action = "hijack-dns";
        port = [ 53 ];
      }
      {
        action = "hijack-dns";
        protocol = [ "dns" ];
      }
      {
        action = "reject";
        ip_cidr = [
          "224.0.0.0/3"
          "ff00::/8"
        ];
        source_ip_cidr = [
          "224.0.0.0/3"
          "ff00::/8"
        ];
      }
    ];
  };
};
}
