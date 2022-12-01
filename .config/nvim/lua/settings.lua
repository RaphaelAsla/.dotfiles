local o = vim.opt
local g = vim.g
local c = vim.cmd
local oo = vim.o

--vim.lsp.set_log_level("debug")

c("syntax on")
c("set list")
c("set lcs+=tab:···,trail:·,space:·")
g.mapleader = ","
o.termguicolors = true
o.mouse = "a"
o.signcolumn = "yes:1"
o.cmdheight = 1
o.updatetime = 500
o.completeopt:append('menuone,noinsert,noselect')
o.clipboard = 'unnamedplus'
o.timeoutlen = 500
o.wrap = false
o.ww:append('<,>,h,l,[,]')
o.nu = true
o.rnu = true
o.showmode = false
o.autoindent = true
o.smartindent = true
o.copyindent = true
o.hlsearch = true
o.incsearch = true
o.so = 10
o.siso = 5
o.cursorline = true
o.autoread = true
o.history = 500
o.undofile = true
o.undodir = vim.fn.stdpath('cache') .. '/NvimUndofile'
o.splitright = true
oo.guicursor = 'a:block'

o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = false

o.backup = false
o.writebackup = false
o.swapfile = false


c("filetype plugin indent on")
c("colorscheme gruber")
c("highlight CursorLineNr guifg=#ffd700")
c("highlight CursorLine guibg=none")

o.shortmess = o.shortmess
	+ {
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
