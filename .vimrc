map <F7> <Esc>:set nu<CR>
map <C-F7> <Esc>:set nonu<CR>

filetype indent on
syntax on
colorscheme default

set hlsearch
set incsearch
set nu
set ruler
set history=1000
set autoindent
set cindent
set cinoptions={0,:0,g0,l1,t0,(0)}
set autoread     
set ignorecase
set showcmd
set ts=4
set expandtab
set shiftwidth=4

set smartindent
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=79

set tags=./tags;

source $VIMRUNTIME/ftplugin/man.vim

let &termencoding=&encoding
set fileencodings=utf-8,gbk

nnoremap <silent> <F9> :YRShow<CR> "打开剪贴板
nnoremap <silent> <F12> :A<CR>

if has("autocmd")
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
\| exe "normal g'\"" | endif
endif

"s：查找C代码符号
"g：查找本定义
"c：查找调用本函数的函数
"t：查找本字符串
"e：查找本egrep模式
"f：查找本文件
"i：查找包含本文件的文件
"d：查找本函数调用的函数
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR> 	
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

function! LoadCscope()
    let db = findfile("cscope.out", ".;")
if (!empty(db))
    let path = strpart(db, 0, match(db, "/cscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
endif
    endfunction
    au BufEnter /* call LoadCscope()

execute pathogen#infect()
map <F4> :NERDTreeMirror<CR>
map <F4> :NERDTreeToggle<CR>
map <F5> :CommandT<CR>
map <F6> :CommandTBuffer<CR>

set guifont=PowerlineSymbols\ for\ Powerline
set nocompatible
set laststatus=2
set t_Co=256
let g:Powerline_symbols = 'fancy'
let Powerline_symbols='compatible'

set formatoptions=tcqro

nmap <F3> :TagbarToggle<CR>
let g:neocomplete#enable_at_startup = 1

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

