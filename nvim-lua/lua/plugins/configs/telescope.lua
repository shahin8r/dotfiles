local telescope = require('telescope')

telescope.setup({
  color_devicons = true,
  defaults = {
    layout_strategy = 'vertical',
  },
  pickers = {
    find_files = {
      hidden = true
    }
  }
})
