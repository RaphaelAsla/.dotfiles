-- Load core configuration first
require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.commands")

-- Bootstrap lazy.nvim
require("lazy-bootstrap").setup()

-- Setup plugins
require("lazy").setup("plugins", {
	defaults = {
		lazy = false,
		version = false,
	},
	install = { colorscheme = { "vague" } },
	checker = { enabled = false },
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

