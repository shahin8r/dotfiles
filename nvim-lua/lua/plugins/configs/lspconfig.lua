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

local mappings = require('mappings')

local lsp = require('lspconfig')

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
    'tailwindcss'
  }
})

lsp.lua_ls.setup({
  on_attach = mappings.lspconfig.on_attach,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        -- get the language server to recognize the `vim` global
        globals = { 'vim' },
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

local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()

lsp.ts_ls.setup({
  on_attach = mappings.lspconfig.on_attach,
  capabilities = cmp_capabilities
})

lsp.intelephense.setup({
  on_attach = mappings.lspconfig.on_attach,
  capabilities = cmp_capabilities,
  settings = {
    intelephense = {
      environment = {
        includePaths = { "/home/shahin/dev/struqtur/struqtur-legacy-vendor" }
      },
    },
  },
  init_options = {
    licenceKey = "/home/shahin/.config/intelephense/license.txt"
  }
})

lsp.prismals.setup({
  on_attach = mappings.lspconfig.on_attach,
  capabilities = cmp_capabilities
})

lsp.cssls.setup({
  on_attach = mappings.lspconfig.on_attach,
  capabilities = cmp_capabilities
})

lsp.angularls.setup({
  on_attach = mappings.lspconfig.on_attach,
  capabilities = cmp_capabilities
})

lsp.terraformls.setup({
  on_attach = mappings.lspconfig.on_attach,
  capabilities = cmp_capabilities
})

lsp.tailwindcss.setup({
  on_attach = mappings.lspconfig.on_attach,
  capabilities = cmp_capabilities
})

lsp.eslint.setup({
  on_attach = mappings.lspconfig.on_attach,
  capabilities = cmp_capabilities
})

lsp.graphql.setup {
  capabilities = cmp_capabilities,
  cmd = { "/home/shahin/.local/share/nvim/mason/bin/graphql-lsp", "server", "-m", "stream", "-s=http://localhost/hyperion/Graphql" },
  on_attach = mappings.lspconfig.on_attach,
}
