local opt = vim.opt
local g = vim.g
local cmd = vim.cmd
local o = vim.o

--vim.lsp.set_log_level("debug")

cmd("syntax on")
opt.list = true
opt.listchars:append({ tab = "···", trail = "·", space = "·" })
g.mapleader = ","
opt.termguicolors = true
opt.mouse = "a"
opt.signcolumn = "yes:1"
opt.cmdheight = 1
opt.updatetime = 500
opt.completeopt:append('menuone,noinsert,noselect')
opt.clipboard = 'unnamedplus'
opt.timeoutlen = 500
opt.wrap = false
opt.ww:append('<,>,h,l,[,]')
opt.nu = true
opt.rnu = true
opt.showmode = false
opt.autoindent = true
opt.smartindent = true
opt.copyindent = true
opt.incsearch = true
opt.so = 10
opt.siso = 5
opt.cursorline = true
opt.autoread = true
opt.history = 500
opt.undofile = true
opt.undodir = vim.fn.stdpath('cache') .. '/NvimUndofile'
opt.splitright = true
o.guicursor = 'i-r-cr-ci:hor40'
opt.termguicolors = true
g.netrw_banner = 0

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = false

opt.backup = false
opt.writebackup = false
opt.swapfile = false

cmd("filetype plugin indent on")
cmd("colorscheme gruber")
cmd("highlight CursorLineNr guifg=#ffd700")
cmd("highlight CursorLine guibg=none")

opt.shortmess = opt.shortmess + {
	A = true, -- don't give the "ATTENTION" message when an existing swap file is found.
	I = true, -- don't give the intro message when starting Vim |:intro|.
	W = true, -- don't give "written" or "[w]" when writing a file
	c = true, -- don't give |ins-completion-menu| messages
	m = true, -- use "[+]" instead of "[Modified]"
}

vim.api.nvim_command [[
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    au FocusGained,BufEnter * checktime
]]
