{
  description = "Nix Package Repository";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, flake-utils, ...}@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
      in {
        packages = {
          safepilot = pkgs.callPackage ./pkgs/safepilot { };
          safepilot-with-copilot = pkgs.callPackage ./pkgs/safepilot { withCopilot = true; };
          safepilot-with-gemini = pkgs.callPackage ./pkgs/safepilot { withGemini = true; };
          safepilot-with-opencode = pkgs.callPackage ./pkgs/safepilot { withOpencode = true; };
          safepilot-full = pkgs.callPackage ./pkgs/safepilot { withCopilot = true; withGemini = true; withOpencode = true; };
        };
      }
    );
}
