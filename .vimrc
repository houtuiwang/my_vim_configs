"common conf {{             通用配置
set ai                      "自动缩进
set bs=2                    "在insert模式下用退格键删除
set showmatch               "代码匹配
set laststatus=2            "总是显示状态行
set expandtab               "以下三个配置配合使用，设置tab和缩进空格数
set shiftwidth=4
set tabstop=4
set cursorline              "为光标所在行加下划线
set number                  "显示行号
set rnu                     "显示相对行号
set autoread                "文件在Vim之外修改过，自动重新读入
set ignorecase              "检索时忽略大小写
set smartcase               "如果有一个大写字母，则切换到大小写敏感查找
set fileencodings=utf-8,gbk "使用utf-8或gbk打开文件
set hls                     "检索时高亮显示匹配项
set helplang=cn             "帮助系统设置为中文
set ruler                   "设置标尺
set cindent                 "c语言分格对齐
set history=1000            "命令历史纪录1000行
set showcmd                 "显示命令
filetype indent on          "根据不同文件类型对齐
syntax on                   "语法支持
let &termencoding=&encoding "终端编码使用和encoding一样的编码
"}}

"conf for tabs, 为标签页进行的配置，通过ctrl h/l切换标签等
let mapleader = ' '
nnoremap <C-l> gt
nnoremap <C-h> gT
nnoremap <leader>t :tabe<CR>"

call plug#begin('~/.vim/plugged')
" 以下范例用来支持不同格式的插件安装.
Plug 'Raimondi/delimitMate'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'vim-scripts/TagHighlight'
Plug 'tpope/vim-commentary'
Plug 'honza/vim-snippets'
Plug 'majutsushi/tagbar'
Plug 'SirVer/ultisnips'
Plug 'vim-airline/vim-airline'
Plug 'vim-scripts/YankRing.vim'
Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'Yggdroot/LeaderF'
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/asyncrun.vim'
Plug 'skywind3000/gutentags_plus'
Plug 'skywind3000/vim-preview'
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
" Plug 'Valloric/YouCompleteMe'
Plug 'w0rp/ale'
Plug 'mhinz/vim-signify'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'tpope/vim-unimpaired'
Plug 'ekalinin/Dockerfile.vim'
Plug 'kergoth/vim-bitbake'
Plug 'rakr/vim-one'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'qpkorr/vim-renamer'
Plug 'mg979/vim-visual-multi'
Plug 'python-mode/python-mode'
Plug 'uguu-org/vim-matrix-screensaver'
Plug 'tomasiser/vim-code-dark'
call plug#end()

nnoremap <m-y> :YRShow<CR> "打开剪贴板
nnoremap <m-w> :w<CR>
nnoremap <m-q> :q<CR>
nnoremap <m-e> :term<CR>

nnoremap <m-1> <C-W>q
nnoremap <m-4> <C-W>w
inoremap <m-4> <C-O><C-W>w
nnoremap <m-3> <C-W>W
inoremap <m-3> <C-O><C-W>W
nnoremap <m-5> <C-W>=
nnoremap <m-v> <C-W>v

"打开文件自动跳到上次查看行
if has("autocmd")
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
\| exe "normal g'\"" | endif
endif

" gtags-cscope
"s：查找C代码符号
"g：查找本定义
"c：查找调用本函数的函数
"t：查找本字符串
"f：查找本文件
"i：查找包含本文件的文件
let g:gutentags_plus_nomap = 1
noremap <silent> <c-\>s :GscopeFind s <C-R><C-W><cr>
noremap <silent> <c-\>g :GscopeFind g <C-R><C-W><cr>
noremap <silent> <c-\>c :GscopeFind c <C-R><C-W><cr>
noremap <silent> <c-\>t :GscopeFind t <C-R><C-W><cr>
noremap <silent> <c-\>f :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>
noremap <silent> <c-\>i :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>

nmap <m-t> :NERDTreeMirror<CR>
nmap <m-t> :NERDTreeToggle<CR>

" Tagbar
nmap <m-c> :TagbarToggle<CR>

" vim ALT key
function! Terminal_MetaMode(mode)
    set ttimeout
    if $TMUX != ''
        set ttimeoutlen=30
    elseif &ttimeoutlen > 80 || &ttimeoutlen <= 0
        set ttimeoutlen=80
    endif
    if has('nvim') || has('gui_running')
        return
    endif
    function! s:metacode(mode, key)
        if a:mode == 0
            exec "set <M-".a:key.">=\e".a:key
        else
            exec "set <M-".a:key.">=\e]{0}".a:key."~"
        endif
    endfunc
    for i in range(10)
        call s:metacode(a:mode, nr2char(char2nr('0') + i))
    endfor
    for i in range(26)
        call s:metacode(a:mode, nr2char(char2nr('a') + i))
        call s:metacode(a:mode, nr2char(char2nr('A') + i))
    endfor
    if a:mode != 0
        for c in [',', '.', '/', ';', '[', ']', '{', '}']
            call s:metacode(a:mode, c)
        endfor
        for c in ['?', ':', '-', '_']
            call s:metacode(a:mode, c)
        endfor
    else
        for c in [',', '.', '/', ';', '{', '}']
            call s:metacode(a:mode, c)
        endfor
        for c in ['?', ':', '-', '_']
            call s:metacode(a:mode, c)
        endfor
    endif
endfunc

call Terminal_MetaMode(0)

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" LeaderF
let g:Lf_ShortcutF = '<m-f>'
noremap <m-m> :LeaderfMru<cr>
noremap <m-n> :LeaderfFunction!<cr>
noremap <m-b> :LeaderfBuffer<cr>
noremap <m-g> :LeaderfTag<cr>
let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }

let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.vim/cache')
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}

" YouCompleteMe
let g:ycm_key_list_select_completion = ['<m-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<m-p>', '<Up>']
let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'

let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_key_invoke_completion = '<m-z>'
set completeopt=menu,menuone

noremap <m-z> <NOP>

let g:ycm_semantic_triggers =  {
           \ 'c,cpp,python,vim,sh,zsh': ['re!\w{2}'],
           \ }

let g:ycm_use_clangd = 1

nnoremap <Leader>fi :YcmCompleter FixIt<CR>
nnoremap <Leader>gt :YcmCompleter GoTo<CR>

let g:ycm_auto_hover = ''
let g:ycm_complete_in_comments = 1
let g:ycm_filetype_whitelist = {
            \ 'c': 1,
            \ 'cpp': 1,
            \ 'python': 1,
            \ 'vim': 1,
            \ 'sh': 1,
            \ 'zsh': 1,
                                          \ }
let g:ycm_goto_buffer_command = 'split-or-existing-window'

" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'
" 同时开启 ctags 和 gtags 支持：
let g:gutentags_modules = []
if executable('ctags')
	let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
	let g:gutentags_modules += ['gtags_cscope']
endif
" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif
" 禁用 gutentags 自动加载 gtags 数据库的行为
let g:gutentags_auto_add_gtags_cscope = 0

" 自动打开 quickfix window ，高度为 6
let g:asyncrun_open = 6

" 任务结束时候响铃提醒
let g:asyncrun_bell = 1

" 设置 F10 打开/关闭 Quickfix 窗口
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>
nnoremap <silent> <F9> :AsyncRun gcc -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/a.out" <cr>
nnoremap <silent> <F6> :AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/a.out" <cr>
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml']
nnoremap <silent> <F7> :AsyncRun -cwd=<root> make <cr>

" airline
let g:airline_powerline_fonts = 1  
" ale
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_set_highlights = 0
nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)

let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''

" signify
set signcolumn=yes

" preview
autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>

" 用 Tab 键进行 delimitMate 的光标跳转（也就是说，输入左括号后使用 Tab 键就可跳转到 delimitMate 生成的右括号的右边，而无需 <S-TAB>），且不破坏 UltiSnips 的 Tab 键展开，同时禁用 delimitMate 自带的 <S-TAB>：
autocmd VimEnter * imap <silent> <expr> <TAB> delimitMate#ShouldJump() ? delimitMate#JumpAny() : "\<C-r>=UltiSnips#ExpandSnippetOrJump()\<CR>"
autocmd VimEnter * inoremap <S-TAB> <S-TAB>

" mapping h,j,k,l in insert mode
inoremap <C-H> <Left>
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-l> <right>

let g:airline_theme='one'
colorscheme one
" set background=dark " for the dark version
set background=light " for the light version

" colorscheme codedark
" let g:airline_theme = 'codedark'

set undofile
set undodir=~/.vim/undodir
if !isdirectory(&undodir)
    call mkdir(&undodir, 'p', 0700)
endif

set scrolloff=1

" 停止搜索高亮的键映射
nnoremap <silent> <m-2>      :nohlsearch<CR>

" 用于 quickfix、标签和文件跳转的键映射
nmap <F11>   :cn<CR>
nmap <F12>   :cp<CR>
nmap <M-F11> :tn<CR>
nmap <M-F12> :tp<CR>

let g:pymode_rope = 0

aug QFClose
    au!
    au WinEnter *  if winnr('$') == 1 && &buftype == "quickfix"|q|endif
aug END

let &t_TI=''
let &t_TE=''
