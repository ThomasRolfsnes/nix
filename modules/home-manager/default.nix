{ config, pkgs, ... }:

{
  # do not change
  home.stateVersion = "25.05";
  home.shell.enableZshIntegration = true;
  home.sessionVariables = {
    TERMINAL = "bash";
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    zsh.enable = true;
    lazygit.enable = true;
    neovim.enable = true;
    fzf.enable = true;
    zoxide.enable = true;

    direnv = {
      enable = true;
      enableZshIntegration = true;
    };

    starship = {
      enable = true;
      settings = {
          add_newline = true;
          format = "$directory$character";
          right_format = "$shlvl$shell$username$hostname$nix_shell$git_branch$git_commit$git_state$git_status$jobs$python$cmd_duration";
      };
    };

    git = {
      enable = true;
      userName = "Thomas Rolfsnes";
      userEmail = "thomas.rolfsnes@egmont.com";
      extraConfig = {
        pull.rebase = true;
      };
    };

    ghostty = {
      # enable = true; installed by homebrew
      installVimSyntax = true;
      enableZshIntegration = true;
      settings = {
        theme = "catppuccin-mocha";
      };
    };

    jujutsu = {
      enable = true;
      settings = {
        user = {
          email = "thomas.rolfsnes@egmont.com";
          name = "Thomas Rolfsnes";
        };
        ui = {
          editor = "nvim";
        };
      };
    };
  };

  # programs.aerospace = {
  #   enable = true;
  #   userSettings.start-at-login = true;
  # };


  # reenable when updated to 6.0
  # services.ollama.enable = true;
}
