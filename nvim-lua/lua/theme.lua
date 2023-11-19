vim.cmd [[colorscheme github_dark_high_contrast]]

vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#0d0d0d' })
vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '#151515' })
vim.api.nvim_set_hl(0, 'StatusLine', { bg = '#151515' })
vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = '#0d0d0d' })
vim.api.nvim_set_hl(0, 'HarpoonWindow', { bg = '#0d0d0d' })
vim.api.nvim_set_hl(0, 'HarpoonBorder', { bg = '#0d0d0d' })

-- statusline
vim.opt.statusline = " %([%{FugitiveHead()}]%) %r%y%w %(%m %)%{pathshorten(expand('%:f'))} %=C:%c L:%l/%L "

-- gitgutter
vim.g.gitgutter_sign_priority = 20

-- lsp
require('lspconfig.ui.windows').default_options.border = 'single'
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})
