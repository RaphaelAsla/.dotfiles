local opt = vim.opt
local g = vim.g
local cmd = vim.cmd
local o = vim.o

--vim.lsp.set_log_level("debug")

cmd("syntax on")
cmd("filetype plugin indent on")

cmd(
	"set langmap=ΑA,ΒB,ΨC,ΔD,ΕE,ΦF,ΓG,ΗH,ΙI,ΞJ,ΚK,ΛL,ΜM,ΝN,ΟO,ΠP,QQ,ΡR,ΣS,ΤT,ΘU,ΩV,WW,ΧX,ΥY,ΖZ,αa,βb,ψc,δd,εe,φf,γg,ηh,ιi,ξj,κk,λl,μm,νn,οo,πp,qq,ρr,σs,τt,θu,ωv,ςw,χx,υy,ζz")

g.mapleader = ","
g.netrw_banner = 0
o.guicursor = ""
opt.termguicolors = true
opt.mouse = "a"
opt.cinkeys:remove({ ':' })
opt.signcolumn = "yes:1"
opt.cmdheight = 1
opt.updatetime = 500
opt.completeopt:append("menuone,noinsert,noselect")
opt.clipboard = "unnamedplus"
opt.timeoutlen = 500
opt.wrap = false
opt.ww:append("<,>,h,l,[,]")
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
opt.undodir = vim.fn.stdpath("cache") .. "/NvimUndofile"
opt.splitright = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = false
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.list = true
opt.listchars:append({ tab = "···", trail = "·", space = "·" })
opt.termguicolors = true
opt.makeprg = "make -C build run"

--transparency for any theme
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { bg = "none", strikethrough = true })
--oxocarbon specific
vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { bg = "none", strikethrough = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#be95ff", bg = "none" })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { link = "CmpItemAbbrMatch" })
vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { bg = "none" })
vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { bg = "none" })
vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = "#be95ff", bg = "none" })
vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#be95ff", bg = "none" })
vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = "#be95ff", bg = "none" })
vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = "#be95ff", bg = "none" })
vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = "#be95ff", bg = "none" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ff7eb6", bold = true })
vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })


opt.shortmess = opt.shortmess + {
	A = true, -- don't give the "ATTENTION" message when an existing swap file is found.
	I = true, -- don't give the intro message when starting Vim |:intro|.
	W = true, -- don't give "written" or "[w]" when writing a file
	c = true, -- don't give |ins-completion-menu| messages
	m = true, -- use "[+]" instead of "[Modified]"
}

--Cursor stays in the same position after open/close a file
vim.api.nvim_command [[
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    au FocusGained,BufEnter * checktime
]]

--Make .blade.php files be recognized as html files so html lsp based highlighting can work
vim.api.nvim_command [[
	autocmd BufNewFile,BufRead *.blade.php setlocal ft=html
]]

--Formating on save
vim.api.nvim_create_augroup("LspFormatting", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	group = "LspFormatting",
	callback = function()
		vim.lsp.buf.format {
			timeout_ms = 2000,
			filter = function(client)
				return pcall(function(_client)
					return _client.config.settings.autoFixOnSave or false
				end, client) or false
			end
		}
	end
})
