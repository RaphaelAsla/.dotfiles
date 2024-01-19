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
	{
		"madyanov/gruber.vim",
		"morhetz/gruvbox",
		lazy = false,
		priority = 1000
	},
	{
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp-signature-help",
		},
	},
	"https://github.com/alvan/vim-closetag",
	"neovim/nvim-lspconfig",
	"nvim-lua/lsp-status.nvim",
	"nvim-lualine/lualine.nvim",
	"tpope/vim-fugitive",
	"dstein64/vim-startuptime",
	"tikhomirov/vim-glsl",
	"airblade/vim-rooter",
})
