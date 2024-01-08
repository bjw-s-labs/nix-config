{ lib, python3, pkgs, fetchurl, ... }:

python3.pkgs.buildPythonPackage {
  pname = "harlequin-mysql";
  version = "0.1.0";
  src = fetchurl {
    url = "https://pypi.org/packages/source/h/harlequin_mysql/harlequin_mysql-0.1.0.tar.gz";
    sha256 = "sha256-HiI4kZz5D7as+AK9B3Srx+Cd3dsS/+54DbAP+j5v4nw=";
  };

  doCheck = false;

  format = "pyproject";

  propagatedBuildInputs = with pkgs.python3Packages; [
    mysql-connector
    poetry-core
  ];

  meta = with lib; {
    description = "The MySQL adapter for Harlequin, the SQL IDE for your Terminal";
    homepage = "https://github.com/tconbeer/harlequin-mysql";
    licence = licences.mit;
  };
}
