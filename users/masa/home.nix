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
    librewolf = {
        enable = true;
        settings = {
          "webgl.disabled" = false;
          "network.cookie.lifetimePolicy" = 0;
          "privacy.resistFingerprinting" = false;
          "privacy.clearOnShutdown.history" = false;
          "privacy.clearOnShutdown.cookies" = false;
          "privacy.donottrackheader.enabled" = true;
          "privacy.fingerprintingProtection" = true;
          "privacy.trackingprotection.emailtracking.enabled" = true;
          "privacy.trackingprotection.enabled" = true;
          "privacy.trackingprotection.fingerprinting.enabled" = true;
          "privacy.trackingprotection.socialtracking.enabled" = true;
          "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
          "privacy.clearOnShutdown_v2.cache" = false;
          "signon.rememberSignons" = true;
          "signon.autofillForms" = true;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "network.dns.disableIPv6" = true;
          "ui.key.menuAccessKeyFocuses" = false;
          "sidebar.verticalTabs" = true;
          "font.size.variable.x-western" = 16;
          "browser.startup.homepage" = "google.jp";
          "browser.urlbar.trimURLs" = false;
          "browser.uidensity" = 1;
          "browser.preferences.defaultPerformanceSettings.enabled" = true;
          "widget.gtk.overlay-scrollbars.enabled" = false;
        };
    };

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
        theme = "amuse";
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
