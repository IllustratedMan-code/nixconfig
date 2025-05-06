{ config, pkgs, ...}:

let
  company-ispell-wordlist = with pkgs; stdenv.mkDerivation {
    name = "company-ispell-wordlist";
    buildInputs = [
      (aspellWithDicts
        (dicts: with dicts; [en en-computers en-science])
      )
  }
in
{
}
