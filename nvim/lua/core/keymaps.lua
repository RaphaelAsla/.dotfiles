local keymap = vim.keymap.set

-- Exit insert mode
keymap("i", "jj", "<Esc>", { desc = "Exit insert mode" })

-- Indent line left or right and re-select the line
keymap("v", "<", "<gv", { desc = "Indent left and reselect" })
keymap("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Paste in visual mode without copying underlying text
keymap("x", "p", 'pgv"' .. vim.v.register .. 'y`>', { expr = true, desc = "Paste without yanking" })
keymap("x", "P", 'Pgv"' .. vim.v.register .. 'y`>', { expr = true, desc = "Paste before without yanking" })

-- Delete without copying
keymap({ "n", "v" }, "d", '"_d', { desc = "Delete without yanking" })

-- Delete with copying (use D in visual mode)
keymap("x", "D", "d", { desc = "Delete with yanking" })

-- Clear highlighted text
keymap("n", "<Esc>", ":noh<CR>", { silent = true, desc = "Clear search highlights" })

-- Go to start of line
keymap({ "n", "v" }, "0", "^", { desc = "Go to first non-blank character" })

-- Open close brackets
keymap("i", "{<CR>", "{<CR>}<Esc>O", { desc = "Auto-close braces with newline" })
keymap("i", "{;<CR>", "{<CR>};<Esc>O", { desc = "Auto-close braces with semicolon" })

-- Open Neovim config settings with Telescope
keymap("n", "<leader>ef", function()
	vim.cmd("cd ~/.config/nvim/lua")
	require('telescope.builtin').find_files({ cwd = vim.fn.getcwd() })
end, { silent = true, desc = "Find config files" })

keymap("n", "<leader>ew", function()
	vim.cmd("cd ~/.config/nvim/lua")
	require('telescope.builtin').live_grep({ cwd = vim.fn.getcwd() })
end, { silent = true, desc = "Search in config files" })

-- Search and replace
keymap("n", "<leader>s", ":%s/", { desc = "Search and replace in file" })
keymap("v", "<leader>s", ":s/", { desc = "Search and replace in selection" })

-- Undo without moving cursor
keymap("n", "U", function()
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	vim.cmd("undo")
	vim.api.nvim_win_set_cursor(0, cursor_pos)
end, { desc = "Undo without moving cursor" })

-- LeetCode commands
keymap("n", "<leader>R", ":Leet run<CR>", { desc = "Run LeetCode solution" })
keymap("n", "<leader>S", ":Leet submit<CR>", { desc = "Submit LeetCode solution" })

-- File explorer
keymap("n", "<leader><Tab>", ":Explore<CR>", { desc = "Open file explorer" })

-- Helper function for WriteEdit
local function write_edit()
	local file = vim.fn.input("Open file: ")
	if file ~= "" then
		vim.cmd("write")
		vim.cmd("bdelete")
		vim.cmd("edit " .. file)
	end
end

-- Tab management
keymap("n", "<leader>tn", write_edit, { desc = "Write current and open new file" })
keymap("n", "<leader>to", ":tabonly<CR>", { desc = "Close all other tabs" })
keymap("n", "<leader>tc", ":tabclose<CR>", { desc = "Close current tab" })
keymap("n", "<leader>tm", ":tabmove ", { desc = "Move tab" })
keymap("n", "<leader>te", ":tabedit <C-r>=expand('%:p:h')<CR>/", { desc = "New tab in current directory" })

-- Splits
keymap("n", "<leader>vs", ":vsp <C-r>=expand('%:p:h')<CR>/", { desc = "Vertical split in current directory" })
keymap("n", "<leader>hs", ":sp <C-r>=expand('%:p:h')<CR>/", { desc = "Horizontal split in current directory" })

-- Move between splits
keymap("n", "<C-w>k", "<C-w>k", { silent = true, desc = "Move to split above" })
keymap("n", "<C-w>j", "<C-w>j", { silent = true, desc = "Move to split below" })
keymap("n", "<C-w>h", "<C-w>h", { silent = true, desc = "Move to split left" })
keymap("n", "<C-w>l", "<C-w>l", { silent = true, desc = "Move to split right" })

-- Center cursor when moving half page
keymap("n", "<C-d>", "<C-d>zz", { desc = "Move down half page and center" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Move up half page and center" })

-- Center cursor when moving between search matches
keymap("n", "n", "nzz", { desc = "Next search result and center" })
keymap("n", "N", "Nzz", { desc = "Previous search result and center" })

-- Telescope
keymap("n", "<leader>f", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
keymap("n", "<leader>g", "<cmd>Telescope git_files<CR>", { desc = "Git files" })
keymap("n", "<leader>w", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
keymap("n", "<leader>b", "<cmd>Telescope buffers<CR>", { desc = "Buffers" })
keymap("n", "<leader>h", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })

-- Switch between source and header files
keymap("n", "<leader>`", "<cmd>ClangdSwitchSourceHeader<CR>", { desc = "Switch source/header" })

-- Go to tab by number
for i = 1, 9 do
	keymap("n", "<leader>" .. i, i .. "gt", { desc = "Go to tab " .. i })
end
keymap("n", "<leader>0", ":tablast<CR>", { desc = "Go to last tab" })

-- Surround words in symbols/brackets/quotes
keymap("v", "$1", "<Esc>`>a)<Esc>`<i(<Esc>", { desc = "Surround with ()" })
keymap("v", "$2", "<Esc>`>a]<Esc>`<i[<Esc>", { desc = "Surround with []" })
keymap("v", "$3", "<Esc>`>a}<Esc>`<i{<Esc>", { desc = "Surround with {}" })
keymap("v", '$4', '<Esc>`>a"<Esc>`<i"<Esc>', { desc = 'Surround with ""' })
keymap("v", "$5", "<Esc>`>a'<Esc>`<i'<Esc>", { desc = "Surround with ''" })
keymap("v", "$$", "<Esc>`>a$<Esc>`<i$<Esc>", { desc = "Surround with $$" })

-- Move lines up and down
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Append to end of line in visual block mode
keymap("v", "A", "$A", { desc = "Append at end of selection" })

-- Get current directory
keymap("n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>", { desc = "Change to current file directory" })

-- Build commands
keymap("n", "<F6>", ":w<Bar>make<CR>", { desc = "Save and build project" })
keymap("n", "<F5>", function()
	-- Custom compile and run function converted to Lua
	vim.cmd("write")

	-- Check for build script first
	if vim.fn.filereadable("./build.sh") == 1 and vim.fn.executable("./build.sh") == 1 then
		vim.cmd("!./build.sh")
		return
	end

	local filetype = vim.bo.filetype
	local filename = vim.fn.expand("%")
	local filename_no_ext = vim.fn.expand("%<")

	local compile_commands = {
		c = function()
			vim.cmd("!clang -Wall " .. filename .. " -o " .. filename_no_ext)
			vim.cmd("!./" .. filename_no_ext)
		end,
		cpp = function()
			vim.cmd("!clang++ -std=c++23 -Wall -stdlib=libc++ " .. filename .. " -o " .. filename_no_ext)
			vim.cmd("!./" .. filename_no_ext)
		end,
		cuda = function()
			vim.cmd("!nvcc -std=c++17 " .. filename .. " -o " .. filename_no_ext)
			vim.cmd("!./" .. filename_no_ext)
		end,
		rust = function()
			vim.cmd("!cargo run")
		end,
		java = function()
			vim.cmd("!javac " .. filename)
			vim.cmd("!java " .. filename_no_ext)
		end,
		sh = function()
			vim.cmd("!bash " .. filename)
		end,
		python = function()
			vim.cmd("!python3 " .. filename)
		end,
		html = function()
			vim.cmd("!$BROWSER " .. filename .. " &")
		end,
		go = function()
			vim.cmd("!go build " .. filename_no_ext)
			vim.cmd("!go run " .. filename)
		end,
		matlab = function()
			vim.cmd("!octave " .. filename)
		end,
		javascript = function()
			vim.cmd("!node " .. filename)
		end,
		asm = function()
			vim.cmd("!nasm -f elf64 " .. filename)
			vim.cmd("!ld " .. filename_no_ext .. ".o -o " .. filename_no_ext)
			vim.cmd("!rm -rf " .. filename_no_ext .. ".o")
			vim.cmd("!./" .. filename_no_ext)
		end,
		typst = function()
			vim.cmd("!typst compile " .. filename)
		end,
	}

	local command = compile_commands[filetype]
	if command then
		command()
	else
		print("No compile command defined for filetype: " .. filetype)
	end
end, { desc = "Compile and run current file" })

