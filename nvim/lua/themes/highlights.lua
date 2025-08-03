local M = {}

function M.setup()
	local highlights = {
		-- General UI
		FloatBorder = { fg = "#bb9dbd", bg = "none" },
		SignColumn = { bg = "none" },
		CursorLineNr = { fg = "#bb9dbd", bold = true },
		CursorLine = { bg = "none" },

		-- Completion menu
		CmpItemAbbrDeprecated = { bg = "none", strikethrough = true },
		CmpItemAbbrMatch = { fg = "#bb9dbd", bg = "none" },
		CmpItemAbbrMatchFuzzy = { link = "CmpItemAbbrMatch" },

		-- Telescope
		TelescopeNormal = { bg = "none" },
		TelescopePromptNormal = { bg = "none" },
		TelescopePromptPrefix = { bg = "none" },
		TelescopeResultsTitle = { bg = "none" },
		TelescopeMatching = { fg = "#bb9dbd", bg = "none" },
		TelescopeBorder = { fg = "#bb9dbd", bg = "none" },
		TelescopePromptBorder = { fg = "#bb9dbd", bg = "none" },
		TelescopePreviewBorder = { fg = "#bb9dbd", bg = "none" },
		TelescopeResultsBorder = { fg = "#bb9dbd", bg = "none" },
	}

	for group, settings in pairs(highlights) do
		vim.api.nvim_set_hl(0, group, settings)
	end
end

return M
