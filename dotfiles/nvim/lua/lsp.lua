local lsp = require "lspconfig"
local coq = require "coq"


lsp.hls.setup{}
lsp.pyright.setup{}
lsp.bashls.setup{}
lsp.ccls.setup{}
lsp.rls.setup{}
lsp.texlab.setup{}
lsp.r_language_server.setup{}
lsp.html.setup{coq.lsp_ensure_capabilities()}
lsp.eslint.setup{}
lsp.gdscript.setup{}
lsp.r_language_server.setup{}
lsp.emmet_ls.setup{coq.lsp_ensure_capabilities()}
lsp.rnix.setup{}

-- lua language server setup
require'lspconfig'.sumneko_lua.setup{}
