{ 
 pkgs
, ...
}:
let
  code-mail =
    with pkgs;
    pkgs.writeShellApplication {

      runtimeInputs = [
        (pkgs.python3.withPackages (python-pkgs: with python-pkgs; [
          css-inline
        ]))
        pandoc
      ];

      name = "code-mail";
      text = ''
        pandoc -f markdown -t html --embed-resources --standalone --css=${./style.css} | python ${./mail_converter.py}
      '';
    };
in
{
  home.packages = [ code-mail ];
}
