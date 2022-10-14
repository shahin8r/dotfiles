require('nvim-treesitter.configs').setup{
  ensure_installed = {
    "lua",
    "php",
    "typescript"
  },

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = {
    enable = true,
  },
}
