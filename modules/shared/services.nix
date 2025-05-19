{ ... }:

{
  services = {
    openssh = {
      enable = true;
      ports = [ 33677 ];
      settings = {
        IdentityFile = "~/.ssh/id_ed25519";
        IdentitiesOnly = "yes";
        AddressFamily = "inet";
        Protocol = 2;
        SyslogFacility = "AUTH";
        LogLevel = "VERBOSE";
        KexAlgorithms = [ "curve25519-sha256" ];
        Ciphers = [ "chacha20-poly1305@openssh.com" "aes256-gcm@openssh.com" ];
        Macs = [ "hmac-sha2-512-etm@openssh.com" ];
        PermitRootLogin = "prohibit-password";
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
        X11Forwarding = false;
        PermitTunnel = false;
        Subsystem = "sftp internal-sftp";
      };
    };

    #v2ray.enable = true;
    #v2raya.enable = true;
    #zapret.enable = true;
    resolved.enable = true;

    xserver = {
      enable = true;
      displayManager = {
        gdm = {
          enable = true;
          wayland = true;
          settings = { };
        };
        defaultSession = "sway";
      };
    };

    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };

    dbus.enable = true;
    gvfs.enable = true;
    gnome.gnome-keyring.enable = true;
    seatd.enable = true;
    libinput.enable = true;

    fstrim.enable = true;
  };
}
