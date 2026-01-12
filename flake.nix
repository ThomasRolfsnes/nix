# Manually installed:
# Teams
# Docker desktop
# Homebrew
# Ollama
# XCode

{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nvf.url = "github:notashelf/nvf";
    nvf.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, nvf }:
    let
      username = "roltho";
      configuration = { pkgs, ... }: { 

        programs.zsh.enable = true;
        users.users.${username} = {
          home = "/Users/${username}";
          shell = pkgs.zsh;
        };

        # disable default nix daemon since we've installed Nix via the Determinate installer
        nix.enable = false;
        # Necessary for using flakes on this system.
        nix.settings = {
          experimental-features = "nix-command flakes";
          trusted-users = [ "root" "${username}" ];
        };
        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;
        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 6;
        # set primary user
        system.primaryUser = "roltho";
        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = "aarch64-darwin";
        # allow installation of unfree software
        nixpkgs.config.allowUnfree = true;

      };
    in
      {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .
      darwinConfigurations.MAC-Y597GTC9Q3 = nix-darwin.lib.darwinSystem {
        modules = [ configuration
          nvf.nixosModules.default
          ./modules/darwin
          ./modules/nvf
          home-manager.darwinModules.home-manager {
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              backupCommand = "mv -f {} {}.bak";
              users.${username} = import ./modules/home-manager;
            };
          }
        ];
      };
    };
}
