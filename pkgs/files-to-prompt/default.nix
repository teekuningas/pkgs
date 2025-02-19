{
  lib,
  pkgs,
  python3Packages,
}:

python3Packages.buildPythonPackage rec {
  pname = "files-to-prompt";
  version = "0.6";
  pyproject = true;

  src = pkgs.fetchPypi {
    inherit version;
    pname = "files_to_prompt";
    sha256 = "sha256-mvV+7L2ynTzOA0wYZJP/xsEgXqT1q95vsyzLHZbq5Aw=";
  };
  build-system = [
    python3Packages.setuptools
  ];
  dependencies = [
    python3Packages.click
  ];
}
