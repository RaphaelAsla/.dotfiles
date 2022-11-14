vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

  use 'wbthomason/packer.nvim'

  use 'neovim/nvim-lspconfig'

  use 'hrsh7th/nvim-cmp'

  use 'nvim-lua/lsp-status.nvim'

  use 'hrsh7th/cmp-nvim-lsp'

  use 'hrsh7th/cmp-buffer'

  use 'hrsh7th/cmp-path'

  use 'hrsh7th/cmp-cmdline'

  use 'L3MON4D3/LuaSnip'

  use 'saadparwaiz1/cmp_luasnip'

  use 'nvim-lualine/lualine.nvim'

  use 'tpope/vim-fugitive'

  use 'folke/tokyonight.nvim'

  use { 'kyazdani42/nvim-tree.lua',
	  requires = { 'kyazdani42/nvim-web-devicons', -- optional, for file icons 
  },}

  use 'https://gitlab.com/madyanov/gruber.vim'

  use 'https://github.com/alvan/vim-closetag'

end)
