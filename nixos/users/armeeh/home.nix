{
  pkgs,
  lib,
  expert,
  llm-nix,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "armeeh";
  home.homeDirectory = "/home/armeeh";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    efm-langserver
    jq
    nodejs_20
    yarn
    # nodePackages.typescript-language-server
    vtsls
    typescript-go
    eslint_d
    eslint
    prettierd
    stylua
    lua-language-server
    nil
    atool
    unzip
    zip
    # cmake-language-server
    # ccls
    # clang-tools
    yaml-language-server
    vscode-langservers-extracted
    tailwindcss-language-server
    nixfmt
    delta
    haskell.compiler.ghc912
    haskell.packages.ghc912.haskell-language-server
    haskell.packages.ghc912.hlint
    cabal-install
    # frozenDevenv.devenv
    devenv
    beamMinimal28Packages.elixir_1_19
    beamMinimal28Packages.elixir-ls
    expert.outputs.packages.${stdenv.hostPlatform.system}.expert
    # lldb # Debugging for C3
    pgformatter

    # qgis # Working with geo data
    # llm shit
    snip
    llm-nix.outputs.packages.${stdenv.hostPlatform.system}.claude-code
    llm-nix.outputs.packages.${stdenv.hostPlatform.system}.claude-code-acp
    # llm-nix.outputs.packages.${stdenv.hostPlatform.system}.oh-my-opencode
    llm-nix.outputs.packages.${stdenv.hostPlatform.system}.opencode
  ];

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".gtkrc-2.0".text = ''
      gtk-cursor-theme-name="Adwaita"
    '';
    ".config/gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-cursor-theme-name=Adwaita
    '';
    ".xinitrc".text = ''
      xrandr --auto
      [[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
      ${pkgs.kdePackages.kwallet-pam}/libexec/pam_kwallet_init
      exec dwm
    '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/armeeh/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "16";
  };
  home.sessionPath = [
    "$HOME/Pkg/c3c/bin"
    "$HOME/.yarn/bin"
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.pointerCursor = {
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
    size = 16;

    gtk.enable = true;
    x11.enable = true;
  };

  # Setup ZSH
  programs.zsh = {
    enable = true;
    autocd = true;
    enableVteIntegration = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    shellAliases = {
      rm = "rm -i";
      ll = "ls -la";
      y = "yarn";
      g = "git";
      yS = "yarn $(jq -r '.scripts | keys | .[]' < package.json | fzy)";
      cleanservices = "rm -rf packages/*/dist(N) packages/*/tsconfig.build.tsbuildinfo(N) services/*/build(N) services/*/tsconfig.build.tsbuildinfo(N) functions/*/build(N) functions/*/tsconfig.build.tsbuildinfo(N) && yarn && yarn lerna run build --concurrency 2";
      e = "$EDITOR";
      fzfe = "git ls-files --cached --modified --other --exclude-standard --deduplicate | fzy | xargs $EDITOR";
      btcn = "bluetoothctl devices | fzy | sed -e 's/Device //' -e 's/ .*//' | xargs bluetoothctl connect ";
      repo = "cd `realpath ~/Projects/*/*(/) | fzy`";
      gse = "git ls-files --modified --exclude-standard | fzy | xargs $EDITOR";
    };
    initContent = lib.mkMerge [
      (lib.mkBefore ''
        (( ''${+commands[direnv]} )) && emulate zsh -c "$(direnv export zsh)"

        if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi

        (( ''${+commands[direnv]} )) && emulate zsh -c "$(direnv hook zsh)"

        source ~/.p10k.zsh
      '')
      (lib.mkAfter ''
        setopt HIST_IGNORE_ALL_DUPS
        setopt INC_APPEND_HISTORY

        autoload -U up-line-or-beginning-search
        autoload -U down-line-or-beginning-search
        zle -N up-line-or-beginning-search
        zle -N down-line-or-beginning-search
        bindkey -e
        bindkey "^[[A" up-line-or-beginning-search # Up
        bindkey "^[OA" up-line-or-beginning-search # Up
        bindkey "^[[B" down-line-or-beginning-search # Down
        bindkey "^[OB" down-line-or-beginning-search # Down
        bindkey "^[[1;5C" forward-word
        bindkey "^[[1;5D" backward-word

        autoload -U edit-command-line
        zle -N edit-command-line
        bindkey '^xe' edit-command-line

        include () {
          [[ -f "$1" ]] && source "$1"
        }

        mongo_uri_to_user_and_pass () {
          user_and_pass=''${''${''${1#*://}%%@*}:/:}
          parts=(''${(@s/:/)user_and_pass})
          MONGODB_USERNAME=$parts[1] MONGODB_PASSWORD=$parts[2] ''${@:2}
        }

        local term_title () { print -n "\e]0;''${(j: :q)@}\a" }
        precmd () {
          local DIR="''$(print -P '[%c]')"
          term_title "$DIR" "zsh"
        }
        preexec () {
          local DIR="''$(print -P '[%c]')"
          local CMD="''${(j:\n:)''${(f)1}}"
          term_title "''$DIR" "''$CMD"
        }

        include '/home/armeeh/.env'
      '')
    ];

    history = {
      expireDuplicatesFirst = true;
      ignoreSpace = true;
      ignoreDups = true;
      share = false;
      size = 10000;
    };

    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
        { name = "b4b4r07/enhancd"; } # Enhance CD!
        {
          name = "romkatv/powerlevel10k";
          tags = [
            "as:theme"
            "depth:1"
          ];
        } # Theme
      ];
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = false;
  };

  programs.kitty = {
    enable = true;
    shellIntegration = {
      enableZshIntegration = true;
    };
    settings = {
      cursor_shape = "block";
      font_family = "Iosevka";
      background = "#1d1f21";
      foreground = "#c5c8c6";
      cursor_blink_interval = 0;
    };
    keybindings = {
      "ctrl+shift+t" = "new_tab";
      "ctrl+shift+q" = "close_tab";
      "ctrl+tab" = "next_tab";
      "ctrl+shift+tab" = "previous_tab";
    };
    extraConfig = ''
      symbol_map U+23FB-U+23FE,U+2665,U+26A1,U+2B58,U+E000-U+E00A,U+E0A0-U+E0A3,U+E0B0-U+E0D4,U+E200-U+E2A9,U+E300-U+E3E3,U+E5FA-U+E6AA,U+E700-U+E7C5,U+EA60-U+EBEB,U+F000-U+F2E0,U+F300-U+F32F,U+F400-U+F4A9,U+F500-U+F8FF,U+F0001-U+F1AF0 Symbols Nerd Font Mono

      background_opacity 0.9
    '';
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    defaultCacheTtl = 28800;
    defaultCacheTtlSsh = 28800;
    maxCacheTtl = 28800;
    maxCacheTtlSsh = 28800;
    pinentry.package = pkgs.pinentry-gtk2;
  };

  services.fusuma = {
    enable = true;
    package = pkgs.fusuma;
    settings = {
      threshold = {
        pinch = 0.4;
      };
      interval = {
        pinch = 0.1;
      };
      pinch = {
        "out" = {
          command = "xdotool keydown ctrl click 4 && xdotool keyup ctrl";
        };
        "in" = {
          command = "xdotool keydown ctrl click 5 && xdotool keyup ctrl";
        };
      };
    };
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    mouse = true;
    shortcut = "t";
    terminal = "screen-256color";
  };

  programs.difftastic = {
    enable = true;
    git.enable = true;
  };

  programs.git = {
    enable = true;

    # Enforce new signing format
    signing.format = null;
    settings = {
      user.name = "Tomas Kallup";
      user.email = "t.kallup@gmail.com";

      core = {
        editor = "$EDITOR";
        pager = "delta";
      };
      pull = {
        rebase = true;
        autoSetupRemote = true;
      };
      rebase = {
        autoStash = true;
      };
      merge = {
        tool = "nvimdiff";
      };
      mergetool = {
        keepBackup = false;
      };
      "mergetool \"nvimdiff\"" = {
        cmd = "nvim -d \"$LOCAL\" \"$REMOTE\" \"$MERGED\" -c 'wincmd w' -c 'wincmd w' -c 'wincmd J'";
      };
      push = {
        autoSetupRemote = true;
      };
      diff = {
        algorithm = "patience";
      };
      delta = {
        lineNumbers = true;
        navigate = true;
        dark = true;
      };
      init = {
        defaultBranch = "master";
      };
      interactive = {
        diffFilter = "delta --color-only";
      };
      branch = {
        autoSetupMerge = "simple";
      };

      alias = {
        bcleanup = "!git fetch --prune && git branch --merged | grep -E -v \"(^\\*|\\+|master|develop|staging)\" > /tmp/git-branch-cleanup && $EDITOR /tmp/git-branch-cleanup && cat /tmp/git-branch-cleanup | xargs git branch -d";
        pbcleanup = "!git fetch --prune && git branch -vv | grep ': gone]' | sed \"s/^\\s\\+\\([^ ]\\+\\).*/\\1/\" | grep -E -v \"(^\\*|master|develop|staging)\" > /tmp/git-branch-cleanup && $EDITOR /tmp/git-branch-cleanup && cat /tmp/git-branch-cleanup | xargs git branch -D";
        rbcleanup = "!git fetch --prune && git branch -r --merged | grep -E -v \"(^\\*|\\+|master|develop|staging)\" > /tmp/git-branch-cleanup && $EDITOR /tmp/git-branch-cleanup && sed -i \"\" \"s/origin\\///\" /tmp/git-branch-cleanup && cat /tmp/git-branch-cleanup | xargs git push origin --delete";
        a = "add";
        ac = "!git diff --name-only --diff-filter=U | xargs git add";
        ap = "add -p";
        c = "commit";
        ch = "checkout";
        cm = "commit -m";
        d = "diff";
        f = "fetch";
        r = "reset";
        rh = "reset HEAD";
        rb = "rebase";
        rbc = "rebase --continue";
        rba = "rebase --abort";
        rbs = "rebase --skip";
        s = "status -sb";
        st = "stash";
        sta = "stash apply";
        p = "push";
        pf = "push --force-with-lease";
        pl = "pull";
        mt = "mergetool";
        fixc = "!$EDITOR `git diff --name-only --diff-filter=U`";
        bi = "!git branch | sed '/HEAD/d' | sed -e 's/*\\?\\s\\+\\(remotes\\/origin\\/\\)\\?//' | fzy | xargs -r git checkout";
        bia = "!git branch -a | sed '/HEAD/d' | sed -e 's/*\\?\\s\\+\\(remotes\\/origin\\/\\)\\?//' | fzy | xargs -r git checkout";
        lg = "log --format='%C(auto) %h %s'";
      };
    };
  };

  systemd.user.targets = {
    dwl-session = {
      Unit = {
        Description = "dwl compositor session";
        Documentation = "man:systemd.special(7)";
        BindsTo = "graphical-session.target";
        Wants = "graphical-session-pre.target";
        After = "graphical-session-pre.target";
      };
    };
    dwm-session = {
      Unit = {
        Description = "dwm session";
        Documentation = "man:systemd.special(7)";
        BindsTo = "graphical-session.target";
        Wants = "graphical-session-pre.target";
        After = "graphical-session-pre.target";
      };
    };
  };
  xdg.dataFile."dbus-1/services/dunst.service" = {
    text = ''
      [D-BUS Service]
      Name=org.freedesktop.Notifications
      Exec=${pkgs.dunst}/bin/dunst
      SystemdService=dunst.service
    '';
  };
  systemd.user.services = {
    ### Generic
    ## Bluetooth management
    blueman = {
      Unit = {
        Description = "Blueman is a GTK+ Bluetooth Manager";
        Documentation = "man:blueman-applet(1)";
        PartOf = "graphical-session.target";
      };

      Service = {
        Type = "simple";
        ExecStart = "${pkgs.blueman}/bin/blueman-applet";
      };

      Install.WantedBy = [
        "dwl-session.target"
        "dwm-session.target"
      ];
    };

    ## Music/video player controller
    playerctl = {
      Unit = {
        Description = "mpris media player command-line controller";
        Documentation = "man:playerctl(1)";
        PartOf = "graphical-session.target";
      };

      Service = {
        Type = "simple";
        ExecStart = "${pkgs.playerctl}/bin/playerctld daemon";
      };

      Install.WantedBy = [
        "dwl-session.target"
        "dwm-session.target"
      ];
    };

    ## Udiskie for automounting drives
    udiskie = {
      Unit = {
        Description = "Automounter for removable media ";
        Documentation = "https://github.com/coldfix/udiskie/wiki";
        PartOf = "graphical-session.target";
      };

      Service = {
        Type = "simple";
        ExecStart = ''
          ${pkgs.udiskie}/bin/udiskie -At
        '';
      };

      Install.WantedBy = [
        "dwl-session.target"
        "dwm-session.target"
      ];
    };

    ### Xorg
    ## Xidlehook for automatic locking
    xidlehook = {
      Unit = {
        Description = "Idle manager for X11";
        Documentation = "man:xidlehook(1)";
        PartOf = "graphical-session.target";
      };

      Service = {
        Type = "simple";
        Environment = [
          "DISPLAY=:0"
          "XIDLEHOOK_SOCK=%t/xidlehook.socket"
        ];
        ExecStart = ''
          ${pkgs.xidlehook}/bin/xidlehook \
          --not-when-fullscreen \
          --not-when-audio \
          --timer 600 \
            "xrandr --output $(xrandr | grep primary | awk '{print $1}') --brightness .1" \
            "xrandr --output $(xrandr | grep primary | awk '{print $1}') --brightness 1" \
          --timer 15 \
            "xrandr --output $(xrandr | grep primary | awk '{print $1}') --brightness 1; lock-xorg.sh" \
            "" \
          --timer 3600 \
            "systemctl suspend-then-hibernate" \
            ""
        '';
      };

      Install.WantedBy = [ "dwm-session.target" ];
    };

    ## Notification daemon
    dunst = {
      Unit = {
        Description = "Dunst notification daemon";
        Documentation = "man:dunst(1)";
        PartOf = "graphical-session.target";
        After = "graphical-session-pre.target";
      };

      Service = {
        Type = "dbus";
        BusName = "org.freedesktop.Notifications";
        ExecStart = "${pkgs.dunst}/bin/dunst";
      };
    };

    kwallet = {
      Unit = {
        Description = "Daemon for kwallet";
        Documentation = "https://github.com/KDE/kwallet";
        PartOf = "graphical-session.target";
        After = "graphical-session-pre.target";
      };

      Service = {
        Type = "simple";
        ExecStart = ''
          ${pkgs.libsForQt5.kwallet}/bin/kwalletd5
        '';
        Restart = "always";
      };

      Install.WantedBy = [ "dwm-session.target" ];
    };

    "1password" = {
      Unit = {
        Description = "Run 1password in silent mode";
        Documentation = "https://1password.com/";
        PartOf = "graphical-session.target";
        After = "graphical-session-pre.target";
      };

      Service = {
        Type = "simple";
        ExecStart = ''
          ${pkgs._1password-gui}/bin/1password --silent
        '';
        Restart = "always";
      };

      Install.WantedBy = [ "dwm-session.target" ];
    };

  };
}
