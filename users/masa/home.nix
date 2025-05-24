{ config, pkgs, ... }:

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
    #ENABLE_DEPRECATED_TUN_ADDRESS_X = "true";
  };

  home.sessionPath = [
    "$HOME/.personal/sh"
    "$HOME/.local/bin"
    "$HOME/.local/scripts"
    "$HOME/.local/share"
  ];

  programs = {
    # firefox = {
    #   enable = true;
    #   profiles = {
    #     default = {
    #       id = 0;
    #       name = "default";
    #       isDefault = true;
    #       settings = {
    #         "browser.uidensity" = 1;
    #       };
    #     };
    #   };
    # };

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
        theme = "robbyrussell";
        plugins = [
          "git"
          "fzf"
          "tmux"
        ];
      };

      initContent = ''
        # ------------------------------------------------------------------------------
        # TMUX CONFIGURATION
        # ------------------------------------------------------------------------------
        export TERM=$ZSH_TMUX_TERM

        if [[ -z "$TMUX" ]] && command -v tmux &> /dev/null; then
          tmux attach -t default || tmux new -s default
        fi

        # ------------------------------------------------------------------------------
        # PROMPT CONFIGURATION
        # ------------------------------------------------------------------------------
        autoload -Uz colors && colors
        typeset -gA fg
        fg[love]=$'\e[31m'        # red
        fg[gold]=$'\e[33m'        # yellow
        fg[iris]=$'\e[34m'        # blue
        fg[foam]=$'\e[36m'        # cyan
        fg[rose]=$'\e[35m'        # magenta
        fg[pine]=$'\e[32m'        # green

        # Prompt hooks
        add-zsh-hook precmd set_prompt

        set_prompt() {
            DIR_PROMPT="%F{cyan}%(4~|%2~|%3~)%f"
            PROMPT="$DIR_PROMPT %(?.%F{green}❯%f.%F{red}❯%f) "
        }

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

        nvim-widget() {
            zle clear-screen
            nvim
            zle reset-prompt
        }
        zle -N nvim-widget
        bindkey '^N' nvim-widget                 # Ctrl+n

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
      '';

      shellAliases = {
        v = "nvim";
        sv = "sudo -E nvim";
        svim = "sudo -E nvim";
        zc = "source ~/.zshrc";
        mv = "mv -vi";
        rm = "rm -rvi";
        cp = "cp -rvi";
        mkdir = "mkdir -pv";
        s = "clear; ${pkgs.eza}/bin/eza --long --header --icons=always --all --level=1 --group-directories-first --no-time";
        l = "s";
        ls = "s";
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
  };
}
