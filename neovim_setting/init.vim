let s:base_dir = expand('~/dotfiles/neovim_setting')

" runtimepathに追加
execute 'set runtimepath+=' . fnamemodify(s:base_dir, ':p')

runtime! dein.vim
runtime! basic.vim
runtime! keymaps.vim
runtime! appearance.vim
runtime! plugin.vim

