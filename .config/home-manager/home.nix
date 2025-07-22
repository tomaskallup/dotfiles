{ pkgs, lib, ... }:
session:

let
  unstable = import <unstable> {
    config = {
      allowUnfree = true;
    };
  };
  c3-lsp = builtins.getFlake ("github:tomaskallup/c3-lsp/main");
in
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
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    efm-langserver
    jq
    nodejs_20
    yarn
    nodePackages.typescript-language-server
    vtsls
    nodePackages.peerflix
    eslint_d
    eslint
    prettierd
    stylua
    lua-language-server
    nil
    atool
    unzip
    zip
    cmake-language-server
    ccls
    clang-tools
    yaml-language-server
    vscode-langservers-extracted
    nixfmt-rfc-style
    delta
    frozenDevenv.devenv
    lldb # Debugging for C3

    qgis # Working with geo data
    qmk
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file =
    {
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
    }
    // (
      if session == "dwm" then
        {
          ".xinitrc".text = ''
            xrandr --newmode "2560x1440_60.00"  312.25  2560 2752 3024 3488  1440 1443 1448 1493 -hsync +vsync && xrandr --addmode DP-3 2560x1440_60.00
            xrandr --auto
            [[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
            ${pkgs.kdePackages.kwallet-pam}/libexec/pam_kwallet_init
            exec dwm
          '';
        }
      else
        { }
    );

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
  home.sessionVariables =
    if session == "dwm" then
      {
        # EDITOR = "emacs";
        XCURSOR_THEME = "Adwaita";
        XCURSOR_SIZE = "16";
      }
    else
      { };
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
    initExtraFirst = ''
      (( ''${+commands[direnv]} )) && emulate zsh -c "$(direnv export zsh)"

      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi

      (( ''${+commands[direnv]} )) && emulate zsh -c "$(direnv hook zsh)"

      source ~/.p10k.zsh
    '';
    initExtra = ''
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
    '';

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
    pinentryPackage = pkgs.pinentry-gtk2;
  };

  services.fusuma = {
    enable = session == "dwm";
    package = unstable.fusuma;
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

  programs.git = {
    enable = true;

    userName = "Tomas Kallup";
    userEmail = "t.kallup@gmail.com";
    diff-so-fancy.enable = false;

    extraConfig = {
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
    };

    aliases = {
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
  xdg.dataFile."dbus-1/services/fnott.service" = lib.mkIf (session == "dwl") {
    text = ''
      [D-BUS Service]
      Name=org.freedesktop.Notifications
      Exec=${pkgs.fnott}/bin/fnott
      SystemdService=fnott.service
    '';
  };
  xdg.dataFile."dbus-1/services/dunst.service" = lib.mkIf (session == "dwm") {
    text = ''
      [D-BUS Service]
      Name=org.freedesktop.Notifications
      Exec=${pkgs.dunst}/bin/dunst
      SystemdService=dunst.service
    '';
  };
  systemd.user.services =
    {
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
    }
    // (
      if session == "dwl" then
        {

          ### Wayland
          ## Notification daemon
          fnott = {
            Unit = {
              Description = "Keyboard driven and lightweight Wayland notification daemon";
              Documentation = "man:fnott(1) man:fnott.ini(5)";
              PartOf = "graphical-session.target";
              After = "graphical-session-pre.target";
            };

            Service = {
              Type = "dbus";
              BusName = "org.freedesktop.Notifications";
              ExecStart = "${pkgs.fnott}/bin/fnott";
            };
          };

          ## Automatic display configuration
          kanshi = {
            Unit = {
              Description = "This is a Wayland equivalent for tools like autorandr.";
              Documentation = "man:kanshi(1) man:kanshi(5)";
              PartOf = "graphical-session.target";
            };

            Service = {
              Type = "simple";
              ExecStart = "${pkgs.kanshi}/bin/kanshi";
            };

            Install.WantedBy = [ "dwl-session.target" ];
          };

          ## Wayland bar
          waybar = {
            Unit = {
              Description = "Highly customizable Wayland bar for Sway and Wlroots based compositors.";
              Documentation = "man:waybar(5)";
              PartOf = "graphical-session.target";
            };

            Service = {
              Type = "simple";
              Environment = {
                PATH = "$PATH:${
                  lib.makeBinPath [
                    pkgs.gawk
                    pkgs.bash
                    pkgs.inotifytools
                  ]
                }";
              };
              ExecStart = "${pkgs.waybar}/bin/waybar";
            };

            Install.WantedBy = [ "dwl-session.target" ];
          };

          ## Swayidle for automatic locking
          swayidle = {
            Unit = {
              Description = "Idle manager for Wayland";
              Documentation = "man:swayidle(1)";
              PartOf = "graphical-session.target";
            };

            Service = {
              Type = "simple";
              ExecStart = ''
                ${pkgs.swayidle}/bin/swayidle -w\
                  timeout 600 'lock.sh' \
                  timeout 1200 'systemctl suspend-then-hibernate' \
                  before-sleep 'lock.sh'
              '';
            };

            Install.WantedBy = [ "dwl-session.target" ];
          };

          ## Sway Audio Idle Inhibit
          sway-audio-idle-inhibit = {
            Unit = {
              Description = "Automatically start idle inhibit when audio is playing";
              Documentation = "https://github.com/ErikReider/SwayAudioIdleInhibit";
              PartOf = "graphical-session.target";
            };

            Service = {
              Type = "simple";
              ExecStart = ''
                ${pkgs.nur.repos."999eagle".swayaudioidleinhibit}/bin/sway-audio-idle-inhibit
              '';
              Restart = "always";
            };

            Install.WantedBy = [ "dwl-session.target" ];
          };

          ## Persist clip board after app closes
          wl-clip-persist = {
            Unit = {
              Description = "Automatically preserve clipboard when app closes";
              Documentation = "https://github.com/Linus789/wl-clip-persist";
              PartOf = "graphical-session.target";
            };

            Service = {
              Type = "simple";
              ExecStart = ''
                ${pkgs.wl-clip-persist}/bin/wl-clip-persist --clipboard both
              '';
              Restart = "always";
            };

            Install.WantedBy = [ "dwl-session.target" ];
          };

        }
      else
        {

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

        }
    );
}
