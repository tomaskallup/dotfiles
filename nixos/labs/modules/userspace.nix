{
  pkgs,
  ...
}:
{
  # Window server & related
  environment.sessionVariables = {
    EDITOR = "nvim";
    GTK_THEME = "Adwaita-dark";
    MOZ_USE_XINPUT2 = "1";
  };

  # Make PAM faster
  security.pam.loginLimits = [
    {
      domain = "@users";
      item = "rtprio";
      type = "-";
      value = 1;
    }
  ];

  security.sudo.extraRules = [
    {
      users = [ "armeeh" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  programs.dconf = {
    enable = true;
  };
  programs.git.enable = true;
  programs.htop.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = false;
  };

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.comic-shanns-mono
    noto-fonts-color-emoji
    symbola
    unifont
  ];

  fonts.fontconfig = {
    antialias = true;
    hinting.enable = true;
    defaultFonts = {
      monospace = [
        "ComicShannsMono Nerd Font"
      ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  environment.pathsToLink = [ "/share/zsh" ];
  environment.shells = with pkgs; [ zsh ];
  environment.systemPackages = (
    with pkgs;
    [
      # Libraries
      zlib
      libinput
      libxkbcommon
      glib
      shared-mime-info
      lsof
      man-pages
      man-pages-posix

      # Compilation tools
      gcc
      binutils
      glibc.static
      nix-prefetch-github
      gnumake

      # CLI Tools
      neovim
      curl
      which
      inotify-tools
      xdg-utils # for opening default programs when clicking links
      cz-cli
      brightnessctl
      fzy
      ripgrep
      pciutils
      ranger
      file
      httpie
      lm_sensors
      tree
      neovim
      ncdu
      atool
      unzip
      jdk21_headless
      screen
    ]
  );
}
