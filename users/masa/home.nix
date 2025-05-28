{
  pkgs,
  lib,
  ...
}:

{
  home.username = "masa";
  home.homeDirectory = "/home/masa";
  home.enableNixpkgsReleaseCheck = false;
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    oh-my-zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
  ];

  home.sessionVariables = {
    #
  };

  home.sessionPath = [
    "$HOME/.personal/sh"
    "$HOME/.local/bin"
    "$HOME/.local/scripts"
    "$HOME/.local/share"
  ];

  programs = {

    zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;

      history = {
        path = "$HOME/.zsh_history";
        size = 10000000;
        save = 10000000;
        extended = true;
        ignoreAllDups = true;
        ignoreSpace = true;
        share = true;
      };

      oh-my-zsh = {
        enable = true;
        theme = "ys";
        plugins = [
          "git"
        ];
      };

      initContent = ''
        # ------------------------------------------------------------------------------
        # TMUX CONFIGURATION
        # ------------------------------------------------------------------------------
        export TERM=screen-256color

        if [[ -z "$TMUX" ]] && command -v tmux &> /dev/null; then
          tmux attach -t default || tmux new -s default
        fi

        # ------------------------------------------------------------------------------
        # CUSTOM WIDGETS & KEYBINDINGS
        # ------------------------------------------------------------------------------
        tmux-sessionizer-widget() {
            zle clear-screen
            tmux-sessionizer
            zle reset-prompt
        }
        zle -N tmux-sessionizer-widget
        bindkey '^F' tmux-sessionizer-widget     # Ctrl+f

        yazi-widget() {
            local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
            ${pkgs.yazi}/bin/yazi "$@" --cwd-file="$tmp"
            if cwd="$(${pkgs.coreutils}/bin/cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
                builtin cd -- "$cwd"
            fi
            ${pkgs.coreutils}/bin/rm -f -- "$tmp"
        }
        zle -N yazi-widget
        bindkey '^Y' yazi-widget                 # Ctrl+y

        # Git push
        bindkey -s '^P' "clear; gitpush\n"       # Ctrl+p

        # Standard bindings
        bindkey '^I' expand-or-complete          # Tab
        bindkey '^U' accept-line                 # Ctrl+U
        bindkey '^L' autosuggest-accept          # Ctrl+L
        bindkey '^G' clear-screen                # Ctrl+G

        # ------------------------------------------------------------------------------
        # TOOL INITIALIZATIONS
        # ------------------------------------------------------------------------------
        eval "$(${pkgs.zoxide}/bin/zoxide init zsh)"

        # ------------------------------------------------------------------------------
        # CUSTOM SETTINGS
        # ------------------------------------------------------------------------------
        #PROMPT="%n@%m %~ %# "
        #RPROMPT=""
        zstyle ':completion:*' menu select
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
        zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
        zstyle ':completion:*' rehash true

        zmodload zsh/zprof
      '';

      shellAliases = {
        v = "nvim";
        sv = "sudo -E nvim";
        zc = "source ~/.zshrc";
        mv = "mv -v";
        rm = "rm -rfv";
        cp = "cp -rv";
        mkdir = "mkdir -pv";
        s = "clear; ${pkgs.eza}/bin/eza --long --header --icons=always --all --level=1 --group-directories-first --no-time";
        untar = "tar -xvvf";
        zz = "zip -r";
        uz = "unzip";
      };
    };

    git = {
      enable = true;
      userName = "masajinobe-ef";
      userEmail = "priscilla.effects@gmail.com";
      extraConfig = {
        # Initialization settings
        init.defaultBranch = "main";

        # Pull settings
        pull.rebase = true;

        # Credential helper
        credential.helper = "store";

        # Core settings
        core.autocrlf = "input";
        core.editor = "nvim";
        core.ignorecase = false;
        core.excludesfile = "~/.gitignore";

        # Format settings
        format.pretty = "oneline";

        # HTTP settings
        http.postBuffer = 157286400;
        http.version = "HTTP/2";

        # Color settings
        color.ui = "auto";
        color.status = "auto";
        color.diff = "auto";
        color.branch = "auto";
        color.interactive = "auto";
        color.grep = "auto";

        # Push settings
        push.default = "simple";

        # Aliases
        alias.a = "add .";
        alias.c = "commit -a";
        alias.ps = "!git push origin $(git rev-parse --abbrev-ref HEAD)";
        alias.pl = "!git pull origin $(git rev-parse --abbrev-ref HEAD)";
        alias.st = "status";
        alias.sub = "submodule";
        alias.br = "branch";
        alias.ba = "branch -a";
        alias.bm = "branch --merged";
        alias.bn = "branch --no-merged";
        alias.d = "diff";
        alias.df = ''!git log --pretty=format:"%h %cd [%cn] %s%d" --date=relative | fzf | awk '{print $1}' | xargs -I {} git diff {}^ {}'';
        alias.h = ''log --pretty=format:"%Cgreen%h %Creset%cd %Cblue[%cn] %Creset%s%C(yellow)%d%C(reset)" --graph --date=relative --decorate --all'';
        alias.l = ''log --graph --name-status --pretty=format:"%C(red)%h %C(reset)(%cd) %C(green)%an %Creset%s %C(yellow)%d%Creset" --date=relative'';
        alias.editmerge = "!f() { git ls-files --unmerged | cut -f2 | sort -u ; }; nvim `f`";
        alias.addmerge = "!f() { git ls-files --unmerged | cut -f2 | sort -u ; }; git add `f`";
      };
    };

    ssh = {
      enable = true;
      extraConfig = ''
        User masa
        IdentityFile ~/.ssh/id_ed25519
        IdentitiesOnly yes
      '';
    };

    firefox = {
      enable = true;
      profiles.default = {
        id = 0;
        settings = {

          # General browser settings
          "browser.startup.homepage" = "google.jp";
          "browser.newtabpage.enabled" = false;
          "browser.search.region" = "US";
          "browser.search.openintab" = true;
          "browser.tabs.loadBookmarksInTabs" = true;
          "browser.aboutConfig.showWarning" = false;

          # Privacy and security
          "privacy.resistFingerprinting" = true;
          "browser.safebrowsing.malware.enabled" = false;
          "browser.safebrowsing.phishing.enabled" = false;
          "browser.contentblocking.category" = "standard";

          # Address bar suggestions
          "browser.urlbar.suggest.quicksuggest.sponsored" = false;
          "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
          "browser.urlbar.suggest.trending" = false;

          # Graphics acceleration
          "gfx.webrender.all" = true;
          "layers.acceleration.force-enabled" = true;

          # DRM content
          "media.eme.enabled" = true;

          # Disable telemetry
          "toolkit.telemetry.unified" = false;
          "datareporting.healthreport.uploadEnabled" = false;

          # Interface customization
          "general.autoScroll" = true;
          "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
          "browser.uidensity" = 1;
          "ui.key.menuAccessKeyFocuses" = false;
          "browser.tabs.tabMinWidth" = 50;
          "sidebar.verticalTabs" = true;

          # Additional useful flags
          "browser.download.useDownloadDir" = false;
          "browser.tabs.warnOnClose" = false;
          "extensions.pocket.enabled" = false;
          "browser.urlbar.trimURLs" = false;
          "browser.tabs.loadInBackground" = true;
          "browser.sessionstore.interval" = 600000;
          "full-screen-api.warning.timeout" = 0;
          "full-screen-api.transition-duration.enter" = "0 0";
          "full-screen-api.transition-duration.leave" = "0 0";

        };
      };
    };

    alacritty = {
      enable = true;
      settings = {
        window = {
          opacity = 0.98;
          padding = {
            x = 1;
            y = 0;
          };
          dynamic_padding = true;
        };

        terminal.shell.program = "/run/current-system/sw/bin/zsh";

        font = {
          size = 14;
          normal = {
            family = "JetbrainsMono Nerd Font";
            style = "Regular";
          };
          bold = {
            family = "JetbrainsMono Nerd Font";
            style = "Bold";
          };
          italic = {
            family = "JetbrainsMono Nerd Font";
            style = "italic";
          };
          bold_italic = {
            family = "JetbrainsMono Nerd Font";
            style = "Bold Italic";
          };
        };

        debug.log_level = "Warn";

        colors = {
          primary = {
            background = "#000000";
            foreground = "#ffffff";
          };
          cursor = {
            text = "#F81CE5";
            cursor = "#ffffff";
          };
          normal = {
            black = "#000000";
            red = "#fe0100";
            green = "#33ff00";
            yellow = "#feff00";
            blue = "#0066ff";
            magenta = "#cc00ff";
            cyan = "#00ffff";
            white = "#d0d0d0";
          };
          bright = {
            black = "#808080";
            red = "#fe0100";
            green = "#33ff00";
            yellow = "#feff00";
            blue = "#0066ff";
            magenta = "#cc00ff";
            cyan = "#00ffff";
            white = "#FFFFFF";
          };
        };
      };
    };

  };
}
