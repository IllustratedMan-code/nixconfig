# Python in remote ENV

[Getting Tramp to work with arbitrary linux environment (lsp)](https://www.reddit.com/r/emacs/comments/u6a6w0/help_with_lsp_tramp_python_virtual_environments/)

Looks like I need to set up an initialization command that `ssh`es into the
server with port forwarding enabled, starts the language server, then connects
to the port.

```shell
ssh -L XXXX:localhost:XXXX <user>@<ip> # pick port number of choice
pylsp --tcp --host localhost -- port XXXX
```


start eglot in emacs, and enter `localhost:XXXX`.

Maybe this could be automated.

This thread seems to handle environment modules over tramp, which may work:

[thread](https://stackoverflow.com/questions/19126370/how-can-i-load-a-servers-specific-r-installation-environment-module-when-laun)

```shell
module show R/3.0.1 # shows path to module
```

Then in emacs:

```emacs-lisp
(setq tramp-verbose 9)
```



``` emacs-lisp
aaaaa
```
