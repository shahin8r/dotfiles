require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {
    'tsserver',
    'sumneko_lua',
    'intelephense',
    'terraform-ls'
  },
  automatic_installation = true
})
