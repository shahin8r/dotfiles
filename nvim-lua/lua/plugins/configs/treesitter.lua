require('nvim-treesitter.configs').setup{
  ensure_installed = {
    "lua",
    "javascript",
    "php",
    "typescript",
    "hcl",
    "prisma"
  },

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = {
    enable = true,
  },
}

