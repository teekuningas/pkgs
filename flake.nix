{
  description = "Nix Package Repository";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/24.05";
    poetry2nix = { url = "github:nix-community/poetry2nix"; inputs.nixpkgs.follows = "nixpkgs"; inputs.flake-utils.follows = "flake-utils"; };
  };

  outputs = { self, nixpkgs, flake-utils, ...}@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        poetry2nix = inputs.poetry2nix.lib.mkPoetry2Nix { inherit pkgs; };
      in {
        packages = {
          ospeak = pkgs.callPackage ./pkgs/ospeak { python3Packages = pkgs.python312Packages; };
          files-to-prompt = pkgs.callPackage ./pkgs/files-to-prompt { python3Packages = pkgs.python312Packages;};
        };
      }
    );
}
