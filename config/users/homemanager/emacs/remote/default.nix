{...}:
{
  home.file.".emacs.d/remote/install".source = ./install.sh;
  home.file.".emacs.d/remote/R.sh".source = ./R.sh;
  home.file.".emacs.d/remote/R-with-job.sh".source = ./R-with-job.sh;
  home.file.".emacs.d/remote/python.sh".source = ./python.sh;
  #home.file.".emacs.d/remote/+remote.el".source = ./+remote.el;
  emacsLib.useFiles = ["remote/+remote.el"];
}
