vim.cmd [[colorscheme github_dark_high_contrast]]

-- statusline
vim.opt.statusline = " %([%{FugitiveHead()}]%) %r%y%w %(%m %)%{pathshorten(expand('%:f'))} %=C:%c L:%l/%L "

-- gitgutter
vim.g.gitgutter_sign_priority = 20

-- lsp
require('lspconfig.ui.windows').default_options.border = 'single'
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})
