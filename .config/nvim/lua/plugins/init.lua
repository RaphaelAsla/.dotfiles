local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	'neovim/nvim-lspconfig',
	'hrsh7th/nvim-cmp',
	'nvim-lua/lsp-status.nvim',
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-path',
	'hrsh7th/cmp-cmdline',
	'nvim-lualine/lualine.nvim',
	'tpope/vim-fugitive',
	{
		'https://gitlab.com/madyanov/gruber.vim',
		lazy = false,
		priority = 1000
	},
	'https://github.com/alvan/vim-closetag',
	{
		'nvim-telescope/telescope.nvim',
		'nvim-lua/plenary.nvim',
	},
	'dstein64/vim-startuptime',
})
