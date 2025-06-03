{ ... }:

{

  services = {

    openssh = {
      enable = true;
      ports = [ 33677 ];

      settings = {
        ListenAddress = "0.0.0.0";
        AddressFamily = "inet";
        Protocol = 2;
        SyslogFacility = "AUTH";
        LogLevel = "VERBOSE";
        KexAlgorithms = [ "curve25519-sha256" ];
        Ciphers = [ "chacha20-poly1305@openssh.com" "aes256-gcm@openssh.com" ];
        Macs = [ "hmac-sha2-512-etm@openssh.com" ];
        PermitRootLogin = "no";
        PubkeyAuthentication = true;
        AuthenticationMethods = "publickey";
        PasswordAuthentication = false;
        PermitEmptyPasswords = false;
        UsePAM = false;
        LoginGraceTime = 30;
        MaxAuthTries = 3;
        ClientAliveCountMax = 2;
        AllowTcpForwarding = false;
        AllowAgentForwarding = false;
        X11Forwarding = false;
        PermitTunnel = "no";
        GatewayPorts = "no";
        Subsystem = "sftp internal-sftp";
      };

    };

    fail2ban = {
      enable = false;
      maxretry = 6;
      bantime = "1h";
    };

    dbus.enable = true;

    xserver = {
      enable = true;

      displayManager = {
        gdm = {
          enable = true;
          wayland = true;
        };
        defaultSession = "sway";
      };

    };

    resolved.enable = false;

    libinput.enable = true;

    fstrim.enable = true;

    gnome.gnome-keyring.enable = true;
  };

}
