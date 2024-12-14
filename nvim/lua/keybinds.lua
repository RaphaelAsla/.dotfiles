vim.api.nvim_exec2([[
"Exit inssert mode
inoremap jj <esc>

"Indent line left or right and re-select the line
vnoremap < <gv
vnoremap > >gv

"Paste in visual mode without copying underlying text
xnoremap <expr> p 'pgv"'.v:register.'y`>'
xnoremap <expr> P 'Pgv"'.v:register.'y`>'

"Delete without copying
nnoremap d "_d
vnoremap d "_d

"Delete with copying
xnoremap D d

"Clear highlighted text
nnoremap <silent><esc> :noh<cr>

"Go to start  of line
map 0 ^

"Expand snippet with <C-l> in insert mode
inoremap <silent> <C-l> <C-R>UltiSnips#ExpandSnippet()<CR>

"Write to sudo files
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!

"Open close brackets
inoremap {<cr> {<cr>}<esc>O
inoremap {;<cr> {<cr>};<esc>O

"Open Neovim config settings with Telescope
nnoremap <silent><leader>eff :cd ~/.config/nvim/lua \| lua require('telescope.builtin').find_files({ cwd = vim.fn.getcwd() })<cr><esc>
nnoremap <silent><leader>efw :cd ~/.config/nvim/lua \| lua require('telescope.builtin').live_grep({ cwd = vim.fn.getcwd() })<cr>

"Search and replace
nnoremap <leader>s :%s/
vnoremap <leader>s :'<, '>s/

"Search and replace word under cursor
function! ReplaceUnder() range
  let l:pos = winsaveview()
  let l:word = expand('<cword>')
  let l:replacement = input('Replace ' . l:word . ' with: ')
  let l:command = '%s/' . l:word . '/' . l:replacement . '/'
  execute l:command
  call winrestview(l:pos)
endfunction
vnoremap <leader>r :call ReplaceUnder()<CR>

"Undo without moving cursor
nnoremap U :let save_cursor = getpos('.')<CR> :undo<CR> :call setpos('.', save_cursor)<CR>

"Explorer Netrw
nnoremap <leader><tab> :Explore <cr>

"Tabs
nnoremap <leader>tn :tabnew<cr>
nnoremap <leader>to :tabonly<cr>
nnoremap <leader>tc :tabclose<cr>
nnoremap <leader>tm :tabmove

"Splits (vertical and horizontal)
nnoremap <leader>vs :vsp <c-r>=expand("%:p:h")<cr>/
nnoremap <leader>hs :sp <c-r>=expand("%:p:h")<cr>/

"Move between splits
nnoremap <silent> <c-w>k :wincmd k<CR>
nnoremap <silent> <c-w>j :wincmd j<CR>
nnoremap <silent> <c-w>h :wincmd h<CR>
nnoremap <silent> <c-w>l :wincmd l<CR>

"Place cursor in middle when moving half a page
nnoremap <c-d> <c-d>zz
nnoremap <c-u> <c-u>zz

"Place cursor in middle when moving between matches
nnoremap n nzz
nnoremap N Nzz

"Telescope stuff
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

"Surround words in symbols / brackets / quotes e.t.c.
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a$<esc>`<i$<esc>
vnoremap $q <esc>`>a"<esc>"<i'<esc>
vnoremap $e <esc>`>a`<esc>`<i`<esc>

"Move line up and down
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv

"Opens a new tab with the current buffer's path
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

"Get current directory
nnoremap <leader>cd :cd %:p:h<cr>:pwd<cr>

"Build the project using make (must have custom target in CMakeLists.txt)
map <f6> :make<cr>

"Custom run for small programs
map <f5> :call CompileRun()<cr>

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
]], {})
