vim.g.mapleader = ' '
vim.keymap.set('i', 'jj', '<Esc>', {})

vim.keymap.set('n', '<leader>y', '\"+y', {})
vim.keymap.set('v', '<leader>y', '\"+y', {})
vim.keymap.set({ 'n', 'v' }, '<leader>Y', '\"+Y', {})

local M = {}

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', 'ff', builtin.find_files, {})
vim.keymap.set('n', 'fg', builtin.live_grep, {})
vim.keymap.set('n', 'fb', builtin.buffers, {})
vim.keymap.set('n', 'fh', builtin.help_tags, {})

-- lspconfig
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
M.lspconfig = {}
M.lspconfig.opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, M.lspconfig.opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, M.lspconfig.opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, M.lspconfig.opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, M.lspconfig.opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
M.lspconfig.on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  M.lspconfig.bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, M.lspconfig.bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, M.lspconfig.bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, M.lspconfig.bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, M.lspconfig.bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, M.lspconfig.bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, M.lspconfig.bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, M.lspconfig.bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, M.lspconfig.bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, M.lspconfig.bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, M.lspconfig.bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, M.lspconfig.bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, M.lspconfig.bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, M.lspconfig.bufopts)
end

return M
