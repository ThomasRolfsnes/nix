{ config, pkgs, inputs, ... }:

{
  imports = [
    ./gemini.nix
    ./cursor.nix
    ./python.nix
    inputs.peon-ping.homeManagerModules.default
  ];

  # do not change
  home.stateVersion = "25.05";
  home.shell.enableZshIntegration = true;
  home.sessionVariables = {
    TERMINAL = "bash";
  };
  home.shellAliases = {
    ll = "eza";
    la = "eza -lha";
    lt = "eza -T";       # tree
    gs = "git status";   # Git status
    ".. " = "cd ..";     # Navigate up one directory
  };

  home.file.".claude/hooks/peon-ping/peon.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      exec peon "$@"
    '';
  };


  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    zsh.enable = true;
    lazygit.enable = true;
    lazydocker.enable = true;
    neovim.enable = true;
    fzf.enable = true;
    zoxide.enable = true;

    eza.enable = true;

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;  # Faster direnv for nix environments
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
      settings = {
        pull.rebase = true;
        user = {
          name = "Thomas Rolfsnes";
          email = "thomas.rolfsnes@egmont.com";
        };
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
    gh-dash = {
      enable = true;
    };

    claude-code = {
      enable = true;
      settings = {
        hooks = {
          SessionStart = [
            {
              matcher = "";
              hooks = [
                {
                  type = "command";
                  command = "peon";
                  timeout = 10;
                }
              ];
            }
          ];
          SessionEnd = [
            {
              matcher = "";
              hooks = [
                {
                  type = "command";
                  command = "peon";
                  timeout = 10;
                  async = true;
                }
              ];
            }
          ];
          SubagentStart = [
            {
              matcher = "";
              hooks = [
                {
                  type = "command";
                  command = "peon";
                  timeout = 10;
                  async = true;
                }
              ];
            }
          ];
          Stop = [
            {
              matcher = "";
              hooks = [
                {
                  type = "command";
                  command = "peon";
                  timeout = 10;
                  async = true;
                }
              ];
            }
          ];
          Notification = [
            {
              matcher = "";
              hooks = [
                {
                  type = "command";
                  command = "peon";
                  timeout = 10;
                  async = true;
                }
              ];
            }
          ];
          PreToolUse = [
            {
              matcher = "";
              hooks = [
                {
                  type = "command";
                  command = "peon";
                  timeout = 10;
                  async = true;
                }
              ];
            }
          ];
        };
      };
    };

    peon-ping = {
      enable = true;
      package = inputs.peon-ping.packages.${pkgs.system}.default;
      settings = {
        default_pack = "glados";
        volume = 0.7;
        enabled = true;
        desktop_notifications = true;
        categories = {
          "session.start" = true;
          "task.complete" = true;
          "task.error" = true;
          "input.required" = true;
          "resource.limit" = true;
          "user.spam" = true;
        };
      };
      installPacks = [ "peon" "glados" "sc_kerrigan" ];
      enableZshIntegration = true;
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
