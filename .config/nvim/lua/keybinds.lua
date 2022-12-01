vim.api.nvim_exec([[
inoremap jj <ESC>

" surround words in brackets
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a`<esc>`<i`<esc>

" copy paste stuff
xnoremap <expr> p 'pgv"'.v:register.'y`>'
xnoremap <expr> P 'Pgv"'.v:register.'y`>'

" delete without copying
vnoremap <leader>d "_d

" un-highlight text
map <C-space> ?
map <silent> <leader><cr> :noh<cr>

" i don't remember
map 0 ^

" write without sudo
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!

" open close brackets
"inoremap ( ()<left>
"inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
"inoremap [ []<left>
"inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
"inoremap { {}<left>
"inoremap <expr> } strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

"Open neovim config
map <leader>e :Explore ~/.config/nvim/lua<CR>

"Telescope
noremap <leader>ff :Telescope find_files<CR>

" tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 

" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" Move line
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==
vnoremap <leader>j :m '>+1<CR>gv=gv
vnoremap <leader>k :m '<-2<CR>gv=gv

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/

" get current dir
map <leader>cd :cd %:p:h<cr>:pwd<cr>

map <F5> :call CompileRun()<CR>
imap <F5> <Esc>:call CompileRun()<CR>
vmap <F5> <Esc>:call CompileRun()<CR>

map <F6> :call BuildRun()<CR>
imap <F6> <Esc>:call BuildRun()<CR>
vmap <F6> <Esc>:call BuildRun()<CR>

func! BuildRun()
exec "w"
exec "!cd ../tbuild && ninja"
exec "!../tbuild/./$(grep \"add_executable\" ../CMakeLists.txt | sed 's/.*(\\(.*\\))/\\1/')"
endfunc

func! CompileRun()
exec "w"
if &filetype == 'c'
    exec "!clang -Wall % -o %<"
    exec "!./%<"
elseif &filetype == 'cpp'
    exec "!clang++ -std=c++20 -Wall % -o %<"
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
	exec "!nasm -f bin % -o %<.bin"
	exec "!xxd %<.bin"
	exec "!qemu-system-x86_64 -drive format=raw,file=%<.bin"
endif
endfunc
]], false)
