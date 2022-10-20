require('onedark').setup({
    style = 'darker'
})
require('onedark').load()

vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = 'none', fg = '#333333' })
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none', fg = '#eeeeee' })
vim.api.nvim_set_hl(0, 'NonText', {bg = 'none', fg = '#666666' })
vim.api.nvim_set_hl(0, 'LineNr', { bg = 'none', fg = '#666666' })
vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#101010' })
vim.api.nvim_set_hl(0, 'StatusLine', { bg = '#181818', fg = '#cccccc' })
vim.api.nvim_set_hl(0, 'StatusLineNc', { bg = '#111111', fg = '#666666' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#222222' })
vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'none' })
vim.api.nvim_set_hl(0, 'Winbar', { bg = 'none', fg = '#666666' })
vim.api.nvim_set_hl(0, '@variable', { bg = 'none', fg = '#dddddd' })

-- harpoon
vim.api.nvim_set_hl(0, 'HarpoonWindow', { bg = '#000000' })
vim.api.nvim_set_hl(0, 'HarpoonBorder', { bg = '#000000' })

-- statusline
vim.opt.statusline = " %([%{FugitiveHead()}]%) %r%y%w %(%m %)%t %=C:%c L:%l/%L "

-- winbar
vim.opt.winbar = '%=%m %F '
