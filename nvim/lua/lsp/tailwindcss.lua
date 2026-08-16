local shared = require('lsp.shared')
local util = require('lspconfig.util')

local root_files = {
  "tailwind.config.cjs",
  "tailwind.config.js",
  "postcss.config.js"
}

local exclude_globs = {
  '**/.git/**',
  '**/.hg/**',
  '**/.bzr/**',
  '**/.svn/**',
  '**/.DS_Store/**',
  '**/.yarn/**',
  '**/.pnpm-store/**',
  '**/.next/**',
  '**/.nuxt/**',
  '**/.output/**',
  '**/.cache/**',
  '**/.turbo/**',
  '**/.parcel-cache/**',
  '**/coverage/**',
  '**/dist/**',
  '**/build/**',
  '**/tmp/**',
  '**/storage/**',
  '**/vendor/**',
  '**/node_modules/**',
}

return shared.with_defaults({
  root_dir = util.root_pattern(table.unpack(root_files)),
  single_file_support = false,
  settings = {
    tailwindCSS = {
      files = {
        exclude = exclude_globs,
      },
    },
  },
})
