" キーマップに関する設定を追記
" jjで <ESC>キーとする
inoremap <silent> jj <ESC>
" ノーマルモードのときのみコロンが入力される(USキーボード)
nnoremap ; :
nnoremap : ;
vnoremap : :
vnoremap : ;

""" 関連するプラグイン tyru/caw.vim.git
nmap <C-K> <Plug>(caw:hatpos:toggle)
vmap <C-K> <Plug>(caw:hatpos:toggle)

""" 関連するプラグイン preservim/nerdtree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
