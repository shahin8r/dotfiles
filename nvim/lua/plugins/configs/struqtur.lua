require('lspconfig').intelephense.setup({
  settings = {
    intelephense = {
      environment = {
        includePaths = { "/home/shahin/dev/struqtur/struqtur-legacy/vendor" }
      }
    }
  }
})

require('lspconfig').graphql.setup({
  cmd = { "/home/shahin/.local/share/nvim/mason/bin/graphql-lsp", "server", "-m", "stream", "-s=http://localhost/hyperion/GraphQl" },
})
