" Source plugin manager
so ~/.vim/bundle/vim-plug/plug.vim

" Specify a directory for plugins
call plug#begin('~/.vim/bundle')

Plug 'junegunn/vim-plug',         { 'tag': 'e718868e85e2a32410144dfcdc3ba1303719450d' }
Plug 'junegunn/fzf.vim',          { 'tag': 'f86ef1bce602713fe0b5b68f4bdca8c6943ecb59' }
Plug 'sjl/gundo.vim',             { 'tag': 'c5efef192b975b8e7d5fa3c6db932648d3b76323' }
Plug 'mcchrish/nnn.vim',          { 'tag': 'bfc91b503769920a366b12851b871795c0eb6825' }
Plug 'tpope/vim-fugitive',        { 'tag': '85e2c73830b6bb01ce7fc3a926d2b25836a253eb' }
Plug 'tpope/vim-surround',        { 'tag': 'f51a26d3710629d031806305b6c8727189cd1935' }
Plug 'gerw/vim-HiLinkTrace',      { 'tag': '64da6bf463362967876fdee19c6c8d7dd3d0bf0f' }
Plug 'pangloss/vim-javascript',   { 'tag': 'c3966153e81bc3766b1627e6ab0cd53333b61c1e' }
Plug 'elixir-editors/vim-elixir', { 'tag': '53c530f79cfcd12498e31fcf8ecc466eba34c75c' }

" Enable fzf.vim on Debian.
silent! source /usr/share/doc/fzf/examples/fzf.vim

" Initialize plugin system
call plug#end()
