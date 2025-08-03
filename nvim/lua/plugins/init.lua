-- bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"nvim-telescope/telescope.nvim",
	"alvan/vim-closetag",
	"tpope/vim-fugitive",
	"dstein64/vim-startuptime",
	"airblade/vim-rooter",
	"nvim-treesitter/nvim-treesitter",
	"tree-sitter/tree-sitter",
	{
		"kawre/leetcode.nvim",
		build = ":TSUpdate html",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
		opts = {
			lang = "cpp",
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"nvim-lua/lsp-status.nvim",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp-signature-help",
		},
	},
	{
		'chomosuke/typst-preview.nvim',
		lazy = false,
		version = '1.*',
		opts = {},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { 'nvim-tree/nvim-web-devicons' }
	},
	{
		"vague2k/vague.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("vague").setup({ transparency = false })
			vim.cmd("colorscheme vague")
			vim.cmd("hi statusline guibg=NONE")
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
	}
})
