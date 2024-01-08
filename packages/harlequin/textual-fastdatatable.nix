{ lib, python3, pkgs, fetchurl, ... }:

python3.pkgs.buildPythonPackage {
  pname = "textual-fastdatatable";
  version = "0.6.1";
  src = fetchurl {
    url = "https://pypi.org/packages/source/t/textual_fastdatatable/textual_fastdatatable-0.6.1.tar.gz";
    sha256 = "sha256-RuIOFsWTfpqozdzpPCppMkubtI4ibgz6wWfnakN4N/4=";
  };

  doCheck = false;

  format = "pyproject";

  propagatedBuildInputs = with pkgs.python3Packages; [
    poetry-core
    pyarrow
    pytz
    textual
  ];

  meta = with lib; {
    description = "A performance-focused reimplementation of Textual's DataTable widget, with a pluggable data storage backend.";
    homepage = "https://github.com/tconbeer/textual-fastdatatable";
    licence = licences.mit;
  };
}
