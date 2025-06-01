{ ... }:

{
  services = {
    dbus.enable = true;
    gvfs.enable = true;
    gnome.gnome-keyring.enable = true;
    seatd.enable = true;
    libinput.enable = true;
    fstrim.enable = true;
    openssh = {
      enable = true;
      ports = [ 33677 ];
      settings = {
        AddressFamily = "inet";
        Protocol = 2;
        SyslogFacility = "AUTH";
        LogLevel = "VERBOSE";
        KexAlgorithms = [ "curve25519-sha256" ];
        Ciphers = [
          "chacha20-poly1305@openssh.com"
          "aes256-gcm@openssh.com"
        ];
        Macs = [ "hmac-sha2-512-etm@openssh.com" ];
        PermitRootLogin = "no";
        PubkeyAuthentication = true;
        AuthenticationMethods = "publickey";
        PasswordAuthentication = false;
        PermitEmptyPasswords = false;
        UsePAM = true;
        LoginGraceTime = 60;
        MaxAuthTries = 3;
        ClientAliveInterval = 600;
        ClientAliveCountMax = 2;
        AllowTcpForwarding = false;
        AllowAgentForwarding = false;
        X11Forwarding = false;
        PermitTunnel = false;
        Subsystem = "sftp internal-sftp";
      };
    };
    fail2ban = {
      enable = true;
      maxretry = 6;
      bantime = "1h";
    };
    resolved = {
      enable = false;
      dnssec = "allow-downgrade";
      fallbackDns = [ "8.8.8.8" ];
      domains = [ "~." ];
    };
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
  };
}
