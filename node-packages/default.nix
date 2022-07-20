{node2nix}:
{
    name = "node-packages";
    src = ./.;
    buildInputs = [node2nix];
    buildPhase = ''
        node2nix node-packages.json
    '';
    installPhase = ''
        mv default.nix $out
    '';

}    


