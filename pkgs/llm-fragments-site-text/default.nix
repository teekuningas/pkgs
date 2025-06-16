{
  lib,
  pkgs,
  python3Packages,
  fetchFromGitHub,
  llm,
}:
python3Packages.buildPythonPackage rec {
  pname = "llm-fragments-site-text";
  version = "0.1.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "daturkel";
    repo = "llm-fragments-site-text";
    tag = version;
    hash = "sha256-JzD72tMd3wIK6TeQ60LCB4DsIMCpF/zqPbqbzjVNYB0=";
  };

  build-system = [
    python3Packages.setuptools
  ];

  dependencies = [
    llm
    python3Packages.trafilatura
  ];

  meta = {
    description = "Run URLs through the trafilatura to get plain text";
    homepage = "https://github.com/daturkel/llm-fragments-site-text";
    license = lib.licenses.asl20;
  };
}
