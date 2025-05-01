local telescope = require("telescope")

telescope.setup({
	defaults = {
		theme = "center",
		layout_config = {
			horizontal = {
				preview_width = 0.5,
			},
		},
	},

	-- Open netrw view in the directory of selected file
	pickers = {
		find_files = {
			mappings = {
				n = {
					["cd"] = function(prompt_bufnr)
						local selection = require("telescope.actions.state").get_selected_entry()
						local dir = vim.fn.fnamemodify(selection.path, ":p:h")
						require("telescope.actions").close(prompt_bufnr)
						vim.cmd(string.format("silent Explore %s", dir))
					end
				}
			}
		}
	}
})
