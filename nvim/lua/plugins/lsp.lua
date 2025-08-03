local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float(popup_opts)<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

local on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl',
		'<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.format({ timeout_ms = 5000 })<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>b', '<cmd>! black %<CR><CR>', opts)
end

local sumneko_root_path = "/usr/bin/lua-language-server"
local sumneko_binary = "/usr/bin/lua-language-server"

local lspconfig = require("lspconfig")

vim.diagnostic.config({
	float = { border = "rounded" },
	virtual_text = {
		prefix = '●',
		spacing = 4,
		source = "if_many",
	},
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

lspconfig.lua_ls.setup {
	on_attach = on_attach,
	cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
				path = vim.split(package.path, ';')
			},
			diagnostics = {
				globals = { 'vim' }
			},
			workspace = {
				library = {
					[vim.fn.expand('$VIMRUNTIME/lua')] = true,
					[vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
				}
			}
		}
	}
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = false

lspconfig.clangd.setup {
	cmd = { "clangd", "--clang-tidy" },
	on_attach = on_attach,
	capabilities = capabilities,
	flags = {
		allow_incremental_sync = false,
		debounce_text_changes = 150,
	},
	filetypes = { "c", "cpp", "objc", "objcpp" },
	root_dir = require('lspconfig').util.root_pattern("src"),
	init_option = { fallbackFlags = { "-std=c++2a" } },
}

lspconfig.tinymist.setup {
	on_attach = on_attach,
	settings = {
		formatterMode = "typstyle",
	},
}

local servers = { 'glsl_analyzer', 'pyright', 'texlab', 'jdtls', 'ts_ls', 'rust_analyzer', 'html', 'intelephense' }
for _, lsp in pairs(servers) do
	lspconfig[lsp].setup {
		on_attach = on_attach,
		flags = {
			allow_incremental_sync = false,
			debounce_text_changes = 150,
		},

	}
end
