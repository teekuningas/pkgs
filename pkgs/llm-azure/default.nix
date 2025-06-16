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
    rev = "c5cc6f3a9494408a94325c7dd6f6d1243949f462";
    hash = "sha256-KPjvnj8vq0dx6bdMOyg0R3F5CwtYcMeF7VWHA9GQlLU=";
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
