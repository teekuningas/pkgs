{
  lib,
  pkgs,
  python3Packages,
  fetchFromGitHub,
  llm,
}:
python3Packages.buildPythonPackage rec {
  pname = "llm-azure";
  version = "2.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "bexelbie";
    repo = "llm-azure";
    rev = "8033b71f07f309ff7b66e9a7527ca96fbc9ec308";
    hash = "sha256-SwDYejBecC6BT+JzEHEhtnOzYgi0eUDl1hCS99/mxGc=";
  };

  build-system = [
    python3Packages.setuptools
  ];

  dependencies = [
    llm
  ];

  meta = {
    description = "LLM plugin to access azure openai";
    homepage = "https://github.com/bexelbie/llm-azure";
    license = lib.licenses.asl20;
  };
}
