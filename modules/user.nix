{
  ...
}:

{

  users.users.masa = {
    isNormalUser = true;
    description = "masa";

    extraGroups = [

      "networkmanager"
      "wheel"
      "seat"
      "audio"
      "realtime"
      "input"
      "dialout"
      "docker"

    ];

    openssh.authorizedKeys.keys = [ "ssh-ed25519 ..." ];

  };

}
