local state_file = vim.env.DOTFILES_THEME_STATE or vim.fn.expand('~/.dotfiles/.theme-mode')

local function read_mode()
    local ok, lines = pcall(vim.fn.readfile, state_file)
    if not ok or #lines == 0 then
        return 'dark'
    end

    return vim.trim(lines[1]) == 'light' and 'light' or 'dark'
end

local function apply_theme(mode)
    if mode == 'light' then
        vim.o.background = 'light'
        vim.cmd [[colorscheme github_light_high_contrast]]

        vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
        vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#ffffff' })
        vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '#d0d7de', bg = '#ffffff' })
        vim.api.nvim_set_hl(0, 'StatusLine', { bg = '#eaeef2', fg = '#24292f' })
        vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = '#ffffff' })
        vim.api.nvim_set_hl(0, 'TelescopeBorder', { fg = '#d0d7de', bg = '#ffffff' })
        vim.api.nvim_set_hl(0, 'HarpoonWindow', { bg = '#ffffff' })
        vim.api.nvim_set_hl(0, 'HarpoonBorder', { fg = '#d0d7de', bg = '#ffffff' })
    else
        vim.o.background = 'dark'
        vim.cmd [[colorscheme github_dark_high_contrast]]

        vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
        vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#0d0d0d' })
        vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '#151515' })
        vim.api.nvim_set_hl(0, 'StatusLine', { bg = '#151515' })
        vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = '#0d0d0d' })
        vim.api.nvim_set_hl(0, 'HarpoonWindow', { bg = '#0d0d0d' })
        vim.api.nvim_set_hl(0, 'HarpoonBorder', { bg = '#0d0d0d' })
    end

    vim.g.dotfiles_theme_mode = mode
end

local function sync_theme()
    local mode = read_mode()
    if vim.g.dotfiles_theme_mode ~= mode then
        apply_theme(mode)
    end
end

apply_theme(read_mode())

vim.api.nvim_create_user_command('ThemeSync', sync_theme, {})

vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter' }, {
    group = vim.api.nvim_create_augroup('DotfilesThemeSync', { clear = true }),
    callback = sync_theme,
})

_G.get_lsp_error_count = function()
    return #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
end

-- statusline
vim.opt.statusline = table.concat({
    " %([%{FugitiveHead()}]%)",
    " %r%y%w %(%m %)",
    "%{pathshorten(expand('%:f'))}",
    " %=C:%c L:%l/%L ",
    " E:%{v:lua.get_lsp_error_count()}"
}, "")

-- gitgutter
vim.g.gitgutter_sign_priority = 20

-- lsp
require('lspconfig.ui.windows').default_options.border = 'single'
