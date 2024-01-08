{ lib, python3, pkgs, fetchurl, ... }:

python3.pkgs.buildPythonPackage {
  pname = "shandy-sqlfmt";
  version = "0.21.1";
  src = fetchurl {
    url = "https://pypi.org/packages/source/s/shandy_sqlfmt/shandy_sqlfmt-0.21.1.tar.gz";
    sha256 = "sha256-cHBxLQ97wDPmFQ+BJ+ExB+AmhcPyAV6iHPS8x+8mt4o=";
  };

  doCheck = false;

  format = "pyproject";

  propagatedBuildInputs = with pkgs.python3Packages; [
    click
    jinja2
    importlib-metadata
    platformdirs
    poetry-core
    tomli
    tqdm
  ];

  meta = with lib; {
    description = "sqlfmt formats your dbt SQL files so you don't have to.";
    homepage = "https://github.com/tconbeer/sqlfmt";
    licence = licences.mit;
  };
}
