vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.updatetime = 250
vim.opt.signcolumn = 'auto:2'
vim.opt.wrap = false
vim.opt.wildignore = vim.opt.wildignore + { '.git', '*/node_modules/*', '*/dist*' }

vim.cmd("autocmd BufWritePre *.tf silent! execute '!terraform fmt -write=true %'")
vim.cmd("autocmd BufWritePre *.prisma lua vim.lsp.buf.format()")
