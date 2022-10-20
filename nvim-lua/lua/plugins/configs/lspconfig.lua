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
  signs = false,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  virtual_text = {
    severity = vim.diagnostic.severity.ERROR,
    source = true,
  },
  virtual_lines = false,
})

local mappings = require('mappings')

local lsp = require('lspconfig')

require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {
    'tsserver',
    'sumneko_lua',
    'intelephense',
    'terraformls',
    'prismals',
    'graphql'
  }
})

lsp.sumneko_lua.setup({
  on_attach = mappings.lspconfig.on_attach,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        -- get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- do not send telemetry data
      telemetry = {
        enable = false,
      },
    }
  }
})

lsp.tsserver.setup({
  on_attach = mappings.lspconfig.on_attach,
})

lsp.intelephense.setup({
  on_attach = mappings.lspconfig.on_attach,
})

lsp.prismals.setup({
  on_attach = mappings.lspconfig.on_attach,
})
