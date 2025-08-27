local M = {}

-- LSP keymaps setup function
local function setup_keymaps(bufnr)
	local keymap = vim.keymap.set
	local opts = { buffer = bufnr, silent = true }

	-- Diagnostic keymaps
	keymap("n", "<space>e", vim.diagnostic.open_float, opts)
	keymap("n", "[d", vim.diagnostic.goto_prev, opts)
	keymap("n", "]d", vim.diagnostic.goto_next, opts)
	keymap("n", "<space>q", vim.diagnostic.setloclist, opts)

	-- LSP keymaps
	keymap("n", "gD", vim.lsp.buf.declaration, opts)
	keymap("n", "gd", vim.lsp.buf.definition, opts)
	keymap("n", "K", vim.lsp.buf.hover, opts)
	keymap("n", "gi", vim.lsp.buf.implementation, opts)
	keymap("n", "<C-k>", vim.lsp.buf.signature_help, opts)
	keymap("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
	keymap("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
	keymap("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts)
	keymap("n", "<space>D", vim.lsp.buf.type_definition, opts)
	keymap("n", "<space>rn", vim.lsp.buf.rename, opts)
	keymap("n", "<space>ca", vim.lsp.buf.code_action, opts)
	keymap("n", "gr", vim.lsp.buf.references, opts)
	keymap("n", "<space>f", function()
		vim.lsp.buf.format({ timeout_ms = 5000 })
	end, opts)
	keymap("n", "<space>b", "<cmd>!black %<CR><CR>", opts)
end

-- Common on_attach function
local function on_attach(client, bufnr)
	-- Setup keymaps
	setup_keymaps(bufnr)
end

-- Setup function
function M.setup()
	-- Configure LSP hover with borders
	local hover = vim.lsp.buf.hover
	---@diagnostic disable-next-line: duplicate-set-field
	vim.lsp.buf.hover = function()
		return hover({
			border = "rounded",
		})
	end

	-- Diagnostic configuration
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

	-- Get lspconfig
	local lspconfig = require("lspconfig")

	-- Setup capabilities for nvim-cmp
	local capabilities = require('cmp_nvim_lsp').default_capabilities(
		vim.lsp.protocol.make_client_capabilities()
	)
	capabilities.textDocument.completion.completionItem.snippetSupport = false

	-- Lua LSP
	lspconfig.lua_ls.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		settings = {
			Lua = {
				runtime = {
					version = 'LuaJIT',
				},
				diagnostics = {
					globals = { 'vim' },
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
					checkThirdParty = false,
				},
				telemetry = {
					enable = false,
				},
			},
		},
	})

	-- Clangd LSP
	lspconfig.clangd.setup({
		cmd = { "clangd", "--clang-tidy" },
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = { "c", "cpp", "objc", "objcpp" },
		root_dir = lspconfig.util.root_pattern("src", "compile_commands.json", ".git"),
		init_options = {
			fallbackFlags = { "-std=c++2a" },
		},
	})

	-- Tinymist (Typst LSP)
	lspconfig.tinymist.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		settings = {
			formatterMode = "typstyle",
		},
	})

	-- Other language servers
	local servers = {
		'glsl_analyzer',
		'pyright',
		'texlab',
		'jdtls',
		'ts_ls',
		'rust_analyzer',
		'html',
		'intelephense',
		'gopls'
	}

	for _, server in pairs(servers) do
		lspconfig[server].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
	end
end

return M
