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

-- telescope
vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = '#151515' })
vim.api.nvim_set_hl(0, 'TelescopeBorder', { bg = '#151515', fg = '#cccccc' })
vim.api.nvim_set_hl(0, 'TelescopePreviewBorder', { bg = '#151515', fg = '#151515' })
vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { bg = '#151515', fg = '#151515' })
vim.api.nvim_set_hl(0, 'TelescopeResultsBorder', { bg = '#151515', fg = '#151515' })

-- harpoon
vim.api.nvim_set_hl(0, 'HarpoonWindow', { bg = '#151515' })
vim.api.nvim_set_hl(0, 'HarpoonBorder', { bg = '#151515', fg = '#151515' })

-- statusline
vim.opt.statusline = " %([%{FugitiveHead()}]%) %r%y%w %(%m %)%{pathshorten(expand('%:f'))} %=C:%c L:%l/%L "

-- gitgutter
vim.g.gitgutter_sign_priority = 20
