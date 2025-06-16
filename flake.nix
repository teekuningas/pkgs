{
  description = "Nix Package Repository";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
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
          llm-azure = pkgs.callPackage ./pkgs/llm-azure { python3Packages = pkgs.python312Packages;};
          llm-echo = pkgs.callPackage ./pkgs/llm-echo { python3Packages = pkgs.python312Packages;};
          llm-fragments-site-text = pkgs.callPackage ./pkgs/llm-fragments-site-text { python3Packages = pkgs.python312Packages;};
        };
      }
    );
}
