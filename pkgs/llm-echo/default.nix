{
  lib,
  pkgs,
  python3Packages,
  fetchFromGitHub,
  llm,
}:
python3Packages.buildPythonPackage rec {
  pname = "llm-echo";
  version = "0.2";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "simonw";
    repo = "llm-echo";
    tag = version;
    hash = "sha256-KtdsvXJQRJ3EEJ25i6ccbVxMsWlDsxa+HJ7bFzyYGNI=";
  };

  build-system = [
    python3Packages.setuptools
  ];

  dependencies = [
    llm
  ];

  meta = {
    description = "LLM plugin to introduce echo model";
    homepage = "https://github.com/simonw/llm-echo";
    license = lib.licenses.asl20;
  };
}
