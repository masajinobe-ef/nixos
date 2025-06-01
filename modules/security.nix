{ ... }:

{
  security = {
    pam.services = {
      gdm.enableGnomeKeyring = true;
    };
    polkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };
}
