-- Create autocommand groups
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Restore cursor position when opening files
local general_group = augroup("General", { clear = true })
autocmd("BufReadPost", {
	group = general_group,
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Check for file changes when entering buffer or gaining focus
autocmd({ "FocusGained", "BufEnter" }, {
	group = general_group,
	command = "checktime",
})

-- Filetype specific settings
local filetype_group = augroup("FiletypeSettings", { clear = true })

-- Make .blade.php files be recognized as html files
autocmd({ "BufNewFile", "BufRead" }, {
	group = filetype_group,
	pattern = "*.blade.php",
	callback = function()
		vim.bo.filetype = "html"
	end,
})

-- Format on save
local format_group = augroup("LspFormatting", { clear = true })
autocmd("BufWritePre", {
	group = format_group,
	pattern = "*",
	callback = function()
		vim.lsp.buf.format({
			timeout_ms = 2000,
		})
	end,
})

