require('nvim-treesitter.configs').setup{
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
    'markdown'
  },

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = {
    enable = true,
  },
}

