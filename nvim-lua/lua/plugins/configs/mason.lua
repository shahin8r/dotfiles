require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {
    'tsserver',
    'sumneko_lua',
    'intelephense'
  },
  automatic_installation = true
})
