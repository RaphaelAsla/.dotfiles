local M = {}

function M.setup()
	require('copilot').setup({
		copilot_model = "gpt-4o-copilot",
		panel = {
			enabled = true,
			auto_refresh = false,
			keymap = {
				jump_prev = "[[",
				jump_next = "]]",
				accept = "<CR>",
				refresh = "gr",
				open = "<M-CR>"
			},
			layout = {
				position = "bottom",
				ratio = 0.4
			},
		},
		suggestion = {
			enabled = true,
			auto_trigger = true,
			hide_during_completion = true,
			debounce = 75,
			trigger_on_accept = true,
			keymap = {
				accept = "<C-j>",
				accept_word = false,
				accept_line = false,
				next = "<M-]>",
				prev = "<M-[>",
				dismiss = "<C-]>",
			},
		},
	})
end

return M
