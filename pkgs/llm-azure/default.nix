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
    owner = "teekuningas";
    repo = "llm-azure";
    rev = "5f9e87eccfcf507a8e1dffcf5b2d4b6d73b97222";
    hash = "sha256-IRo8fpmtA4mEdfseHPk7MN2kdLeIuue5/AUQHItSHpc=";
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
