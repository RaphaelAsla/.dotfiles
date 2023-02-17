local cmp = require 'cmp'

cmp.setup({
	preselect = cmp.PreselectMode.None,
	mapping = {
		['<C-k>'] = cmp.mapping.scroll_docs( -4),
		['<C-j>'] = cmp.mapping.scroll_docs(4),
		['<C-e>'] = cmp.mapping.abort(),
		["<tab>"] = cmp.mapping.select_next_item(),
		["<S-tab>"] = cmp.mapping.select_prev_item(),
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = false
		}),
	},
	sources = cmp.config.sources({
		{ name = 'nvim_lsp', max_item_count = 15 },
		{ name = 'buffer',   max_item_count = 3 },
	})
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})
