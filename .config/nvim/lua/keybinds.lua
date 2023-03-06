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
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
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
