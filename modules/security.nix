{
  ...
}:

{

  security = {

    pam.sshAgentAuth.enable = true;
    pam.services = {
      gdm.enableGnomeKeyring = true;
    };

    polkit.enable = true;
    sudo.wheelNeedsPassword = false;

    virtualisation.flushL1DataCache = "always";
    protectKernelImage = true;

    auditd.enable = false;
    audit.enable = false;

    rtkit.enable = true;

    pam.loginLimits = [

      {
        domain = "@realtime";
        type = "-";
        item = "rtprio";
        value = "99";
      }

      {
        domain = "@realtime";
        type = "-";
        item = "memlock";
        value = "unlimited";
      }

      {
        domain = "*";
        type = "soft";
        item = "nofile";
        value = "65536";
      }

      {
        domain = "*";
        type = "hard";
        item = "nofile";
        value = "65536";
      }

    ];

  };

  systemd.extraConfig = ''
    DefaultLimitNOFILE=65536
  '';

  systemd.user.extraConfig = ''
    DefaultLimitNOFILE=65536
  '';

}
