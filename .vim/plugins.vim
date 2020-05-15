" Source plugin manager
so ~/.vim/bundle/vim-plug/plug.vim

" Specify a directory for plugins
call plug#begin('~/.vim/bundle')

Plug 'junegunn/vim-plug'
Plug 'junegunn/fzf.vim',              { 'tag': 'f86ef1bce602713fe0b5b68f4bdca8c6943ecb59' }
Plug 'mcchrish/nnn.vim',              { 'tag': 'bfc91b503769920a366b12851b871795c0eb6825' }
Plug 'skwp/greplace.vim',             { 'tag': 'a34dff350f4f35d35f6265ab2abef152bc836ca8' }
Plug 'pangloss/vim-javascript',       { 'tag': 'c3966153e81bc3766b1627e6ab0cd53333b61c1e' }
Plug 'tpope/vim-surround',            { 'tag': 'f51a26d3710629d031806305b6c8727189cd1935' }
Plug 'MarcWeber/vim-addon-mw-utils',  { 'tag': '6aaf4fee472db7cbec6d2c8eea69fdf3a8f8a75d' }
Plug 'tomtom/tlib_vim',               { 'tag': 'a071b6d41b20069a3520e0d101194a752968973b' }
Plug 'tobyS/pdv',                     { 'tag': '0e4b5aa689400246069953147ce53905c912087d' }
Plug 'tobyS/vmustache',               { 'tag': 'd39f77bafef57ba7af304c74b3cfc91a83fd86e0' }
Plug 'dense-analysis/ale',            { 'tag': '64b9a2708d1b5c2ce2c04eee1f64508c75b7bbb4' }
Plug 'tpope/vim-fugitive',            { 'tag': '85e2c73830b6bb01ce7fc3a926d2b25836a253eb' }

" Enable fzf.vim on Debian.
silent! source /usr/share/doc/fzf/examples/fzf.vim

" Initialize plugin system
call plug#end()
