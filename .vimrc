runtime! archlinux.vim

" Clear mappings
:mapclear

" Do not load defaults if ~/.vimrc is missing.
let skip_defaults_vim=1

" Source plugins.
so ~/.vim/plugins.vim


"------------General Settings------------"

let mapleader = "\<space>"               " Set default map leader.

syntax enable                            " Enable syntax highlighting.

set ruler                                " Show the cursor position all the time.
set nowrap                               " Do not automatically wrap on file load.
set nonumber                             " Set line numbers.
set hlsearch                             " Enable search.
set incsearch                            " Set incremental search.
set nocompatible                         " Use Vim defaults.
set splitbelow                           " Open horizontal splits below.
set splitright                           " Open vertical splits to the right.
set cursorline                           " Set cursor line highlight.

set nohidden                             " No hidden buffers.
set nobackup                             " No write backups.
set noswapfile                           " Disable swap files.
set nowritebackup                        " No overwrite backups.
set autoread                             " Auto read file on external change.
set autowrite                            " Write if modified.
set autowriteall                         " Write if modifed on buffer change.

set mouse=a                              " Enable visual mode.
set shortmess+=I                         " Disable startup message.
set showtabline=0                        " Disable tab bar.
set updatetime=250                       " Set duration for cursor hold event.
set fillchars=                           " Set split window margin fill to none.
set laststatus=0                         " Disable split window status bar.
set linespace=3                          " Set line spaces.
set guiheadroom=0                        " Disable headroom on window maximize.
set history=50                           " Keep 50 lines of command line history.
set clipboard=unnamed                    " Use clipboard as default register.
set backspace=indent,eol,start           " Enable backspacing.
set formatoptions-=t                     " Do not auto wrap text when typing.
set complete=.,w,b,u                     " Set our desired autocompletion match pattern.

" Convert tab to spaces.
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab

" Highlight HTML and SQL in PHP.
let php_sql_query = 1
let php_htmlInStrings = 1

" Highlight Javascript
let g:javascript_plugin_jsdoc = 1

" Vim infinite undo.
set undofile
set undodir=~/.vim/undodir


"----------------Visuals----------------"

colorscheme material-monokai             " Set colorscheme.
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
hi foldcolumn ctermbg=none

" Set vetical split column color.
hi vertsplit ctermfg=236 ctermbg=none

" Set horizontal split column color.
hi statuslinenc ctermfg=238 ctermbg=255

" Set cursor hightlight color.
hi CursorLine cterm=none ctermbg=238 ctermfg=none

" Remove end of buffer indicator.
highlight EndOfBuffer ctermfg=black

" Remove Background Color
hi Normal ctermbg=none


"---------------Shortcuts---------------"

" Edit /etc/vimrc.
nmap <Leader>ev :tabedit /etc/vimrc<cr>
nmap <Leader>es :UltiSnipsEdit<cr>

" Locate search.
nmap <Leader>f :Locate<space>

" Show key mappings
nmap <Leader>m :Maps<cr>

" Print working directory
nmap <Leader>di :pwd<cr>

" Reindent entire file
nmap <Leader>r gg=G<Leader>o<Leader>o

" Remap jump key binding.
nnoremap <Leader>o <C-o>

" Exit incremental search.
nmap <Esc><Esc> :nohl<cr>

" Cycle through buffers.
nmap ' :bnext<cr>

" Close Vim.
nmap <C-c> :qa<cr>

" Toggle Spell Check
nmap <C-s> :set spell!<cr>

" Remap split window keys.
nmap <Bslash> :vsplit<cr>
nmap <C-Bslash> :split<cr>
nmap <C-h> :vertical resize +5<cr>
nmap <C-l> :vertical resize -5<cr>
nmap <C-j> :resize +5<cr>
nmap <C-k> :resize -5<cr>

" FZF key mappings.
nmap <C-p> :Hist<cr>
nmap <C-f> :Lines<cr>
nmap <C-x> :GFiles?<cr>
nmap <C-g> :BTags<cr>
nmap <Tab> :Buffers<cr>

" FZF function mappings.
nmap <C-o> :call fzf#run({'source': 'rg --files --hidden', 'sink': 'e', 'down': '20%'})<cr>
nmap <C-d> :call fzf#run({'source': 'cat ~/.vim/projects', 'sink': 'cd', 'down': '20%'})<cr>:pwd<cr>

" Inverse Tabs
nnoremap <S-Tab> <<
inoremap <S-Tab> <C-d>

" Retain visual selection when tabbing
vnoremap < <gv
vnoremap > >gv

" Move lines around.
nnoremap 0 :m-2<cr>==
xnoremap 0 :m-2<cr>gv=gv
nnoremap 9 :m+<cr>==
xnoremap 9 :m'>+<cr>gv=gv

" Grep Replace
set grepprg=ag
let g:grep_cmd_opts = '--line-numbers --noheading'

" Vim Vinegar
nmap . <Plug>VinegarUp

" pdv
let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"
nnoremap <Leader>dd :call pdv#DocumentWithSnip()<CR>

" UltiSnips
let g:UltiSnipsSnippetsDir='~/.vim/ultisnips'
let g:UltiSnipsSnippetDirectories=["ultisnips"]
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" nnn settings
let g:nnn#set_default_mappings = 0      " Disable default mappings
let g:nnn#layout = 'new'                " Opens the nnn window in a split
let g:nnn#layout = { 'left': '~20%' }   " Left 20% of the window

nmap <C-n> :NnnPicker<cr>


"----------------Autorun----------------"

augroup autosaving

    " Clear auto commands.
    autocmd!

    " Reload vimrc on vimrc file save.
    autocmd BufWritePost vimrc source %
                \ | :silent ! cp /etc/vimrc ~/.vimrc

augroup END

" Automatically save the session on leaving vim.
autocmd! VimLeave * mksession! ~/.vim/Session.vim

" Automatically load the session when entering vim.
autocmd! VimEnter * source ~/.vim/Session.vim

" Automatically load variables overriden by the session.
autocmd VimEnter *
            \ highlight EndOfBuffer ctermfg=black
            \ | hi Normal ctermbg=none
            \ | hi foldcolumn ctermbg=none
            \ | hi vertsplit ctermfg=236 ctermbg=none
            \ | hi statuslinenc ctermfg=238 ctermbg=255
            \ | hi CursorLine cterm=none ctermbg=238 ctermfg=none

" Automatically remove trailing whitespace on save.
autocmd InsertLeave,BufWritePre * %s/\s\+$//e

" Automatically save file on insert and idle.
autocmd TextChanged,InsertLeave,CursorHoldI * silent! write
      " \ | silent! exec "!chromix-too reload 172 > /dev/null 2>&1 &"
