{ config, pkgs, lib, ... }:

let
  peon-ping = pkgs.stdenv.mkDerivation {
    pname = "peon-ping";
    version = "main";

    src = pkgs.fetchFromGitHub {
      owner = "PeonPing";
      repo = "peon-ping";
      rev = "main";
      sha256 = lib.fakeSha256;
    };

    dontBuild = true;

    installPhase = ''
      mkdir -p $out/share/peon-ping
      cp -r . $out/share/peon-ping/
    '';
  };
in
{
  home.file.".claude/hooks/peon-ping" = {
    source = "${peon-ping}/share/peon-ping";
    recursive = true;
  };

  home.shellAliases = {
    peon = "$HOME/.claude/hooks/peon-ping/peon.sh";
  };
}
