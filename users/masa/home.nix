{ ... }:

{
  home.username = "masa";
  home.homeDirectory = "/home/masa";
  home.enableNixpkgsReleaseCheck = false;
  home.stateVersion = "24.11";

  #home.packages = with pkgs; [ git ];

  programs.git = {
    enable = true;
    userName = "masajinobe-ef";
    userEmail = "priscilla.effects@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

  programs.ssh = {
    enable = true;
    extraConfig = ''
      User masa
      IdentityFile ~/.ssh/id_ed25519
      IdentitiesOnly yes
    '';
  };
}
