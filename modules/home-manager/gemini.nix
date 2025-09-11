{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    gemini-cli
  ];

  home.file.".gemini/settings.json" = {
    text = builtins.toJSON {
      selectedAuthType = "oauth-personal";
      preferredEditor = "neovim";
      telemetry = {
        enabled = false;
      };
      privacy = {
        usageStatisticsEnabled = false;
      };
    };
  };
}
