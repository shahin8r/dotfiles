local telescope = require('telescope')

telescope.setup({
  color_devicons = true,
  defaults = {
    layout_strategy = 'vertical',
    file_ignore_patterns = {
      '.git',
      '.angular',
      'node_modules',
      'dist',
      'build',
      'package-lock.json',
      'yarn.lock',
    },
  },
  pickers = {
    find_files = {
      hidden = true
    }
  }
})
