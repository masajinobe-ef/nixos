{ ... }:

{
  home.username = "masa";
  home.homeDirectory = "/home/masa";
  home.enableNixpkgsReleaseCheck = false;
  home.stateVersion = "24.11";

  #home.packages = with pkgs; [ git ];
  #sops.secrets = { github_token = { }; };

  programs.git = {
    enable = true;
    userName = "masajinobe-ef";
    userEmail = "priscilla.effects@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      #   credential.helper = "${
      #       pkgs.git.override { withLibsecret = true; }
      #     }/bin/git-credential-libsecret";
      # };
      # extraConfig.credential = {
      #   "https://github.com".username = "masajinobe-ef";
      #   "https://github.com".helper = ''
      #     !f() { echo "password=$(cat ${config.sops.secrets.github_token.path})"; }; f'';
      # };
    };
  };
}
