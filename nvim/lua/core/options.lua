local opt = vim.opt
local g = vim.g

-- Leader key
g.mapleader = ","

-- Mapping for Greek characters
opt.langmap =
"ΑA,ΒB,ΨC,ΔD,ΕE,ΦF,ΓG,ΗH,ΙI,ΞJ,ΚK,ΛL,ΜM,ΝN,ΟO,ΠP,QQ,ΡR,ΣS,ΤT,ΘU,ΩV,WW,ΧX,ΥY,ΖZ,αa,βb,ψc,δd,εe,φf,γg,ηh,ιi,ξj,κk,λl,μm,νn,οo,πp,qq,ρr,σs,τt,θu,ωv,ςw,χx,υy,ζz"

-- Netrw settings
g.netrw_banner = 0

-- UI settings
opt.guicursor = ""
opt.termguicolors = true
opt.mouse = "a"
opt.signcolumn = "yes:1"
opt.cmdheight = 1
opt.updatetime = 500
opt.timeoutlen = 500
opt.showmode = false
opt.cursorline = true

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Indentation
opt.autoindent = true
opt.smartindent = true
opt.copyindent = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = false

-- Search settings
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Scrolling
opt.scrolloff = 10
opt.sidescrolloff = 5

-- Wrapping
opt.wrap = false
opt.whichwrap:append("<,>,h,l,[,]")

-- Completion
opt.completeopt = { "menuone", "noinsert", "noselect" }

-- Clipboard
opt.clipboard = "unnamedplus"

-- File handling
opt.autoread = true
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- Undo
opt.undofile = true
opt.undodir = vim.fn.stdpath("cache") .. "/NvimUndofile"

-- History
opt.history = 500

-- Splits
opt.splitright = true
opt.splitbelow = true

-- List mode
opt.list = false

-- Make settings
opt.makeprg = "make -C build run"

-- Remove annoying keys
opt.cinkeys:remove({ ':' })

-- Short messages
opt.shortmess:append({
	A = true, -- don't give the "ATTENTION" message when an existing swap file is found.
	I = true, -- don't give the intro message when starting Vim |:intro|.
	W = true, -- don't give "written" or "[w]" when writing a file
	c = true, -- don't give |ins-completion-menu| messages
	m = true, -- use "[+]" instead of "[Modified]"
})

