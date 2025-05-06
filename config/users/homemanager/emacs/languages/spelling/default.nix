{pkgs, ...}:
let
  aspell = pkgs.aspellWithDicts
    (dicts: with dicts; [en en-computers en-science]);

  company_wordlist = pkgs.stdenv.mkDerivation {
    name = "company_wordlist";
    dontUnpack = true; # don't need a src
    buildInputs = [aspell];
    buildPhase = ''
    aspell -d en dump master | aspell -l en expand | tr ' ' '\n' > wordlist.txt
    '';
    installPhase = ''
    mkdir -p $out
    install wordlist.txt $out/wordlist.txt
    '';
    
  };
in
{
  home.packages = [ aspell ];
  home.file.".emacs.d/ispell/wordlist.txt".source = "${company_wordlist}/wordlist.txt";
}
