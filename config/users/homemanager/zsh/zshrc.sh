
pdfcombine ()
{
   last=${@[-1]}
   pdftk ${@:1:$(( $# - 1 ))} cat output ${last:r}.pdf
}

# pdfinterleave odd.pdf even.pdf output.pdf
pdfinterleave ()
{
    pdftk A=${1%.*}.pdf B=${2%.*}.pdf shuffle A B output ${3:r}.pdf
}

pdfinterleavebend ()
{
    pdftk A=${1%.*}.pdf B=${2%.*}.pdf shuffle A Bend-1 output ${3:r}.pdf
}
#pdfcompress input.pdf output.pdf
pdfcompress ()
{
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/prepress -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$2 $1
}

alias rzi="rm -rf **/*Zone.Identifier"

unalias gd
gd () {
    git diff --name-only --relative --diff-filter=d | xargs bat --diff
}

export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"

export COLORTERM=truecolor

nu
