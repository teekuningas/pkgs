{
  lib,
  pkgs,
  python3Packages,
  fetchFromGitHub,
  llm,
}:
python3Packages.buildPythonPackage rec {
  pname = "llm-azure";
  version = "1.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "fabge";
    repo = "llm-azure";
    tag = version;
    hash = "sha256-SyxNwkUvQ6kZqRr6aglZi5r90bNY/6QEA8rUZ4UAl9g=";
  };

  build-system = [
    python3Packages.setuptools
  ];

  dependencies = [
    llm
  ];

  meta = {
    description = "LLM plugin to access azure openai";
    homepage = "https://github.com/fabge/llm-azure";
    changelog = "https://github.com/simonw/llm-gemini/releases/tag/${src.tag}";
    license = lib.licenses.asl20;
  };
}
