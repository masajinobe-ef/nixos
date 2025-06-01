{ ... }:

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

    auditd.enable = true;
    audit.enable = true;
  };
}
