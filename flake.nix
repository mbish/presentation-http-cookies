{
  description = "A very basic flake";
  inputs = {
    nix-marp.url = "github:tweag/nix-marp";
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/22.05";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    nix-marp,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [];
      };
    in {
      devShells.default = pkgs.mkShell {
        buildInputs = [
          nix-marp.packages.${system}.default
        ];
      };
    });
}
