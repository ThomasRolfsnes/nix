{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.ruff
  ];
}
