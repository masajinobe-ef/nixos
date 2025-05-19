{ config, lib, pkgs, ... }:

let
  # Define the hostlist content
  hostlist = ''
    googlevideo.com
    youtu.be
    youtube.com
    youtubei.googleapis.com
    youtubeembeddedplayer.googleapis.com
    ytimg.l.google.com
    ytimg.com
    jnn-pa.googleapis.com
    youtube-nocookie.com
    youtube-ui.l.google.com
    yt-video-upload.l.google.com
    wide-youtube.l.google.com
    youtubekids.com
    ggpht.com
    discord.com
    gateway.discord.gg
    cdn.discordapp.com
    discordapp.net
    discordapp.com
    discord.gg
    media.discordapp.net
    images-ext-1.discordapp.net
    discord.app
    discord.media
    discordcdn.com
    discord.dev
    discord.new
    discord.gift
    discordstatus.com
    dis.gd
    discord.co
    discord-attachments-uploads-prd.storage.googleapis.com
    7tv.app
    7tv.io
    10tv.app
    cloudflare-ech.com
    frankerfacez.com
    betterttv.net
    cdn.betterttv.net
  '';

  # Parameters for nfqws based on NFQWS_OPT from the shell config
  nfqwsParams = [
    "--filter-udp=50000-50100"
    "--filter-l7=discord,stun"
    "--dpi-desync=fake"
    "--new"
    "--filter-udp=53-65535"
    "--filter-l7=wireguard"
    "--dpi-desync=fake"
    "--dpi-desync-repeats=11"
    "--dpi-desync-fake-unknown-udp=/opt/zapret/files/fake/wireguard_initiation.bin"
    "--new"
    "--filter-udp=443"
    "--hostlist=/etc/zapret/hostlists/list-general.txt"
    "--dpi-desync=fake"
    "--dpi-desync-repeats=6"
    "--dpi-desync-fake-quic=/opt/zapret/files/fake/quic_initial_www_google_com.bin"
    "--new"
    "--filter-tcp=80"
    "--hostlist=/etc/zapret/hostlists/list-general.txt"
    "--dpi-desync=fake,split2"
    "--dpi-desync-autottl=2"
    "--dpi-desync-fooling=md5sig"
    "--new"
    "--filter-tcp=443"
    "--hostlist=/etc/zapret/hostlists/list-general.txt"
    "--dpi-desync=fake,split"
    "--dpi-desync-autottl=2"
    "--dpi-desync-repeats=6"
    "--dpi-desync-fooling=badseq"
    "--dpi-desync-fake-tls=/opt/zapret/files/fake/tls_clienthello_www_google_com.bin"
  ];

in {
  # Ensure required directories and files are created
  environment.etc."zapret/hostlists/list-general.txt".text = hostlist;

  # Zapret service configuration
  services.zapret = {
    enable = true;
    configureFirewall = false; # Manage firewall rules externally
    udpPorts = [ "443" "50000-65535" ];
    tcpPorts = [ "80" "443" ];
    params = nfqwsParams;
  };

  # Systemd service configuration
  systemd.services.zapret = {
    description = "DPI bypass service";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    path = [ pkgs.zapret ]; # Ensure zapret is in PATH

    serviceConfig = {
      ExecStart = "${pkgs.zapret}/bin/nfqws --pidfile=/run/nfqws.pid ${
          lib.escapeShellArgs nfqwsParams
        } --qnum=1";
      Type = "simple";
      PIDFile = "/run/nfqws.pid";
      Restart = "always";
      RuntimeMaxSec = "1h";

      # Environment variables from shell config
      Environment = [
        "FWTYPE=iptables"
        "DISABLE_IPV6=1"
        "NFQWS_TCP_PKT_OUT=9" # 6 + AUTOHOSTLIST_RETRANS_THRESHOLD(3)
        "NFQWS_TCP_PKT_IN=3"
        "NFQWS_UDP_PKT_OUT=9"
        "NFQWS_UDP_PKT_IN=0"
      ];

      # Security sandboxing
      DevicePolicy = "closed";
      ProtectSystem = "strict";
      ProtectHome = "read-only";
      PrivateTmp = true;
      PrivateDevices = true;
      NoNewPrivileges = true;
      RestrictSUIDSGID = true;
      RestrictAddressFamilies = [ "AF_INET" "AF_INET6" "AF_NETLINK" ];
    };
  };

  # # Optional: If fake files need to be deployed
  # system.activationScripts.zapret-fake-files = ''
  #   mkdir -p /opt/zapret/files/fake
  #   # Replace with actual paths to your fake files
  #   cp ${./fake-files/*} /opt/zapret/files/fake/
  # '';
}
