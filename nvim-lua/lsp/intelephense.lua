local shared = require('lsp.shared')

return shared.with_defaults({
  settings = {
    intelephense = {
      environment = {
        includePaths = {
          '/home/shahin/dev/struqtur/struqtur-legacy-vendor',
        },
      },
    },
  },
  init_options = {
    licenceKey = '/home/shahin/.config/intelephense/license.txt',
  },
})
