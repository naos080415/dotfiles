"dein Scripts-----------------------------
set nocompatible
set encoding=utf-8
scriptencoding utf-8

filetype plugin indent off
syntax off

if &compatible
  set nocompatible               " be improved
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

  let g:config_dir  = expand('~/dotfiles/neovim_setting')
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

" " Required:
filetype plugin indent on

syntax on
"End dein Scripts-------------------------
