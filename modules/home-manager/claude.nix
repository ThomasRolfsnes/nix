{ pkgs, inputs, ... }:

{
  imports = [
    inputs.peon-ping.homeManagerModules.default
  ];

  home.file.".claude/hooks/peon-ping/peon.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      exec peon "$@"
    '';
  };

  programs = {
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
          PermissionRequest = [
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
        default_pack = "peon";
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
enableZshIntegration = true;
    };
  };
}
