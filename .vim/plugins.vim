filetype off                  " required

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'junegunn/fzf.vim'
Plugin 'skwp/greplace.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'tpope/vim-surround'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'tobyS/pdv'
Plugin 'tobyS/vmustache'
Plugin 'SirVer/ultisnips'
Plugin 'mcchrish/nnn.vim'
Plugin 'dense-analysis/ale'
Plugin 'tpope/vim-fugitive'

" Enable fzf.vim on Debian
silent! source /usr/share/doc/fzf/examples/fzf.vim

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
