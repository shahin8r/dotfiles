require('nvim-treesitter').setup{
  ensure_installed = {
    'lua',
    'javascript',
    'php',
    'phpdoc',
    'typescript',
    'hcl',
    'prisma',
    'graphql',
    'tsx',
    'markdown',
    'markdown_inline'
  },

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = {
    enable = true,
  },
}

