local signs = {
  Error = ' ',
  Warn = ' ',
  Info = ' ',
  Hint = 'ﴞ ',
}

for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  signs = true,
  update_in_insert = false,
  underline = false,
  severity_sort = true,
  virtual_text = {
    severity = vim.diagnostic.severity.ERROR,
    source = true,
  },
})

local shared = require('lsp.shared')


require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {
    'eslint',
    'ts_ls',
    'lua_ls',
    'intelephense',
    'terraformls',
    'prismals',
    'graphql',
    'angularls',
    'cssls',
    'tailwindcss',
  },
  automatic_enable = false,
})

local servers = {
  'eslint',
  'ts_ls',
  'lua_ls',
  'intelephense',
  'terraformls',
  'prismals',
  'graphql',
  'angularls',
  'cssls',
  'tailwindcss',
}

vim.lsp.config('*', shared.with_defaults())

for _, server in ipairs(servers) do
  local ok, custom = pcall(require, 'lsp.' .. server)
  local opts = ok and shared.with_defaults(custom) or shared.with_defaults()
  vim.lsp.config(server, opts)
  vim.lsp.enable(server)
end
