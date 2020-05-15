" Source plugin manager
so ~/.vim/bundle/vim-plug/plug.vim

" Specify a directory for plugins
call plug#begin('~/.vim/bundle')

Plug 'junegunn/vim-plug'
Plug 'junegunn/fzf.vim',              { 'tag': 'f86ef1bce602713fe0b5b68f4bdca8c6943ecb59' }
Plug 'mcchrish/nnn.vim',              { 'tag': 'bfc91b503769920a366b12851b871795c0eb6825' }
Plug 'pangloss/vim-javascript',       { 'tag': 'c3966153e81bc3766b1627e6ab0cd53333b61c1e' }
Plug 'tpope/vim-surround',            { 'tag': 'f51a26d3710629d031806305b6c8727189cd1935' }
Plug 'tpope/vim-fugitive',            { 'tag': '85e2c73830b6bb01ce7fc3a926d2b25836a253eb' }

" Enable fzf.vim on Debian.
silent! source /usr/share/doc/fzf/examples/fzf.vim

" Initialize plugin system
call plug#end()
