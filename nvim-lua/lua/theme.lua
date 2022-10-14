vim.cmd[[colorscheme jellybeans]]
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none', fg = '#eeeeee' })
vim.api.nvim_set_hl(0, 'NonText', {bg = 'none', fg = '#666666' })
vim.api.nvim_set_hl(0, 'LineNr', { bg = 'none', fg = '#666666' })
vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#101010' })
vim.api.nvim_set_hl(0, 'StatusLine', { bg = '#222222', fg = '#cccccc' })
vim.api.nvim_set_hl(0, 'StatusLineNc', { bg = '#111111', fg = '#666666' })

-- statusline
vim.opt.statusline=" %{pathshorten(expand('%:f'))} %([%{FugitiveHead()}]%) %m%r%y%w%=C:%c L:%l/%L "
