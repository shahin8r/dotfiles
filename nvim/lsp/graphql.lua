local shared = require('lsp.shared')

return shared.with_defaults({
  cmd = {
    '/home/shahin/.local/share/nvim/mason/bin/graphql-lsp',
    'server',
    '-m',
    'stream',
    '-s=http://localhost/hyperion/Graphql',
  },
})
