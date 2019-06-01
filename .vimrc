runtime! archlinux.vim

" Do not load defaults if ~/.vimrc is missing.
let skip_defaults_vim=1

" Source plugins.
so ~/.vim/plugins.vim

"------------General Settings------------"

let mapleader = ','                      " Set default map leader.

syntax enable                            " Enable syntax highlighting.

set ruler                                " Show the cursor position all the time.
set nowrap                               " Do not automatically wrap on file load.
set nonumber                             " Set line numbers.
set hlsearch                             " Enable search.
set incsearch                            " Set incremental search.
set noswapfile                           " Disable swap files.
set nocompatible                         " Use Vim defaults.
set splitbelow                           " Open horizontal splits below.
set splitright                           " Open vertical splits to the right.

set mouse=a                              " Enable visual mode.
set shortmess+=I                         " Disable startup message.
set showtabline=0                        " Disable tab bar.
set fillchars=                           " Set split window margin fill to none.
set laststatus=0                         " Disable split window status bar.
set linespace=3                          " Set line spaces.
set guiheadroom=0                        " Disable headroom on window maximize.
set history=50                           " Keep 50 lines of command line history.
set clipboard=unnamed                    " Use clipboard as default register.
set backspace=indent,eol,start           " Enable backspacing.
set formatoptions-=t                     " Do not auto wrap text when typing.

" Convert tab to spaces.
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab

" Highlight HTML and SQL in PHP.
let php_sql_query = 1
let php_htmlInStrings = 1

" Vim infinite undo.
set undofile
set undodir=~/.vim/undodir

"----------------Visuals----------------"

colorscheme atom-dark                    " Set colorscheme.
set t_CO=256                             " Enable 256 terminal colors.

" Remove scrollbars in gui.
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

" Remove menubar, toolbar, and tabs in gui.
set guioptions-=m
set guioptions-=T
set guioptions-=e

" Set line number column bg color.
hi LineNr guibg=bg

" Define fold column and set to bg color.
set foldcolumn=2
hi foldcolumn guibg=bg
hi foldcolumn ctermbg=171717

" Set vetical split column color.
hi vertsplit guifg=#1b1b1b guibg=#1b1b1b
hi vertsplit ctermfg=black ctermbg=171717

" Set cursor hightlight color.
hi CursorLine cterm=none ctermbg=darkred ctermfg=white

" Remove end of buffer indicator.
highlight EndOfBuffer ctermfg=black guifg=black


"---------------Shortcuts---------------"

" Edit /etc/vimrc.
nmap <Leader>ev :tabedit /etc/vimrc<cr>

" Exit incremental search.
nmap <Leader><space> :nohlsearch<cr>

" Remap split window keys.
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-H> <C-W><C-H>
nmap <C-L> <C-W><C-L>

" CtrlP key mappings.
nmap <Leader>eb :CtrlPBufTag<cr>
nmap <Leader>em :CtrlPMRUFiles<cr>
let g:ctrlp_match_window = 'order:ttb,min:1,max:5,results:30'

" NERDTree settings.
nmap <C-n> :NERDTreeToggle<cr>
let NERDTreeMinimalUI = 1                " Enable minimal NERDTree UI.
let NERDTreeHijackNetrw = 0              " Prevent NERDTree from hijacking CtrlP.


"----------------Autorun----------------"

augroup autosourcing
    autocmd!
    autocmd BufWritePost vimrc source %
augroup END
  
