{ pkgs, ... }:

let
  # https://harlequin.sh/ - SQL IDE for your terminal.
  # Base package ships the duckdb + sqlite adapters; bundle the bigquery and
  # postgres adapters so they're discoverable via `harlequin -a bigquery` etc.
  harlequin = pkgs.harlequin.overridePythonAttrs (old: {
    dependencies = (old.dependencies or [ ]) ++ [
      pkgs.python3Packages.harlequin-bigquery
      pkgs.python3Packages.harlequin-postgres
    ];
  });
in
{
  home.packages = [ harlequin ];
}
