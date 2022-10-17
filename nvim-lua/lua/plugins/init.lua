require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('plugins.configs.treesitter')
    end
  }

  use {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    {
      'neovim/nvim-lspconfig',
      config = function()
        require('plugins.configs.lspconfig')
      end
    }
  }

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    config = function()
      require('plugins.configs.telescope')
    end,
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require('plugins.configs.null-ls')
    end,
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use { 'nanotech/jellybeans.vim' }

  use { 'tpope/vim-fugitive' }

  use { 'airblade/vim-gitgutter' }

  use { 'kyazdani42/nvim-web-devicons' }
end)
