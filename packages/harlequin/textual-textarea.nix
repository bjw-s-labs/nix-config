{ lib, python3, pkgs, fetchurl, ... }:

python3.pkgs.buildPythonPackage {
  pname = "textual-textarea";
  version = "0.9.5";
  src = fetchurl {
    url = "https://pypi.org/packages/source/t/textual_textarea/textual_textarea-0.9.5.tar.gz";
    sha256 = "sha256-SGntKLoBu1VzkSJ+uET1f/QFI8jzNDhjyJKpFtu3abk=";
  };

  doCheck = false;

  format = "pyproject";

  propagatedBuildInputs = with pkgs.python3Packages; [
    poetry-core
    pyperclip
    textual
  ];

  meta = with lib; {
    description = "A text area (multi-line input) with syntax highlighting and autocomplete for Textual";
    homepage = "https://github.com/tconbeer/textual-textarea";
    licence = licences.mit;
  };
}
