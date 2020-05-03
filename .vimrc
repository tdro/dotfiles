" Clear all mappings.
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
set showmatch                            " Briefly show matching tags.
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
set autoindent                           " Copy indent from current line to new line.
set ignorecase                           " Ignore case on search.
set smartcase                            " Search by case smartly.
set lazyredraw                           " Do not redraw screen when using macros.
set viminfo+=n~/.vim/viminfo             " Set viminfo file path

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
set tabstop=2 softtabstop=0 shiftwidth=2 smarttab expandtab

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
  :silent !notify-send "$(phpcbf %)" &
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

" ESLint Fix
function! ESLintFix()
  :silent !notify-send "$(eslint --fix %)"
  :redraw!
endfunction

" Ansible Check
function! AnsibleCheck()
  :term ansible-playbook --syntax-check %
endfunction

" Shell Check
function! ShellCheck()
  :term shellcheck -x %
endfunction


"---------------Shortcuts---------------"

" Edit shortcuts
nmap <Leader>ev :tabedit /etc/vimrc<cr>
nmap <Leader>ep :tabedit ~/.vim/plugins.vim<cr>
nmap <Leader>eh :tabedit ~/.vim/post-save-hook<cr>
nmap <Leader>es :UltiSnipsEdit<cr>

" Git, tags, and help commands
nmap <Leader>fgf :GFiles<cr>
nmap <Leader>fgs :GFiles?<cr>
nmap <Leader>fgc :Commits<cr>
nmap <Leader>ftb :BTags<cr>
nmap <Leader>flh :Helptags<cr>
nmap <Leader>flc :Commands<cr>

" Show key mappings
nmap <Leader>mm :Maps<cr>
nmap <Leader>ma :Marks<cr>

" Print working directory
nmap <Leader>di :pwd<cr>

" Load and save sessions
nmap <Leader>sl :source ~/.vim/sessions/session.vim \| :source ~/.vimrc<cr>
nmap <Leader>ss :silent! exec "!~/.vim/hooks/pre-session-save && notify-send 'Vim session saved.'" \| :mksession! ~/.vim/sessions/session.vim \| :redraw!<cr>

" Switch between spaces and tabs
nmap <Leader>set :set tabstop=2 softtabstop=0 shiftwidth=2 smarttab noexpandtab \| :%retab!<cr>
nmap <Leader>ses :set tabstop=2 softtabstop=0 shiftwidth=2 smarttab expandtab \| :%retab!<cr>

" Close buffer and window
nmap <Leader>q :bd<cr>
nmap <Leader>w <C-w>c<cr>

" Linting shortcuts
nmap <Leader>lat :ALEToggle<cr>
nmap <Leader>lph :call HTMLBeautify()<cr>
nmap <Leader>lpc :call CSSBeautify()<cr>
nmap <Leader>lpa :call AnsibleCheck()<cr>
nmap <Leader>lps :call ShellCheck()<cr>

" Re-indent entire file
nmap <Leader>re gg=G<Leader>o<Leader>o

" Reset all settings and source configuration.
nmap <Leader>ra :set all& \| :source /etc/vimrc \| :e<cr>

" PHP REPL
nmap <Leader>rps :.w !psysh<cr>
nmap <Leader>rpf :term psysh %<cr>
nmap <Leader>rpt :term php artisan tinker<cr>
nmap <Leader>rpl :term psysh-tinker-live %<cr>

" Toggle color column
nmap <leader>cv :execute "set colorcolumn=" . (&colorcolumn == "" ? "80" : "")<cr>

" Toggle color column
nmap <leader>cx :set cursorcolumn!<cr>

" File open mappings
nmap <Leader>oh :History<cr>
nmap <Leader>oc :History:<cr>
nmap <Leader>ol :Locate<space>
nmap <Leader>od :call fzf#run({'options': ['--preview', 'ls {}'], 'source': "cut -d' ' -f3 $HOME/Documents/.fzf-marks", 'sink': 'cd', 'down': '20%'})<cr>:pwd<cr>
nmap <Leader>oo :call fzf#run({'options': ['--preview', 'head -20 {}'], 'source': 'rg --files --hidden', 'sink': 'e', 'down': '20%'})<cr>
nmap <Leader>oa :call fzf#run({'options': ['--preview', 'head -20 {}'], 'source': 'find . -type f -printf "%P\n"', 'sink': 'e', 'down': '20%'})<cr>
nmap <Leader>of :call fzf#run({'options': [], 'source': "cat $HOME/Documents/.fzf-fmarks", 'sink': 'e', 'down': '20%'})<cr>:pwd<cr>

" View function documentation
nmap <Leader>vdp
      \ :call fzf#run({'options': ['--preview', 'echo doc {} \| psysh \| fold -s -w 80'], 'source': "cat $HOME/.vim/tags/php", 'sink': ':term psysh-doc', 'down': '50%'})<cr>

" Mappings for nnn
nmap <Leader>nn :NnnPicker '%:p:h'<CR>
nmap <Leader>nm :NnnPicker<CR>

" Mappings for pdv
nmap <Leader>dd :call pdv#DocumentWithSnip()<CR>

" Exit incremental search
nmap <Esc><Esc> :nohl<cr>

" Toggle Spell Check
nmap <C-s> :set spell!<cr>

" Close Vim.
nmap <C-c> :qa<cr>

" Split window mappings
nmap <Bslash> :vsplit<cr>
nmap <C-Bslash> :split<cr>
nmap <C-h> :vertical resize +5<cr>
nmap <C-l> :vertical resize -5<cr>
nmap <C-j> :resize +5<cr>
nmap <C-k> :resize -5<cr>

" Show open buffers
nmap <Tab> :Buffers<cr>

" Search lines in buffer and open files
nmap <C-f> :BLines<cr>
nmap <C-d> :Lines<cr>
nmap <C-p> :Hist<cr>

" Inverse Tabs
nnoremap <S-Tab> <<
inoremap <S-Tab> <C-d>

" Retain visual selection when tabbing
vnoremap < <gv
vnoremap > >gv


"---------------Plugin Settings---------------"

" Grep Replace
set grepprg=ag
let g:grep_cmd_opts = '--line-numbers --noheading'

" Asynchronous Lint Engine (ale)
let g:ale_enabled = 0

" pdv
let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"

" UltiSnips
let g:UltiSnipsSnippetsDir='~/.vim/ultisnips'
let g:UltiSnipsSnippetDirectories=["ultisnips"]
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" nnn settings
let g:nnn#command = 'nnn -H'            " Override default command
let g:nnn#set_default_mappings = 0      " Disable default mappings
let g:nnn#layout = 'new'                " Opens the nnn window in a split
let g:nnn#layout = { 'left': '~20%' }   " Left 20% of the window


"----------------Autorun----------------"
augroup AutoCommands

  " Clear auto commands.
  autocmd!

  " Reload vimrc on vimrc file save.
  autocmd BufWritePost vimrc source %
      \ | :silent ! cp /etc/vimrc ~/.vimrc

  " Reload plugins.vim on file save.
  autocmd BufWritePost plugins.vim source %

  " Linting auto commands.
  autocmd BufWritePost *.php :call PHPFix()
  autocmd BufWritePost *.js :call ESLintFix()

  " Automatically create quotes database on save.
  autocmd BufWritePost quotes silent !notify-send "$(strfile %)"

  " Automatically remove trailing white space on save.
  autocmd InsertLeave,BufWritePre * %s/\s\+$//e

  " Automatically save file on insert and idle.
  autocmd InsertLeave,CursorHoldI * silent! write
        \ | silent! exec "!~/.vim/hooks/post-save > /dev/null 2>&1 &"

augroup END

set cmdheight=1 " Set command height back to the default.
