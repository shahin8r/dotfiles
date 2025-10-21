local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  print 'Installing packer...'
  vim.fn.system { 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd 'packadd packer.nvim'
  print 'Installed packer!'

  require('plugins')
  print 'Installing plugins... Restart nvim after installation is complete'
  require('packer').sync()

  -- don't do anything else
  return
end

require('plugins')
require('options')
require('mappings')
require('theme')
