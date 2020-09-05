" Clear all mappings.
mapclear

" Add match tag pairs package.
packadd! matchit

" Do not load defaults if ~/.vimrc is missing.
let skip_defaults_vim=1

" Source plugins.
so ~/.vim/plugins.vim


"------------General Settings------------"

let mapleader = "\<space>"               " Set default map leader.

syntax enable                            " Enable syntax highlighting.

set ruler                                " Show the cursor position all the time.
set nowrap                               " Do not wrap lines.
set nonumber                             " Set line numbers.
set hlsearch                             " Enable search.
set incsearch                            " Set incremental search.
set showmatch                            " Briefly show matching tags.
set nocompatible                         " Use Vim defaults.
set splitbelow                           " Open horizontal splits below.
set splitright                           " Open vertical splits to the right.
set cursorline                           " Set cursor line highlight.
set notimeout                            " Wait indefinitely for complete key combinations.
set ttimeout                             " Prevent pressing <Esc> twice.
set showcmd                              " Show key presses in status line.

set hidden                               " Set hidden buffers.
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
set undofile                             " Enable undofile.
set viminfo+=n~/.vim/viminfo             " Set viminfo file path.
set undodir=~/.vim/undodir               " Set undofile directory.

set mouse=a                              " Enable mouse.
set shortmess+=I                         " Disable startup message.
set showtabline=0                        " Disable tab bar.
set updatetime=1500                      " Set duration for cursor hold event.
set fillchars=                           " Set split window margin fill to none.
set laststatus=0                         " Disable status bar.
set linespace=3                          " Set line spaces.
set guiheadroom=0                        " Disable headroom on window maximize.
set history=50                           " Keep 50 lines of command line history.
set clipboard=unnamed                    " Use clipboard as default register.
set backspace=indent,eol,start           " Enable backspacing.
set formatoptions-=t                     " Do not auto wrap text when typing.
set complete=.,w,b,u                     " Set our desired autocompletion match pattern.
set encoding=utf-8                       " Set UTF-8 encoding.
set scrolloff=3                          " Set vertical scroll headroom.
set sidescroll=3                         " Set horizontal column scroll.
set sidescrolloff=10                     " Set horizontal scroll headroom.

" Convert tab to spaces.
set tabstop=2 softtabstop=0 shiftwidth=2 smarttab expandtab

" Highlight HTML and SQL in PHP.
let php_sql_query = 1
let php_htmlInStrings = 1

" Highlight JavaScript
let g:javascript_plugin_jsdoc = 1


"----------------Visuals----------------"

" Set color scheme.
colorscheme fluid

" Remove scrollbars in gui.
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

" Remove menubar, toolbar, and tabs in gui.
set guioptions-=m
set guioptions-=T
set guioptions-=e

" Set fold column
set foldcolumn=2


"---------------Functions---------------"

" PHP Fixer
function! PHPFix()
  :silent !notify-send "$(phpcbf % 2>&1)"
  :redraw!
endfunction

" HTML Beautify
function! HTMLBeautify()
  :silent !notify-send "$(prettier --write --parser html % 2>&1)"
  :redraw!
endfunction

" CSS Beautify
function! CSSBeautify()
  :silent !notify-send "$(prettier --write --parser css %)"
endfunction

" ESLint Fix
function! ESLintFix()
  :silent !notify-send -t 10000 "$(eslint -c $HOME/.config/eslintrc.yml --fix %)" >/dev/null 2>&1
endfunction

" Ansible Check
function! AnsibleCheck()
  :silent !notify-send -t 10000 "$(ansible-playbook --syntax-check % 2>&1)" &
endfunction

" Shell Check
function! ShellCheck()
  :silent !notify-send -t 10000 "$(shellcheck -x --exclude=SC1090,SC1091 % && echo 'Shellcheck OK: %')" >/dev/null 2>&1 &
endfunction

" Nix Check
function! NixCheck()
  :silent !notify-send -t 10000 "$(nix-linter % 2>&1 && echo 'Nix Lint OK: %' && nixfmt %)" >/dev/null 2>&1
  :redraw!
endfunction


"---------------Shortcuts---------------"

" Edit shortcuts
nmap <Leader>ev :tabedit ~/.vimrc<cr>
nmap <Leader>ep :tabedit ~/.vim/plugins.vim<cr>
nmap <Leader>eh :tabedit ~/.vim/post-save-hook<cr>

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

" Search documentation under cursor
nmap <Leader>dm :exe ':term ++close fzf-man ' . expand('<cword>')<cr>
nmap <Leader>di :exe ':term ++close fzf-doc ' . expand('<cword>')<cr>
nmap <Leader>dt :exe ':term dict -h localhost -d dict-moby-thesaurus-latest ' . expand('<cword>')<cr>

" View function documentation
nmap <Leader>dp :call fzf#run({'options': ['--preview', 'echo doc {} \| psysh \| fold -s -w 80'], 'source': "psysh-doc", 'sink': ':term psysh-doc', 'down': '50%'})<cr>

" Jump to line
nmap <Leader>jl :norm yaW<cr> \| :Jump<cr>

" Load and save sessions
nmap <Leader>sl :source ~/.vim/sessions/session.vim \| :source ~/.vimrc<cr>
nmap <Leader>ss :silent! exe "!~/.vim/hooks/pre-session-save && notify-send 'Vim session saved.'" \| :mksession! ~/.vim/sessions/session.vim \| :redraw!<cr>

" Toggle Spell Check
nmap <Leader>sp :set spell!<cr>

" Sort lines by length
vnoremap <leader>sn !perl -e 'print sort { length($a) <=> length($b) } <>'<cr>

" Switch between tabs and spaces
nmap <Leader>ses :set tabstop=2 softtabstop=0 shiftwidth=2 smarttab expandtab \| :%retab!<cr>
nmap <Leader>set :set tabstop=2 softtabstop=0 shiftwidth=2 smarttab noexpandtab \| :%retab!<cr>

" Close buffer and window
nmap <Leader>q :bd<cr>
nmap <Leader>w <C-w>c<cr>

" Linting shortcuts
nmap <Leader>lph :call HTMLBeautify()<cr>
nmap <Leader>lpc :call CSSBeautify()<cr>

" Re-indent entire file
nmap <Leader>re gg=G<C-o><C-o>

" Reset all settings and source configuration.
nmap <Leader>ra :set all& \| :source ~/.vimrc \| :e<cr>

" Toggle color column
nmap <leader>cv :exe "set colorcolumn=" . (&colorcolumn == "" ? "80" : "")<cr>

" Toggle cursor column
nmap <leader>cx :set cursorcolumn!<cr>

" Justify columns
vnoremap <leader>ct !column -t -o' '<cr>

" File open mappings
nmap <Tab> :Buffers<cr>
nmap <Leader>ov :Lines<cr>
nmap <Leader>ob :BLines<cr>
nmap <Leader>op :History<cr>
nmap <Leader>oc :History:<cr>
nmap <Leader>ol :Locate<space>
nmap <Leader>ot :exe '! urxvt -cd ' . expand('%:p:h') . ' &'<cr><cr>
nmap <Leader>of :call fzf#run({'options': [], 'source': "cat $FZF_FILE_MARKS", 'sink': 'e', 'down': '20%'})<cr>:pwd<cr>
nmap <Leader>od :call fzf#run({'options': ['--preview', 'ls {}'], 'source': "cut -d' ' -f3 $FZF_DIRECTORY_MARKS", 'sink': 'cd', 'down': '20%'})<cr>:pwd<cr>
nmap <Leader>oo :call fzf#run({'options': ['--preview', 'highlight -O ansi --force {}'], 'source': 'rg --files --hidden \|\| find . -type f -printf "%P\n"', 'sink': 'e', 'down': '20%'})<cr>

" Mappings for nnn
nmap <Leader>nm :NnnPicker<cr>
nmap <Leader>nn :NnnPicker '%:p:h'<cr>

" Exit incremental search
nmap <Esc><Esc> :nohl<cr>

" Disable Ex Mode
nnoremap Q <Nop>

" Split window mappings
nmap <Bslash> :vsplit<cr>
nmap <C-j> :resize +5<cr>
nmap <C-k> :resize -5<cr>
nmap <C-Bslash> :split<cr>
nmap <C-h> :vertical resize +5<cr>
nmap <C-l> :vertical resize -5<cr>

" Inverse Tabs
inoremap <S-Tab> <C-d>

" Retain visual selection when tabbing
vnoremap < <gv
vnoremap > >gv

" Prevent cursor from jumping in visual select context https://ddrscott.github.io/blog/2016/yank-without-jank/
vnoremap <expr>y "my\"" . v:register . "y`y"


"---------------Plugin Settings---------------"

" netrw settings
let g:netrw_banner=0

" nnn settings
let g:nnn#command = 'nnn -H'            " Override default command
let g:nnn#set_default_mappings = 0      " Disable default mappings
let g:nnn#layout = 'new'                " Opens the nnn window in a split
let g:nnn#layout = { 'left': '~20%' }   " Left 20% of the window


"-------------------Scripts-------------------"

" https://vi.stackexchange.com/questions/14300/vim-how-to-send-entire-line-to-a-buffer-of-type-terminal
function s:repl(start, end, language)
  let g:terminal_buffer = get(g:, 'terminal_buffer', -1)
  if g:terminal_buffer == -1 || !bufexists(g:terminal_buffer)
    terminal ++rows=10
    let g:terminal_buffer = bufnr('')
    call term_sendkeys(g:terminal_buffer, a:language . "; exit" . "\<cr>")
    wincmd p
  elseif bufwinnr(g:terminal_buffer) == -1
    exe 'sbuffer ' . g:terminal_buffer
    wincmd p
  endif
  call term_sendkeys(g:terminal_buffer, join(getline(a:start, a:end), "\<cr>") . "\<cr>")
endfunction

" jump to line and column in the format 123:13
function s:cursor(selection)
  wincmd p
  let g:cursor_request = split(a:selection, ":")
  call cursor(g:cursor_request[0], g:cursor_request[1])
endfunction

command! -nargs=? -range Jump call s:cursor(@*)

command! -nargs=? -range REPL call s:repl(<line1>, <line2>, <f-args>)


"----------------Autorun----------------"

augroup AutoCommands

  " Clear auto commands.
  autocmd!

  " Reload vimrc on vimrc file save.
  autocmd BufWritePost .vimrc source % | silent !notify-send 'Sourcing vimrc...'

  " Reload plugins.vim on file save.
  autocmd BufWritePost plugins.vim source % | silent !notify-send 'Sourcing plugins...'

  " Linting auto commands.
  autocmd BufWritePost *.php :call PHPFix()
  autocmd BufWritePost *.js :call ESLintFix()
  autocmd BufWritePost *.yml :call AnsibleCheck()
  autocmd BufWritePost *.txt,*.md :only | :term ++rows=10 vale-wrapper %
  autocmd FileType bash,sh autocmd! BufWritePost <buffer> :call ShellCheck()
  autocmd FileType nix autocmd! BufWritePost <buffer> silent call NixCheck()
  autocmd FileType rust autocmd! BufWritePost <buffer> silent !notify-send "$(rustfmt % 2>&1 && echo 'rustfmt OK:' %)"

  " REPL commands
  autocmd FileType go noremap <buffer> <leader>cc :REPL gore<cr>
  autocmd FileType lua noremap <buffer> <leader>cc :REPL lua<cr>
  autocmd FileType php noremap <buffer> <leader>cc :REPL psysh<cr>
  autocmd FileType elixir noremap <buffer> <leader>cc :REPL iex<cr>
  autocmd FileType sh noremap <buffer> <leader>cc :REPL dash -x<cr>
  autocmd FileType rust noremap <buffer> <leader>cc :REPL evcxr<cr>
  autocmd FileType nix noremap <buffer> <leader>cc :REPL nix repl<cr>
  autocmd FileType bash noremap <buffer> <leader>cc :REPL bash -x<cr>
  autocmd FileType python noremap <buffer> <leader>cc :REPL python<cr>
  autocmd FileType perl noremap <buffer> <leader>cc :REPL perl -de0<cr>
  autocmd FileType javascript noremap <buffer> <leader>cc :REPL node<cr>

  " General auto commands.
  autocmd BufWritePost *.tex :term ++close ++rows=10 latex-compile %
  autocmd BufWritePost rc.lua silent !notify-send "$(awesome -k 2>&1)"
  autocmd BufWritePost quotes,*.fortune silent !notify-send "$(strfile %)"
  autocmd BufWritePost $HOME/.config/chromexup/config.ini silent !notify-send "$(chromexup 2>&1)"
  autocmd BufWritePost *.desktop silent !notify-send "$(desktop-file-validate % 2>&1 && echo 'OK: %')"
  autocmd BufWritePost Xresources silent !xrdb ~/.config/X11/Xresources && notify-send 'Reloading Xresources...'

  " Automatically remove trailing white space on save.
  autocmd InsertLeave,BufWritePre * %s/\s\+$//e

  " Automatically save file on insert and idle.
  autocmd InsertLeave,CursorHold * silent! write
    \| silent! exe "!~/.vim/hooks/post-save > /dev/null 2>&1 &"
    \| :echo @% '[filetype=' . &filetype . ']'

augroup END

set cmdheight=999     " Set command height temporarily to avoid prompt.
set cmdheight=1       " Set command height back to the default.
