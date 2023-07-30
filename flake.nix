{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    utils,
  }:
    utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };
      in rec
      {
        packages = rec {
          default = lemurs;
          lemurs = pkgs.callPackage ./default.nix {};
        };
      }
    ) // {
      nixosModules = rec {
        default = lemurs;
        lemurs = import ./lemurs-modules.nix {};
      };
    };
}
