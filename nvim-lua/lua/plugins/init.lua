require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require 'plugins.configs.treesitter'
    end
  }

  use {
    {
      'williamboman/mason.nvim',
      config = function()
        require 'plugins.configs.mason'
      end
    },
    'williamboman/mason-lspconfig.nvim',
    {
      'neovim/nvim-lspconfig',
      config = function()
        require 'plugins.configs.lspconfig'
      end
    }
  }
end)
