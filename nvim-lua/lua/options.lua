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
vim.g.neoformat_try_node_exe = 1

vim.cmd("autocmd BufWritePre *.tf silent! execute '!terraform fmt -write=true %'")
vim.cmd("autocmd BufWritePre *.prisma lua vim.lsp.buf.format()")
vim.cmd("autocmd BufWritePost *.php silent! execute '!docker compose exec webserver vendor/bin/php-cs-fixer fix %'")
vim.cmd("autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx Neoformat")
