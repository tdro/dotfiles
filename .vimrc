" Clear all mappings
mapclear

runtime! archlinux.vim
packadd! matchit

" Do not load defaults if ~/.vimrc is missing.
let skip_defaults_vim=1

" Source plugins.
so ~/.vim/plugins.vim


"------------General Settings------------"

let mapleader = "\<space>"               " Set default map leader.

syntax enable                            " Enable syntax highlighting.

set ruler                                " Show the cursor position all the time.
set wrap                                 " Automatically wrap lines.
set nonumber                             " Set line numbers.
set hlsearch                             " Enable search.
set incsearch                            " Set incremental search.
set nocompatible                         " Use Vim defaults.
set splitbelow                           " Open horizontal splits below.
set splitright                           " Open vertical splits to the right.
set cursorline                           " Set cursor line highlight.
set cmdheight=10                         " Set command height temporarily to avoid prompt.

set nohidden                             " No hidden buffers.
set nobackup                             " No write backups.
set noswapfile                           " Disable swap files.
set nowritebackup                        " No overwrite backups.
set autoread                             " Auto read file on external change.
set autowrite                            " Write if modified.
set autowriteall                         " Write if modified on buffer change.

set mouse=a                              " Enable visual mode.
set shortmess+=I                         " Disable startup message.
set showtabline=0                        " Disable tab bar.
set updatetime=1500                      " Set duration for cursor hold event.
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

" Highlight JavaScript
let g:javascript_plugin_jsdoc = 1

" Vim infinite undo.
set undofile
set undodir=~/.vim/undodir


"----------------Visuals----------------"

colorscheme material-monokai             " Set color scheme.
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

" Set vertical split column color.
hi vertsplit ctermfg=236 ctermbg=237

" Set horizontal split column color.
hi statuslinenc ctermfg=237 ctermbg=255

" Set cursor line color.
hi CursorLine cterm=none ctermbg=237 ctermfg=none

" Set cursor column color.
hi CursorColumn cterm=none ctermbg=237 ctermfg=none

" Set color column color.
hi ColorColumn cterm=none ctermbg=237 ctermfg=none

" Remove end of buffer indicator.
hi EndOfBuffer ctermfg=black

" Remove background color.
hi Normal ctermbg=none

" Clear gutter color.
hi clear SignColumn


"---------------Functions---------------"

" PHP Fixer
function! PHPFix()
  :silent !notify-send "$(phpcbf %) &"
  :redraw!
endfunction

" HTML Beautify
function! HTMLBeautify()
  :silent !notify-send "$(prettier --write --parser html %)"
  :redraw!
endfunction

" CSS Beautify
function! CSSBeautify()
  :silent !notify-send "$(prettier --write --parser css %)"
  :redraw!
endfunction


"---------------Shortcuts---------------"

" Edit shortcuts.
nmap <Leader>ev :tabedit /etc/vimrc<cr>
nmap <Leader>ep :tabedit ~/.vim/plugins.vim<cr>
nmap <Leader>eh :tabedit ~/.vim/post-save-hook<cr>
nmap <Leader>es :UltiSnipsEdit<cr>

" Locate search.
nmap <Leader>fl :Locate<space>

" Show key mappings
nmap <Leader>mm :Maps<cr>
nmap <Leader>ma :Marks<cr>

" Print working directory
nmap <Leader>di :pwd<cr>

" Close buffer and window
nmap <Leader>q :bd<cr>
nmap <Leader>w <C-w>c<cr>

" Linting shortcuts.
nmap <Leader>la :ALEToggle<cr>
nmap <Leader>lph :call HTMLBeautify()<cr>
nmap <Leader>lpc :call CSSBeautify()<cr>

" Re-indent entire file.
nmap <Leader>re gg=G<Leader>o<Leader>o
" Reset all settings and source configuration.
nmap <Leader>ra :set all& \| :source /etc/vimrc \| :e<cr>

" PHP REPL
nmap <Leader>rps :.w !psysh<cr>
nmap <Leader>rpf :term psysh %<cr>
nmap <Leader>rpt :term php artisan tinker<cr>
nmap <Leader>rpl :term psysh-tinker-live %<cr>

" Remap jump key binding.
nnoremap <Leader>o <C-o>

" Toggle color column
nnoremap <leader>cv :execute "set colorcolumn=" . (&colorcolumn == "" ? "80" : "")<cr>

" Toggle color column
nnoremap <leader>cx :set cursorcolumn!<cr>

" Exit incremental search.
nmap <Esc><Esc> :nohl<cr>

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
nmap <C-o> :call fzf#run({'options': ['--preview', 'head -20 {}'], 'source': 'rg --files --hidden', 'sink': 'e', 'down': '20%'})<cr>
nmap <C-d> :call fzf#run({'options': ['--preview', 'ls {}'], 'source': "cut -d' ' -f3 $HOME/.config/fzf-marks/.fzf-marks", 'sink': 'cd', 'down': '20%'})<cr>:pwd<cr>
nmap <Leader>rpd :call fzf#run({'options': ['--preview', 'echo doc {} \| psysh'], 'source': "cat $HOME/.vim/tags/php", 'sink': ':term psysh-doc', 'down': '50%'})<cr>

" nnn mappings.
nmap <C-n> :NnnPicker<CR>
nmap <Leader>n :NnnPicker '%:p:h'<CR>

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


"---------------Plugin Settings---------------"

" Grep Replace
set grepprg=ag
let g:grep_cmd_opts = '--line-numbers --noheading'

" Asynchronous Lint Engine (ale)
let g:ale_enabled = 0

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

"----------------Autorun----------------"
augroup AutoSourcing

  " Clear auto commands.
  autocmd!

  " Reload vimrc on vimrc file save.
  autocmd BufWritePost vimrc source %
      \ | :silent ! cp /etc/vimrc ~/.vimrc

  " Reload plugins.vim on file save.
  autocmd BufWritePost plugins.vim source %

augroup END

augroup AutoLinting

  autocmd!
  autocmd BufWritePost *.php :call PHPFix()

augroup END

" Automatically save the session on leaving vim.
autocmd! VimLeave * mksession! ~/.vim/Session.vim

" Automatically load the session when entering vim.
autocmd! VimEnter * source ~/.vim/Session.vim
      \ | source ~/.vimrc " Source configuration after session load.

" Automatically remove trailing white space on save.
autocmd! InsertLeave,BufWritePre * %s/\s\+$//e

" Automatically save file on insert and idle.
autocmd! InsertLeave,CursorHoldI * silent! write
      \ | silent! exec "!~/.vim/post-save-hook > /dev/null 2>&1 &"

set cmdheight=1 " Set command height back to the default.
