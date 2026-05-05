{ pkgs, lib, ... }:

let
  version = "2.0.0-preview.175";

  sources = {
    aarch64-darwin = {
      url = "https://public.cdn.getdbt.com/fs/cli/fs-v${version}-aarch64-apple-darwin.tar.gz";
      sha256 = "1lp3lyrmryv3aadwmv8q1kxkj276ij9draj6qj2r5vmpbghkp8w4";
    };
    x86_64-darwin = {
      url = "https://public.cdn.getdbt.com/fs/cli/fs-v${version}-x86_64-apple-darwin.tar.gz";
      sha256 = "0fm0qq0gnmf099xlk8n36yk3x4ankhwr9dlypp8qdpjbndg99452";
    };
  };

  dbt-fusion = pkgs.stdenv.mkDerivation {
    pname = "dbt-fusion";
    inherit version;

    src = pkgs.fetchurl sources.${pkgs.stdenv.hostPlatform.system};

    sourceRoot = ".";

    dontFixup = pkgs.stdenv.hostPlatform.isDarwin;

    installPhase = ''
      runHook preInstall
      mkdir -p $out/bin
      cp dbt $out/bin/dbt
      chmod +x $out/bin/dbt
      runHook postInstall
    '';

    meta = with lib; {
      description = "The next-generation engine for dbt - a ground-up rewrite of dbt Core in Rust";
      homepage = "https://github.com/dbt-labs/dbt-fusion";
      license = licenses.unfree;
      platforms = [ "aarch64-darwin" "x86_64-darwin" ];
      mainProgram = "dbt";
    };
  };
in
{
  home.packages = [ dbt-fusion ];
}
