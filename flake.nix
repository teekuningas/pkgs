{
  description = "Nix Package Repository";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    poetry2nix = { url = "github:nix-community/poetry2nix"; inputs.nixpkgs.follows = "nixpkgs"; inputs.flake-utils.follows = "flake-utils"; };
  };

  outputs = { self, nixpkgs, flake-utils, ...}@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
        poetry2nix = inputs.poetry2nix.lib.mkPoetry2Nix { inherit pkgs; };
      in {
        packages = {
          safepilot = pkgs.callPackage ./pkgs/safepilot { };
          safepilot-with-copilot = pkgs.callPackage ./pkgs/safepilot { withCopilot = true; };
          safepilot-with-gemini = pkgs.callPackage ./pkgs/safepilot { withGemini = true; };
          safepilot-with-opencode = pkgs.callPackage ./pkgs/safepilot { withOpencode = true; };
          safepilot-full = pkgs.callPackage ./pkgs/safepilot { withCopilot = true; withGemini = true; withOpencode = true; };
          ospeak = pkgs.callPackage ./pkgs/ospeak { python3Packages = pkgs.python312Packages; };
          files-to-prompt = pkgs.callPackage ./pkgs/files-to-prompt { python3Packages = pkgs.python312Packages;};
          llm-azure = pkgs.callPackage ./pkgs/llm-azure { python3Packages = pkgs.python312Packages;};
          llm-echo = pkgs.callPackage ./pkgs/llm-echo { python3Packages = pkgs.python312Packages;};
          llm-fragments-site-text = pkgs.callPackage ./pkgs/llm-fragments-site-text { python3Packages = pkgs.python312Packages;};
        };
      }
    );
}
