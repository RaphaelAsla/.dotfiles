local M = {}

function M.setup()
	local cmp = require('cmp')

	local kind_icons = {
		Text = "",
		Method = "",
		Function = "",
		Constructor = "",
		Field = "",
		Variable = "𝓥",
		Class = "ﴯ",
		Interface = "",
		Module = "",
		Property = "ﰠ",
		Unit = "",
		Value = "",
		Enum = "",
		Keyword = "",
		Snippet = "",
		Color = "",
		File = "",
		Reference = "",
		Folder = "",
		EnumMember = "",
		Constant = "",
		Struct = "",
		Event = "",
		Operator = "",
		TypeParameter = ""
	}

	cmp.setup({
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		preselect = cmp.PreselectMode.None,
		mapping = cmp.mapping.preset.insert({
			['<C-k>'] = cmp.mapping.scroll_docs(-4),
			['<C-j>'] = cmp.mapping.scroll_docs(4),
			['<C-e>'] = cmp.mapping.abort(),
			["<Tab>"] = cmp.mapping.select_next_item(),
			["<S-Tab>"] = cmp.mapping.select_prev_item(),
			['<CR>'] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = false
			}),
		}),
		formatting = {
			format = function(entry, vim_item)
				vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
				vim_item.menu = ({
					buffer = "[Buffer]",
					nvim_lsp = "[LSP]",
					path = "[Path]",
					cmdline = "[CMD]",
				})[entry.source.name]
				return vim_item
			end
		},
		sources = cmp.config.sources({
			{ name = 'nvim_lsp',               max_item_count = 15 },
			{ name = 'nvim_lsp_signature_help' },
		}, {
			{ name = 'buffer', max_item_count = 3 },
			{ name = 'path' },
		})
	})

	-- Command line completion
	cmp.setup.cmdline('/', {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = 'buffer' }
		}
	})

	cmp.setup.cmdline(':', {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = 'path' }
		}, {
			{ name = 'cmdline' }
		})
	})
end

return M

