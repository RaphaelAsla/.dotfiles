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

	use 'nvim-lualine/lualine.nvim'

	use 'tpope/vim-fugitive'

	use { 'kyazdani42/nvim-tree.lua',
		requires = { 'kyazdani42/nvim-web-devicons', -- optional, for file icons
		}, }

	use 'https://gitlab.com/madyanov/gruber.vim'

	use 'https://github.com/alvan/vim-closetag'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.0',
		-- or                            , branch = '0.1.x',
		requires = { { 'nvim-lua/plenary.nvim' } }
	}

	use 'psf/black'

end)
