{ pkgs, ... }:

{

  fonts = {

    enableDefaultPackages = true;

    packages = with pkgs; [

      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      nerd-fonts.jetbrains-mono
      times-newer-roman

    ];

    fontconfig = {
      enable = true;

      defaultFonts = {

        monospace = [ "JetBrainsMono Nerd Font" ];
        sansSerif = [ "Noto Sans" ];
        serif = [ "Noto Serif" ];

      };

    };

  };

}
