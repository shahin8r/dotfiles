vim.cmd [[colorscheme github_dark_high_contrast]]

-- statusline
vim.opt.statusline = " %([%{FugitiveHead()}]%) %r%y%w %(%m %)%{pathshorten(expand('%:f'))} %=C:%c L:%l/%L "

-- gitgutter
vim.g.gitgutter_sign_priority = 20
