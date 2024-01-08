{ lib, python3, pkgs, fetchurl, ... }:

python3.pkgs.buildPythonPackage {
  pname = "harlequin-postgres";
  version = "0.2.1";
  src = fetchurl {
    url = "https://pypi.org/packages/source/h/harlequin_postgres/harlequin_postgres-0.2.1.tar.gz";
    sha256 = "sha256-SsR/PUAWKMkpV5vY2ainZpZ67K09g9ZNjIPoV+qsLg8=";
  };

  doCheck = false;

  format = "pyproject";

  propagatedBuildInputs = with pkgs.python3Packages; [
    psycopg2
    poetry-core
  ];

  meta = with lib; {
    description = "The Postgres adapter for Harlequin, the SQL IDE for your Terminal";
    homepage = "https://github.com/tconbeer/harlequin-postgres";
    licence = licences.mit;
  };
}
