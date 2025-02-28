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
    'nvim-telescope/telescope.nvim',
    config = function()
      require('plugins.configs.telescope')
    end,
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {
    'hrsh7th/nvim-cmp',
    config = function()
      require('plugins.configs.cmp')
    end,
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    }
  }

  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require('plugins.configs.null-ls')
    end,
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {
    'ThePrimeagen/harpoon',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use { 'projekt0n/github-nvim-theme' }

  use { 'tpope/vim-fugitive' }

  use { 'airblade/vim-gitgutter' }

  use { 'kyazdani42/nvim-web-devicons' }

  use { 'github/copilot.vim' }

  use {
    'rcarriga/nvim-dap-ui',
    requires = {
      {
        'mfussenegger/nvim-dap',
        config = function()
          require('plugins.configs.dap')
        end,
      },
      { 'nvim-neotest/nvim-nio' },
      {
        'theHamsta/nvim-dap-virtual-text'
      },
      {
        "jay-babu/mason-nvim-dap.nvim",
      }
    }
  }

  use {
    'nvim-treesitter/nvim-treesitter-context',
     config = function()
       require('plugins.configs.treesitter-context')
     end
  }
end)
