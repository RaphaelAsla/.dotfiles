return {
	-- Core LSP and completion
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
		config = function()
			require("config.lsp").setup()
		end,
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = function()
			require("config.cmp").setup()
		end,
	},

	-- Treesitter for syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("config.treesitter").setup()
		end,
	},

	-- Tree-sitter base
	{
		"tree-sitter/tree-sitter",
	},

	-- Fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("config.telescope").setup()
		end,
	},

	-- Status line
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("config.lualine").setup()
		end,
	},

	-- Colorscheme
	{
		"vague2k/vague.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("vague").setup({ transparency = false })
			vim.cmd("colorscheme vague")
			vim.cmd("hi statusline guibg=NONE")
			require("themes.highlights").setup()
		end,
	},

	-- Git integration
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "G" },
	},

	-- Auto close HTML/XML tags
	{
		"alvan/vim-closetag",
		ft = { "html", "xml", "jsx", "tsx", "php" },
	},

	-- Startup time profiling
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
	},

	-- Project root detection
	{
		"airblade/vim-rooter",
		event = "VeryLazy",
	},

	-- LeetCode integration
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

	-- Typst preview
	{
		'chomosuke/typst-preview.nvim',
		lazy = false,
		version = '1.*',
		opts = {},
	},

	-- Copilot assistance
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("config.copilot").setup()
		end,
	},

}
