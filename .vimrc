"------------Setup-------------"

mapclear                                 " Clear all mappings.
packadd! matchit                         " Add match tag pairs package.
let skip_defaults_vim=1                  " Do not load defaults if ~/.vimrc is missing.


"------------Plugins------------"

source ~/.vim/bundle/vim-plug/plug.vim   " Source plugin manager

call plug#begin('~/.vim/bundle')         " Specify a directory for plugins

Plug 'junegunn/vim-plug',         { 'tag': 'e718868e85e2a32410144dfcdc3ba1303719450d' }
Plug 'junegunn/fzf.vim',          { 'tag': 'f86ef1bce602713fe0b5b68f4bdca8c6943ecb59' }
Plug 'sjl/gundo.vim',             { 'tag': 'c5efef192b975b8e7d5fa3c6db932648d3b76323' }
Plug 'mcchrish/nnn.vim',          { 'tag': 'bfc91b503769920a366b12851b871795c0eb6825' }
Plug 'tpope/vim-fugitive',        { 'tag': '85e2c73830b6bb01ce7fc3a926d2b25836a253eb' }
Plug 'gerw/vim-HiLinkTrace',      { 'tag': '64da6bf463362967876fdee19c6c8d7dd3d0bf0f' }
Plug 'elixir-editors/vim-elixir', { 'tag': '53c530f79cfcd12498e31fcf8ecc466eba34c75c' }

silent! source /usr/share/doc/fzf/examples/fzf.vim  " Enable fzf.vim on Debian.

call plug#end()                                     " Initialize plugin system


"------------General------------"

let mapleader = "\<space>"               " Set default map leader.
let php_htmlInStrings = 1                " Highlight HTML in PHP.

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
set wildmenu                             " Show tab completions menu.
set nojoinspaces                         " Insert one space after a '.', '?' and '!' with a join command.
set path+=**                             " Search subfolders.
set display=lastline                     " @@@ which indicates remaining line is not displayed.

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
set shortmess-=S                         " Count number of search result matches.
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
set foldcolumn=2                         " Set fold column width to 2.

" Convert tab to spaces.
set tabstop=2 softtabstop=0 shiftwidth=2 smarttab expandtab


"----------------Visuals----------------"

syntax enable                            " Enable syntax highlighting.
colorscheme fluid                        " Set color scheme.
set guioptions-=l                        " Remove left scrollbar in GUI.
set guioptions-=L                        " Remove left scrollbar in GUI vertical split.
set guioptions-=r                        " Remove right scrollbar in GUI.
set guioptions-=R                        " Remove right scrollbar in GUI vertical split.
set guioptions-=m                        " Remove menu in GUI.
set guioptions-=T                        " Remove toolbar in GUI.
set guioptions-=e                        " Remove tab bar in GUI.


"---------------Functions---------------"

" Ansible Check
function! AnsibleCheck()
  :exe 'Notify(''ansible-playbook --syntax-check ' . expand('%') . ' 2>&1'')' | :e
endfunction

" Typography Format
function! TypographyFormat()
  :silent! %s/\(^\|\s\|\w\)\zs--\ze\($\|\s\|\w\)/–/g | silent! %s/\(^\|\s\|\w\)\zs---\ze\($\|\s\|\w\)/—/g
  :silent! %s/ '/ ‘/g | silent! %s/' /’ /g | :silent! %s/^'/‘/g | silent! %s/'$/’/g
  :silent! %s/ "/ “/g | silent! %s/" /” /g | :silent! %s/^"/“/g | silent! %s/"$/”/g
  :silent! %s/\S\@='\S@!/’/g | :silent! %s/\S\@<='\S\@=/’/g
  :silent! %s/\S\@="\S@!/”/g | :silent! %s/\S\@<="\S\@=/”/g
endfunction


"---------------Shortcuts---------------"

" Edit shortcuts
nmap <leader>ev :tabedit ~/.vimrc<cr>
nmap <leader>eh :tabedit ~/.vim/post-save-hook<cr>

" Git, tags, and help commands
nmap <leader>fgf :GFiles<cr>
nmap <leader>fgs :GFiles?<cr>
nmap <leader>fgc :Commits<cr>
nmap <leader>ftb :BTags<cr>
nmap <leader>flh :Helptags<cr>
nmap <leader>flc :Commands<cr>

" Show key mappings
nmap <leader>mm :Maps<cr>
nmap <leader>ma :Marks<cr>

" Search documentation under cursor
nmap <leader>dm :exe ':term ++close fzf-man ' . expand('<cword>')<cr>
nmap <leader>di :exe ':term ++close fzf-doc ' . expand('<cword>')<cr>
nmap <leader>dt :exe ':term dict -h localhost -d dict-moby-thesaurus-latest ' . expand('<cword>')<cr>

" View function documentation
nmap <leader>dp :call fzf#run({'options': ['--preview', 'echo doc {} \| psysh \| fold -s -w 80'], 'source': "psysh-doc", 'sink': ':term psysh-doc', 'down': '50%'})<cr>

" Jump to line
nmap <leader>jl :norm yaW<cr> \| :Jump<cr>

" Load and save sessions
nmap <leader>sl :source ~/.vim/sessions/session.vim \| :source ~/.vimrc<cr>:Notify('printf "Last saved session loaded."')<cr>
nmap <leader>ss :silent! exe "!~/.vim/hooks/pre-session-save" \| :mksession! ~/.vim/sessions/session.vim \| :redraw!<cr>:Notify('printf "Current session saved."')<cr>

" Toggle Spell Check
nmap <leader>sp :set spell!<cr>

" Sort lines by length
vnoremap <leader>sn !perl -e 'print sort { length($a) <=> length($b) } <>'<cr>

" Switch between tabs and spaces
nmap <leader>ses :set tabstop=2 softtabstop=0 shiftwidth=2 smarttab expandtab \| :%retab!<cr>
nmap <leader>set :set tabstop=2 softtabstop=0 shiftwidth=2 smarttab noexpandtab \| :%retab!<cr>

" Close buffer and window
nmap <leader>q :bd<cr>
nmap <leader>w <C-w>c<cr>

" Re-indent entire file
nmap <leader>re gg=G<C-o><C-o>

" Reset all settings and source configuration.
nmap <leader>ra :set all& \| :source ~/.vimrc \| :e<cr>:Notify('printf "Settings cleared and reloaded."')<cr>

" Remove duplicate lines
vnoremap <leader>rd !awk '\!visited[$0]++'<cr>

" Toggle color column
nmap <leader>cv :exe "set colorcolumn=" . (&colorcolumn == "" ? "80" : "")<cr>

" Toggle cursor column
nmap <leader>cx :set cursorcolumn!<cr>

" Transliterate special characters to ascii
nmap <leader>ce :silent! %s/–/--/g<cr> \| :silent! %s/—/---/g<cr> \| my \| :%!iconv -f utf-8 -t ascii//translit<cr>'y

" Use typographic characters
nmap <leader>cl :call TypographyFormat()<cr>

" Toggle line numbers
nmap <leader>cn :set relativenumber!<cr>

" Justify columns
vnoremap <leader>ct !column -t -o' '<cr>

" Fold text
vnoremap <leader>cf <S-J><S-v> \| !fold -s -w<space>

" Go to scratchpad of specified filetype
noremap <leader>cs :w !cat > $HOME/.cache/vim-scratchpad<cr>:e +setf\ <space>$HOME/.cache/vim-scratchpad<C-left><left>

" File open mappings
let g:fzf_layout = { 'window': { 'xoffset': 0, 'yoffset': 1, 'width': 1, 'height': 0.5 } }
nmap <Tab> :Buffers<cr>
nmap <leader>ov :Lines<cr>
nmap <leader>ob :BLines<cr>
nmap <leader>op :History<cr>
nmap <leader>oc :History:<cr>
nmap <leader>ol :Locate<space>
nmap <leader>ot :exe '!$TERMINAL -cd ' . expand('%:p:h') . ' &'<cr><cr>
nmap <leader>of :call fzf#run({'options': [], 'source': "cat $FZF_FILE_MARKS", 'sink': 'e', 'window': { 'xoffset': 0, 'yoffset': 1, 'width': 1, 'height': 0.5 }})<cr><down>
nmap <leader>od :call fzf#run({'options': ['--preview', 'ls {}'], 'source': "cut -d' ' -f3 $FZF_DIRECTORY_MARKS", 'sink': 'cd', 'window': { 'xoffset': 0, 'yoffset': 1, 'width': 1, 'height': 0.5 }})<cr><down>
nmap <leader>oo :call fzf#run({'options': ['--preview', 'highlight -O ansi --force {}'], 'source': 'rg --files --hidden \|\| find . -type f -printf "%P\n"', 'sink': 'e', 'window': { 'xoffset': 0, 'yoffset': 1, 'width': 1, 'height': 0.5 }})<cr><down>

" Mappings for nnn
nmap <leader>nm :NnnPicker<cr>
nmap <leader>nn :NnnPicker '%:p:h'<cr>

" Exit incremental search
nmap <Esc><Esc> :nohl<cr>

" Disable Ex Mode
nnoremap Q <Nop>

" Clear notification popups
nnoremap j :call popup_clear()<cr><Down>
nnoremap k :call popup_clear()<cr><Up>

" Split window mappings
nmap <Bslash> :vsplit<cr>
nmap <C-Bslash> :split<cr>
nmap <C-j> :resize +5<cr>
nmap <C-k> :resize -5<cr>
nmap <C-h> :vertical resize +5<cr>
nmap <C-l> :vertical resize -5<cr>

" Inverse Tabs
inoremap <S-Tab> <C-d>

" Retain visual selection when tabbing
vnoremap < <gv
vnoremap > >gv

" Prevent cursor from jumping in visual select context https://ddrscott.github.io/blog/2016/yank-without-jank/
vnoremap <expr>y "my\"" . v:register . "y`y"


"------------------Snippets-------------------"

nnoremap ,html        :-1read $HOME/.vim/snippets/skeleton.html<cr>3jwf>a
nnoremap ,nix-module  :-1read $HOME/.vim/snippets/module.nix<cr>4jf"a
nnoremap ,nix-shell   :-1read $HOME/.vim/snippets/shell.nix<cr>2jf"a


"---------------Plugin Settings---------------"

let g:netrw_banner=0                    " Disable netrw banner.

let g:nnn#command = 'nnn -H'            " Override default command.
let g:nnn#set_default_mappings = 0      " Disable default mappings.
let g:nnn#layout = 'new'                " Opens the nnn window in a split.
let g:nnn#layout = { 'left': '~20%' }   " Left 20% of the window.


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

" Jump to line and column in the format 123:13
function s:cursor(selection)
  wincmd p
  let g:cursor_request = split(a:selection, ":")
  call cursor(g:cursor_request[0], g:cursor_request[1])
endfunction

" Notify
function s:notify(command)
  call popup_notification(systemlist(a:command), { 'pos': 'topright', 'col': 9999, 'time' : 600000, 'highlight': 'Normal' })
endfunction

command! -nargs=? -range Jump   call s:cursor(@*)
command! -nargs=? -range REPL   call s:repl(<line1>, <line2>, <f-args>)
command! -nargs=1 -range Notify call s:notify(<args>)


"----------------Autorun----------------"

augroup AutoCommands

  " Clear auto commands.
  autocmd!

  " Source reloads.
  autocmd BufWritePost .vimrc      source % | Notify('printf "Configuration sourced."')
  autocmd BufWritePost plugins.vim source % | Notify('printf "Plugins configuration sourced."')

  " Linting extension post write commands.
  autocmd BufWritePost *.txt,*.md :only | :term ++rows=10 vale %
  autocmd BufWritePost *.lit      exe 'Notify(''lit ' . expand('%') . ' 2>&1 && printf "Literate OK: ' . expand('%') . '"'')'

  " Linting file type post write commands.
  autocmd FileType php        autocmd! BufWritePost <buffer> exe 'Notify(''phpcbf ' . expand('%') . ' 2>&1'')' | :e
  autocmd FileType css        autocmd! BufWritePost <buffer> exe 'Notify(''prettier --write --parser css ' . expand('%') . ' 2>&1'')' | :e
  autocmd FileType html       autocmd! BufWritePost <buffer> exe 'Notify(''prettier --write --parser html ' . expand('%') . ' 2>&1'')' | :e
  autocmd FileType ruby       autocmd! BufWritePost <buffer> exe 'Notify(''rufo ' . expand('%') . ' 2>&1 && rubocop ' . expand('%') . ' 2>&1'')' | :e
  autocmd FileType rust       autocmd! BufWritePost <buffer> exe 'Notify(''rustfmt ' . expand('%') . ' 2>&1 && printf "rustfmt OK: ' . expand('%') . '"'')' | :e
  autocmd FileType json       autocmd! BufWritePost <buffer> exe 'Notify(''jsonlint -i ' . expand('%') . ' 2>&1 && printf "JSON OK: ' . expand('%') . '"'')' | :e
  autocmd FileType elixir     autocmd! BufWritePost <buffer> exe 'Notify(''mix format ' . expand('%') . ' 2>&1 && printf "Elixir Format OK: ' . expand('%') . '"'')' | :e
  autocmd FileType haskell    autocmd! BufWritePost <buffer> exe 'Notify(''hlint ' . expand('%') . ' 2>&1 && brittany --write-mode inplace ' . expand('%') . ' 2>&1'')' | :e
  autocmd FileType c          autocmd! BufWritePost <buffer> exe 'Notify(''clang-format -i ' . expand('%') . ' 2>&1 && printf "Clang Format OK: ' . expand('%') . '"'')' | :e
  autocmd FileType bash,sh    autocmd! BufWritePost <buffer> exe 'Notify(''shellcheck -x --exclude=SC1090,SC1091 ' . expand('%') . ' 2>&1 && printf "Shellcheck OK: ' . expand('%') . '"'')'
  autocmd FileType javascript autocmd! BufWritePost <buffer> exe 'Notify(''eslint -c $HOME/.config/eslintrc.yml --fix ' . expand('%') . ' 2>&1 && printf "JavaScript OK: '. expand('%') . '"'')' | :e
  autocmd FileType go         autocmd! BufWritePost <buffer> exe 'Notify(''gofmt -w -s -e ' . expand('%') . ' 2>&1 && go vet ' . expand('%') . ' 2>&1 && printf "Go Format OK: ' . expand('%') . '"'')' | :e
  autocmd FileType nix        autocmd! BufWritePost <buffer> exe 'Notify(''nix-linter ' . expand('%') . ' 2>&1 && printf "Nix Lint OK: ' . expand('%') . '"' . ' && nixfmt ' . expand('%') . ' 2>&1' . ''')' | :e
  autocmd FileType awk        autocmd! BufWritePost <buffer> exe 'Notify(''awk -g -f ' . expand('%') . ' 2>&1 && awk -o- -f ' . expand('%') . ' | sponge ' . expand('%') . ' && printf "AWK OK: ' . expand('%') . '"'')' | :e
  autocmd FileType yaml       autocmd! BufWritePost <buffer> exe 'Notify(''yaml round-trip --indent 2 --save ' . expand('%') . ' 2>&1 && yamllint -s ' . expand('%') . ' 2>&1 && printf "YAML OK: ' . expand('%') . '"'')' | :e
  autocmd FileType typescript autocmd! BufWritePost <buffer> exe 'Notify(''deno fmt ' . expand('%') . ' 2>&1 && NO_COLOR=true deno lint ' . expand('%') . ' 2>&1'')' | :e | :only | :term ++rows=10 deno run --config tsconfig.json --allow-all --location https://example.com/  %
  autocmd FileType sql        autocmd! BufWritePost <buffer> exe 'Notify(''sqlint ' . expand('%') . ' 2>&1 && pg_format -i ' . expand('%') . ' 2>&1 && sqlfluff lint --exclude-rules L003,L016 --dialect postgres ' . expand('%') . ' 2>&1 && printf "SQL OK: ' . expand('%') . '"'')' | :e

  " File type function under cursor lookups.
  autocmd FileType go     noremap <buffer> <leader>df :exe ':term ++rows=10 go doc ' . expand('<cexpr>')<cr>
  autocmd FileType nix    noremap <buffer> <leader>df :exe ':term ++rows=10 nixos-option ' . expand('<cexpr>')<cr>
  autocmd FileType elixir noremap <buffer> <leader>df :exe ':term ++rows=10 sh -c "echo ''h(' . expand('<cexpr>') . ')'' \| iex"'<cr>

  " REPL commands.
  autocmd FileType go         noremap <buffer> <leader>cc :REPL gore<cr>
  autocmd FileType lua        noremap <buffer> <leader>cc :REPL lua<cr>
  autocmd FileType php        noremap <buffer> <leader>cc :REPL psysh<cr>
  autocmd FileType elixir     noremap <buffer> <leader>cc :REPL iex<cr>
  autocmd FileType sh         noremap <buffer> <leader>cc :REPL dash -x<cr>
  autocmd FileType rust       noremap <buffer> <leader>cc :REPL evcxr<cr>
  autocmd FileType nix        noremap <buffer> <leader>cc :REPL nix repl<cr>
  autocmd FileType bash       noremap <buffer> <leader>cc :REPL bash -x<cr>
  autocmd FileType python     noremap <buffer> <leader>cc :REPL python<cr>
  autocmd FileType perl       noremap <buffer> <leader>cc :REPL perl -de0<cr>
  autocmd FileType javascript noremap <buffer> <leader>cc :REPL node<cr>
  autocmd FileType awk        noremap <buffer> <leader>cc :term ++rows=10 ++close awk -f %<cr>

  " Formatting programs.
  autocmd FileType nix set formatprg=nixfmt
  autocmd FileType sh  set formatprg=shfmt\ -

  " General auto commands.
  autocmd BufWritePost *.tex                              :term ++close ++rows=10 latex-compile %
  autocmd BufWritePost $HOME/.config/chromexup/config.ini exe 'Notify(''chromexup 2>&1'')'
  autocmd BufWritePost rc.lua                             exe 'Notify(''awesome -k 2>&1'')'
  autocmd BufWritePost quotes,*.fortune                   exe 'Notify(''strfile ' . expand('%') . ''')'
  autocmd BufWritePost *.desktop                          exe 'Notify(''desktop-file-validate ' . expand('%') . ' 2>&1 && printf "Deskop File OK: ' . expand('%') . '"'')'
  autocmd BufWritePost Xresources                         exe 'Notify(''xrdb ~/.config/X11/Xresources ' . '2>&1 && printf "Reloading Xresources: ' . expand('%') . '"'')'

  " Automatically remove trailing white space on save.
  autocmd InsertLeave,BufWritePre * %s/\s\+$//e

  " Automatically save file on insert and idle.
  autocmd InsertLeave,CursorHold * silent! write
    \| silent! exe "!~/.vim/hooks/post-save > /dev/null 2>&1 &"
    \| :echo expand('%:t') '[filetype=' . &filetype . ']'

augroup END
