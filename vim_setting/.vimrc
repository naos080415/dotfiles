"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

let s:dein_path = expand('~/.cache/dein')
let s:dein_repo_path = s:dein_path . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_path)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_path
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_path, ':p')
endif

if dein#load_state(s:dein_path)
  call dein#begin(s:dein_path)

  let g:config_dir  = expand('~/dotfiles/vim_setting')
  let s:toml        = g:config_dir . '/plugin.toml'
  let s:lazy_toml   = g:config_dir . '/plugin_lazy.toml'

  " TOML 読み込み
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif
 
" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
"End dein Scripts-------------------------

"""""""""""""""  vimの設定  """""""""""""""
inoremap <silent> jj <ESC>
inoremap <silent> っj <ESC>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
" ファイルpathの保管
" inoremap <TAB><TAB> <C-x><C-f>
" 行番号を表示する
set number
" コマンド ":syntax enable" は現在の色設定を変更しない。そのため、このコマンドを
syntax enable
filetype on
filetype plugin on
set encoding=UTF-8
" 行番号の色
highlight LineNr ctermfg=darkyellow
" 検索結果をハイライト表示するj
set hlsearch
""" タブの設定 """
" タブ入力を複数の空白入力に置き換える
set expandtab
" タブの表示幅
set tabstop=2
" 連続した空白に対してタブキーやバックスペースでカーネルが動く幅
set softtabstop=2
" autoindent の設定
set autoindent
set smartindent
" vimが挿入するインデントの幅
set shiftwidth=2
augroup fileTypeIndent
  autocmd!
    autocmd BufNewFile,BufRead *.c,*.cpp,*.h,*.hpp setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END
" " pythonのインデント設定
" # で始まる行のインデントを保持する
inoremap # X<C-H>#
autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl tabstop=8 expandtab shiftwidth=4 softtabstop=4

" 暗い背景色に合わせた配色にする
set background=dark
" 保存されていないファイルがあるときでも別のファイルを開けるようにする
set hidden
" vim クリップボードの有効化 apt vim-gtk
set clipboard=unnamedplus
" 削除キーでヤンクしない
nnoremap x "_x
nnoremap d "_d
" スワップファイルをさくせいしない
set noswapfile
" カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]
"BSで削除できるものを指定する
"" indent  : 行頭の空白
" eol     : 改行
" " start   : 挿入モード開始位置より手前の文字
set backspace=indent,eol,start
" leaderキーを[#]に設定
let mapleader = "#"
" ノーマルモードのときのみコロンが入力される(USキーボード)
nnoremap ; :
nnoremap : ;
vnoremap : :
vnoremap : ;
set clipboard+=unnamed
" カーソルの形を変更する
if has('vim_starting')
    " 挿入モード時に非点滅の縦棒タイプのカーソル
    let &t_SI .= "\e[6 q"
    " ノーマルモード時に非点滅のブロックタイプのカーソル
    let &t_EI .= "\e[2 q"
    " 置換モード時に非点滅の下線タイプのカーソル
    let &t_SR .= "\e[4 q"
endif
"""""""""""""""  vimの設定  """""""""""""""

"""""""""""""""  autopep8   """""""""""""""
" autopep8を<sift>+fで実行
function! Preserve(command)
    " Save the last search.
    let search = @/
    " Save the current cursor position.
    let cursor_position = getpos('.')
    " Save the current window position.
    normal! H
    let window_position = getpos('.')
    call setpos('.', cursor_position)
    " Execute the command.
    execute a:command
    " Restore the last search.
    let @/ = search
    " Restore the previous window position.
    call setpos('.', window_position)
    normal! zt
    " Restore the previous cursor position.
    call setpos('.', cursor_position)
endfunction
function! Autopep8()
    call Preserve(':silent %!autopep8 -')
endfunction
autocmd FileType python nnoremap <S-f> :call Autopep8()<CR>
"""""""""""""""  autopep8   """""""""""""""

"""""""""""""""  flake8   """""""""""""""
" ファイル保存時にFlake8を実行
let g:flake8_ignore = 'E501'
let g:flake8_quickfix_location="topleft" " Quickfixの位置
let g:flake8_quickfix_height=7 " Quickfixの高さ
let g:flake8_show_in_gutter=1  " 左端にシンボルを表示
let g:flake8_show_in_file=1  " ファイル内にマークを表示
" autocmd BufWritePost *.py call Flake8()
"""""""""""""""  flake8   """""""""""""""

"""""""""""""""  プラグインの設定   """""""""""""""
""" 関連するプラグイン vim-airline/vim-airline  vim-airline/vim-airline-themes
""" themeを選択(https://github.com/vim-airline/vim-airline/wiki/Screenshots)
let g:airline_theme = 'angr'
" タブの有効化
let g:airline#extensions#tabline#enabled = 1
" タブをwindow切り替える
nmap <C-p> <Plug>AirlineSelectPrevTab
nmap <C-n> <Plug>AirlineSelectNextTab
" タブに番号を表示
let g:airline#extensions#tabline#buffer_idx_mode = 1
" タブの数字を大きくする
let g:airline#extensions#tabline#buffer_idx_format = {
	\ '0': '0 ',
	\ '1': '1 ',
	\ '2': '2 ',
	\ '3': '3 ',
	\ '4': '4 ',
	\ '5': '5 ',
	\ '6': '6 ',
	\ '7': '7 ',
	\ '8': '8 ',
	\ '9': '9 '
	\}
" タブの区切りを設定
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

""" 関連するプラグイン tpope/vim-fugitive
"下記のコマンドは動いてなさそう。なんでだろうか？
" nnoremap <leader>ga :Git add %:p<CR><CR>
" nnoremap <leader>gc :Gcommit<CR><CR>
" nnoremap <leader>gs :Gstatus<CR>
" nnoremap <leader>gp :Gpush<CR>
" nnoremap <leader>gd :Gdiff<CR>
" nnoremap <leader>gl :Glog<CR>
" nnoremap <leader>gb :Gblame<CR>

""" 関連するプラグイン tpope/vim-
" gitの変更点を表示する時間間隔を短くする(デフォルトでは4000 msぐらいかかるらしい)
set updatetime=250

""" 関連するプラグイン taketwo/vim-ros
let g:ycm_semantic_triggers = {
\   'roslaunch' : ['="', '$(', '/'],
\   'rosmsg,rossrv,rosaction' : ['re!^', '/'],
\ }

""" cppファイルを上書き保存したときに,オートフォーマットをかける。
" cファイルも入れると思うけど,なんかできない。
" 関連するプラグイン rhysd/vim-clang-format 
" AlignConsecutiveAssignments : = で整列
" AlignTrailingComments : 末尾のコメント行を揃える
" BinPackArguments , BinPackParameters : 関数の引数をまとめる
let g:clang_format#style_options = {
            \ "BasedOnStyle" : 'Google',
            \ "ColumnLimit" : 120,
            \ "AccessModifierOffset" : -2,
            \ "ContinuationIndentWidth" : 2,
            \ "SpacesBeforeTrailingComments" : 8,
            \ "AlignConsecutiveAssignments" : "true",
            \ "AlignTrailingComments" : "true",
            \ "BinPackArguments" : "true",
            \ "BinPackParameters" : "true",
            \ "UseTab" : 'Never',
            \ "Standard" : "Cpp11"}
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" if you install vim-operator-user
autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>
autocmd FileType c ClangFormatAutoEnable
autocmd FileType cpp ClangFormatAutoEnable

""" cppファイルにシンタックスハイライトを設定
" 1 → ハイライトあり 0 → ハイライトなし(https://github.com/octol/vim-cpp-enhanced-highlight)
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1
let g:cpp_no_function_highlight = 1

""" 関連するプラグイン nanotech/jellybeans.vim
colorscheme jellybeans

""" 関連するプラグイン tyru/caw.vim.git
nmap <C-K> <Plug>(caw:hatpos:toggle)
vmap <C-K> <Plug>(caw:hatpos:toggle)

""" 関連するプラグイン preservim/nerdtree
" 隠しファイルを表示する
let NERDTreeShowHidden=1   
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>

""" 関連するプラグイン vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap cf <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap cf <Plug>(EasyAlign)
