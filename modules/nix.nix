{ ...
}:
{
  system.stateVersion = "25.05";
  nixpkgs.config = {
    allowUnfree = true;
  };
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings = {
      auto-optimise-store = true;
      sandbox = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
}
