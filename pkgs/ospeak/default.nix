{ lib
, python3Packages
, fetchPypi
, pkgs
}:

python3Packages.buildPythonApplication rec {
  pname = "ospeak";
  version = "0.3";

  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-ujpEA403AdYyEFuwdVtoEpdAX+C4TR9ALSq4VIgCiz8=";
  };

  propagatedBuildInputs = [
    pkgs.ffmpeg
    python3Packages.setuptools
    python3Packages.click
    python3Packages.openai
    python3Packages.pydub
  ];
}
