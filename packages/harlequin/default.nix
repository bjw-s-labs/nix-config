{ lib, pkgs, python3, callPackage, fetchFromGitHub }:

let
  harlequin-mysql = callPackage ./harlequin-mysql.nix {};
  harlequin-postgres = callPackage ./harlequin-postgres.nix {};
  textual-fastdatatable = callPackage ./textual-fastdatatable.nix {};
  textual-textarea = callPackage ./textual-textarea.nix {};
  shandy-sqlfmt = callPackage ./shandy-sqlfmt.nix {};
in

python3.pkgs.buildPythonPackage {
  pname = "harlequin";
  version = "v1.8.0";

  src = fetchFromGitHub {
    owner = "tconbeer";
    repo = "harlequin";
    rev = "v1.8.0";
    fetchSubmodules = false;
    sha256 = "sha256-cYiuR2h6Tht9hYIf2qDWNg958Z+HwU6xGzmj915rY5s=";
  };

  format = "pyproject";

  propagatedBuildInputs = with pkgs.python3Packages; [
    click
    duckdb
    harlequin-mysql
    harlequin-postgres
    importlib-metadata
    jinja2
    numpy
    platformdirs
    poetry-core
    pyarrow
    pyperclip
    questionary
    rich-click
    shandy-sqlfmt
    textual
    textual-fastdatatable
    textual-textarea
    tomli
    tomlkit
  ];

  meta = with lib; {
    description = "The SQL IDE for Your Terminal";
    homepage = "https://github.com/tconbeer/harlequin";
    licence = licences.mit;
  };
}
