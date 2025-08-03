-- ClangTidy fix command
vim.api.nvim_create_user_command("ClangTidyFix", function()
	local file = vim.fn.expand("%")
	vim.cmd("!clang-tidy " .. file .. " --fix \"--header-filter=.*\" --quiet -- -std=c++20")
end, { desc = "Run clang-tidy with fixes on current file" })

-- Write to sudo files command
vim.api.nvim_create_user_command("W", function()
	vim.cmd("execute ':silent w !sudo tee % > /dev/null' | :edit!")
end, { desc = "Write file with sudo permissions" })

