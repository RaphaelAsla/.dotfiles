vim.api.nvim_exec([[
"Exit inssert mode
inoremap jj <ESC>

"Indent left/right and re-select
vnoremap < <gv
vnoremap > >gv

"Copy paste stuff
xnoremap <expr> p 'pgv"'.v:register.'y`>'
xnoremap <expr> P 'Pgv"'.v:register.'y`>'

"Delete without copying
map <leader>d "_d

"Clear highlighted text
nnoremap <silent><esc> :noh<CR>

"Go to start  of line
map 0 ^

"Write sudo files
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!

"Open close brackets
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

"Open neovim config
nnoremap <leader>e :tabnew ~/.config/nvim/lua<CR>

"Search and replace
nnoremap <leader>s :%s/

"Explorer
nnoremap <leader><tab> :Explore <CR>

"Disable recording
map q <Nop>

"Tabs
nnoremap <leader>tn :tabnew<cr>
nnoremap <leader>to :tabonly<cr>
nnoremap <leader>tc :tabclose<cr>
nnoremap <leader>tm :tabmove

"Telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope git_files<cr>
nnoremap <leader>fw <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

"Go to tab by number
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt
nnoremap <leader>0 :tablast<cr>

"Surround words in brackets
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a`<esc>`<i`<esc>

"Move line
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==
vnoremap <leader>j :m '>+1<CR>gv=gv
vnoremap <leader>k :m '<-2<CR>gv=gv

"Opens a new tab with the current buffer's path
"Super useful when editing files in the same directory
map <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/

"Get current dir
nnoremap <leader>cd :cd %:p:h<cr>:pwd<cr>

map <F5> :call CompileRun()<CR>
map <F6> :call BuildRun()<CR>

func! BuildRun()
exec "w"
exec "!cd ../build && make"
exec "!../build/./$(grep \"add_executable\" ../CMakeLists.txt | sed 's/.*(\\(.*\\))/\\1/')"
endfunc

func! CompileRun()
exec "w"
if &filetype == 'c'
    exec "!clang -Wall % -o %<"
    exec "!./%<"
elseif &filetype == 'cpp'
    exec "!clang++ -std=c++20 -Wall % -o %<"
    exec "!./%<"
elseif &filetype == 'cuda'
    exec "!nvcc -std=c++17 % -o %<"
    exec "!./%<"
elseif &filetype == 'rust'
    exec "!cargo run"
elseif &filetype == 'java'
    exec "!javac %"
    exec "!java %"
elseif &filetype == 'sh'
    exec "!bash %"
elseif &filetype == 'python'
    exec "!python3 %"
elseif &filetype == 'html'
    exec "!google-chrome-stable % &"
elseif &filetype == 'go'
    exec "!go build %<"
    exec "!go run %"
elseif &filetype == 'matlab'
    exec "!octave %"
elseif &filetype == 'javascript'
	exec "!node %"
elseif &filetype == 'asm'
	exec "!nasm -f elf64 %"
	exec "!ld %<.o -o %<"
	exec "!rm -rf %<.o"
	exec "!./%<"
endif
endfunc
]], false)

-- START COPYPASTA https://github.com/neovim/neovim/commit/5b04e46d23b65413d934d812d61d8720b815eb1c
local util = require 'vim.lsp.util'
--- Formats a buffer using the attached (and optionally filtered) language
--- server clients.
---
--- @param options table|nil Optional table which holds the following optional fields:
---     - formatting_options (table|nil):
---         Can be used to specify FormattingOptions. Some unspecified options will be
---         automatically derived from the current Neovim options.
---         @see https://microsoft.github.io/language-server-protocol/specification#textDocument_formatting
---     - timeout_ms (integer|nil, default 1000):
---         Time in milliseconds to block for formatting requests. Formatting requests are current
---         synchronous to prevent editing of the buffer.
---     - bufnr (number|nil):
---         Restrict formatting to the clients attached to the given buffer, defaults to the current
---         buffer (0).
---     - filter (function|nil):
---         Predicate to filter clients used for formatting. Receives the list of clients attached
---         to bufnr as the argument and must return the list of clients on which to request
---         formatting. Example:
---
---         <pre>
---         -- Never request typescript-language-server for formatting
---         vim.lsp.buf.format {
---           filter = function(clients)
---             return vim.tbl_filter(
---               function(client) return client.name ~= "tsserver" end,
---               clients
---             )
---           end
---         }
---         </pre>
---
---     - id (number|nil):
---         Restrict formatting to the client with ID (client.id) matching this field.
---     - name (string|nil):
---         Restrict formatting to the client with name (client.name) matching this field.
vim.lsp.buf.format = function(options)
	options = options or {}
	local bufnr = options.bufnr or vim.api.nvim_get_current_buf()
	local clients = vim.lsp.buf_get_clients(bufnr)

	if options.filter then
		clients = options.filter(clients)
	elseif options.id then
		clients = vim.tbl_filter(
			function(client) return client.id == options.id end,
			clients
		)
	elseif options.name then
		clients = vim.tbl_filter(
			function(client) return client.name == options.name end,
			clients
		)
	end

	clients = vim.tbl_filter(
		function(client) return client.supports_method 'textDocument/formatting' end,
		clients
	)

	if #clients == 0 then
		vim.notify '[LSP] Format request failed, no matching language servers.'
	end

	local timeout_ms = options.timeout_ms or 1000
	for _, client in pairs(clients) do
		local params = util.make_formatting_params(options.formatting_options)
		local result, err = client.request_sync('textDocument/formatting', params, timeout_ms, bufnr)
		if result and result.result then
			util.apply_text_edits(result.result, bufnr, client.offset_encoding)
		elseif err then
			vim.notify(string.format('[LSP][%s] %s', client.name, err), vim.log.levels.WARN)
		end
	end
end
-- END COPYPASTA


vim.api.nvim_create_augroup('LspFormatting', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
	pattern = '*',
	group = 'LspFormatting',
	callback = function()
		vim.lsp.buf.format {
			timeout_ms = 2000,
			filter = function(clients)
				return vim.tbl_filter(function(client)
					return pcall(function(_client)
						return _client.config.settings.autoFixOnSave or false
					end, client) or false
				end, clients)
			end
		}
	end
})
