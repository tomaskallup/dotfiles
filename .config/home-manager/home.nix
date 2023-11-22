{ pkgs, ... }:

let
  unstable = import <unstable> { config = { allowUnfree = true; }; };
in {
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
    unstable.nodejs_20
    unstable.nodePackages.typescript-language-server
    unstable.eslint_d
    unstable.prettierd
    unstable.stylua
    unstable.lua-language-server
    unstable.nil
  ];

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
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Setup ZSH
  programs.zsh = {
    enable = true;
    autocd = true;
    enableVteIntegration = true;
    enableAutosuggestions = true;
    shellAliases = {
      ll = "ls -la";
      y = "yarn";
      g = "git";
      yS = "jq -r '.scripts | keys | .[]' < package.json | fzy | xargs -r yarn";
      cleanservices = "rm -rf packages/*/dist(N) packages/*/tsconfig.build.tsbuildinfo(N) services/*/build(N) services/*/tsconfig.build.tsbuildinfo(N) functions/*/build(N) functions/*/tsconfig.build.tsbuildinfo(N) && yarn && yarn lerna run build";
      e = "$EDITOR";
    };
    initExtra = ''
      setopt HIST_IGNORE_ALL_DUPS
      setopt INC_APPEND_HISTORY

      source ~/.p10k.zsh

      autoload -U up-line-or-beginning-search
      autoload -U down-line-or-beginning-search
      zle -N up-line-or-beginning-search
      zle -N down-line-or-beginning-search
      bindkey -e
      bindkey "^[[A" up-line-or-beginning-search # Up
      bindkey "^[OA" up-line-or-beginning-search # Up
      bindkey "^[[B" down-line-or-beginning-search # Down
      bindkey "^[OB" down-line-or-beginning-search # Down

      autoload -U edit-command-line
      zle -N edit-command-line
      bindkey '^xe' edit-command-line

      path+=('/home/armeeh/Pkg/dwl/scripts')
      export PATH
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
        { name = "romkatv/powerlevel10k"; tags = [ "as:theme" "depth:1" ]; } # Theme
      ];
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.git = {
    enable = true;

    userName = "Tomas Kallup";
    userEmail = "t.kallup@gmail.com";
    diff-so-fancy.enable = true;

    extraConfig = {
      core = { editor = "$EDITOR"; };
      pull = { rebase = true; autoSetupRemote = true; };
      rebase = { autoStash = true; };
      merge = { tool = "nvimdiff"; };
      "mergetool \"nvimdiff\"" = { cmd = "nvim -d \"$LOCAL\" \"$REMOTE\" \"$MERGED\" -c 'wincmd w' -c 'wincmd w' -c 'wincmd J'"; };
      push = { autoSetupRemote = true; };
      diff = { algorithm = "patience"; };
    };

    aliases = {
      bcleanup = "!git fetch --prune && git branch --merged | grep -E -v \"(^\\*|master|develop|staging)\" > /tmp/git-branch-cleanup && $EDITOR /tmp/git-branch-cleanup && cat /tmp/git-branch-cleanup | xargs git branch -d";
      pbcleanup = "!git fetch --prune && git branch -vv | grep ': gone]' | sed \"s/^\\s\\+\\([^ ]\\+\\).*/\\1/\" | grep -E -v \"(^\\*|master|develop|staging)\" > /tmp/git-branch-cleanup && $EDITOR /tmp/git-branch-cleanup && cat /tmp/git-branch-cleanup | xargs git branch -D";
      rbcleanup = "!git fetch --prune && git branch -r --merged | grep -E -v \"(^\\*|master|develop|staging)\" > /tmp/git-branch-cleanup && $EDITOR /tmp/git-branch-cleanup && sed -i \"\" \"s/origin\\///\" /tmp/git-branch-cleanup && cat /tmp/git-branch-cleanup | xargs git push origin --delete";
      a = "add";
      aa = "add *";
      ac = "!git diff --name-only --diff-filter=U | xargs git add";
      ap = "add -p";
      b = "branch";
      c = "commit";
      ch = "checkout";
      cm = "commit -m";
      chp = "cherry-pick";
      chpc = "cherry-pick --continue";
      d = "diff";
      f = "fetch";
      fp = "fetch --prune";
      fc = "!git diff --name-only --diff-filter=U | xargs $EDITOR";
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
      psuo = "!git push --set-upstream origin $(git branch --show-current)";
      psu = "push --set-upstream";
      dt = "difftool";
      mt = "mergetool";
      fixc = "!$EDITOR `git diff --name-only --diff-filter=U`";
      bi = "!git branch | sed '/HEAD/d' | sed -e 's/*\\?\\s\\+\\(remotes\\/origin\\/\\)\\?//' | fzy | xargs -r git checkout";
      bia = "!git branch -a | sed '/HEAD/d' | sed -e 's/*\\?\\s\\+\\(remotes\\/origin\\/\\)\\?//' | fzy | xargs -r git checkout";
      lg = "log --format='%C(auto) %h %s'";
    };
  };
}
