map <F8> <Esc>:set nu<CR>
map <C-F7> <Esc>:set nonu<CR>

filetype indent on
syntax on
colorscheme default

"common conf {{             通用配置
set ai                      "自动缩进
set bs=2                    "在insert模式下用退格键删除
set showmatch               "代码匹配
set laststatus=2            "总是显示状态行
"set expandtab               "以下三个配置配合使用，设置tab和缩进空格数
set shiftwidth=4
set tabstop=4
set cursorline              "为光标所在行加下划线
set number                  "显示行号
set autoread                "文件在Vim之外修改过，自动重新读入

set ignorecase              "检索时忽略大小�?
set fileencodings=uft-8,gbk "使用utf-8或gbk打开文件
set hls                     "检索时高亮显示匹配�?
set helplang=cn             "帮助系统设置为中�?
set foldmethod=syntax       "代码折叠
set ruler
set cindent
set history=1000
set showcmd
"}}
"
let &termencoding=&encoding

"conf for tabs, 为标签页进行的配置，通过ctrl h/l切换标签�?
let mapleader = ','
nnoremap <C-l> gt
nnoremap <C-h> gT
nnoremap <leader>t : tabe<CR>"

set tags=./tags;

set nocompatible              " 去除VI一致�?必须要添�?
filetype off                  " 必须要添�?

" 设置包括vundle和初始化相关的runtime path
set rtp+=$VIM/vimfiles/bundle/Vundle.vim/
call vundle#begin('$VIM/vimfiles/bundle/')
" 另一种选择, 指定一个vundle安装插件的路�?
"call vundle#begin('~/some/path/here')

" 让vundle管理插件版本,必须
Plugin 'VundleVim/Vundle.vim'

" 以下范例用来支持不同格式的插件安�?
Plugin 'Raimondi/delimitMate'
Plugin 'scrooloose/nerdtree'
Plugin 'TagHighlight'
Plugin 'tpope/vim-commentary'
Plugin 'honza/vim-snippets'
Plugin 'Shougo/neocomplete.vim'
Plugin 'majutsushi/tagbar'
Plugin 'SirVer/ultisnips'
Plugin 'Lokaltog/vim-powerline'
Plugin 'a.vim'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'taglist.vim'
Plugin 'YankRing.vim'
Plugin 'DoxygenToolkit.vim'
Plugin 'wincent/command-t'
" 你的所有插件需要在下面这行之前
call vundle#end()            " 必须
filetype plugin indent on    " 必须 加载vim自带和插件相应的语法和文件类型相关脚�?
" 忽视插件改变缩进,可以使用以下替代:
"filetype plugin on
"
" 常用的命�?
" :PluginList       - 列出所有已配置的插�?
" :PluginInstall     - 安装插件,追加 `!` 用以更新或使�?:PluginUpdate
" :PluginSearch foo - 搜索 foo ; 追加 `!` 清除本地缓存
" :PluginClean      - 清除未使用插�?需要确�? 追加 `!` 自动批准移除未使用插�?

nnoremap <silent> <F9> :YRShow<CR> "打开剪贴�?
nnoremap <silent> <F12> :A<CR>

if has("autocmd")
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
\| exe "normal g'\"" | endif
endif

"s：查找C代码符号
"g：查找本定义
"c：查找调用本函数的函�?
"t：查找本字符�?
"e：查找本egrep模式
"f：查找本文件
"i：查找包含本文件的文�?
"d：查找本函数调用的函�?
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

