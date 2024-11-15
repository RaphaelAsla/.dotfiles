-- bootstrap lazy
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
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp-signature-help",
		},
	},
	{
		"lervag/vimtex",
		lazy = false, -- we don't want to lazy load VimTeX
		-- tag = "v2.15", -- uncomment to pin to a specific release
		init = function()
			-- Viewer options: One may configure the viewer either by specifying a built-in viewer method:
			vim.g.vimtex_view_method = 'zathura'

			-- Or with a generic interface:
			vim.g.vimtex_view_general_viewer = 'zathura'
			vim.g.vimtex_view_general_options = '--unique file:@pdf\\#src:@line@tex'

			-- VimTeX uses latexmk as the default compiler backend. If you use it, which is
			-- strongly recommended, you probably don't need to configure anything. If you
			-- want another compiler backend, you can change it as follows.
			-- The list of supported backends and further explanation is provided in the documentation, see ":help vimtex-compiler".
			vim.g.vimtex_compiler_latexmk = {
				name = 'latex-mk',
				exe = 'latex-mk',
				args = { '-pdf', "-file-line-error", '-interaction=nonstopmode', '-synctex=1' },
				errorformat = '%f:%l: %m',
				continuous = 1,
			}

			vim.g.vimtex_quickfix_mode = 0

			-- Most VimTeX mappings rely on localleader and this can be changed with the
			-- following line. The default is usually fine and is the symbol "\".
			vim.g.maplocalleader = ","
		end
	},
	"nyoom-engineering/oxocarbon.nvim",
	"nvim-telescope/telescope.nvim",
	"nvim-lua/plenary.nvim",
	"alvan/vim-closetag",
	"neovim/nvim-lspconfig",
	"nvim-lua/lsp-status.nvim",
	"nvim-lualine/lualine.nvim",
	"tpope/vim-fugitive",
	"dstein64/vim-startuptime",
	"airblade/vim-rooter",
	"nvim-treesitter/nvim-treesitter",
	"tree-sitter/tree-sitter",
	"github/copilot.vim",
})
