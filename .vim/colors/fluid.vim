nohl
hi clear
syntax reset
set t_Co=256
set background=dark
let g:syntax_cmd = "skip"

let s:none='NONE'
let s:bold='bold'
let s:t_clear=0

let s:t_background = s:none | let s:g_background = '#2c303c'
let s:t_white      = '255'  | let s:g_white      = '#cdd3de'
let s:t_black      = '232'  | let s:g_black      = '#000000'
let s:t_yellow     = '186'  | let s:g_yellow     = '#ffdf23'
let s:t_red        = '197'  | let s:g_red        = '#ff005f'
let s:t_pink       = '203'  | let s:g_pink       = '#fc3488'
let s:t_blue       = '81'   | let s:g_blue       = '#82b1ff'
let s:t_darkblue   = '25'   | let s:g_darkblue   = '#005faf'
let s:t_orange     = '208'  | let s:g_orange     = '#e84f4f'
let s:t_green      = '148'  | let s:g_green      = '#a6e22e'
let s:t_darkgreen  = '22'   | let s:g_darkgreen  = '#00af01'
let s:t_purple     = '141'  | let s:g_purple     = '#ae81ff'
let s:t_darkpurple = '99'   | let s:g_darkpurple = '#67209b'
let s:t_grey       = '237'  | let s:g_grey       = '#333333'
let s:t_grey1      = '238'  | let s:g_grey1      = '#444444'
let s:t_grey2      = '239'  | let s:g_grey2      = '#555555'
let s:t_grey3      = '236'  | let s:g_grey3      = '#303030'
let s:t_silver     = '250'  | let s:g_silver     = '#c0c0c0'

exe 'hi Boolean        guifg='.s:g_purple     . ' guibg='.s:none         . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_purple . ' ctermbg='.s:none        . ' cterm='.s:none
exe 'hi Character      guifg='.s:g_yellow     . ' guibg='.s:none         . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_yellow . ' ctermbg='.s:none        . ' cterm='.s:none
exe 'hi ColorColumn    guifg='.s:none         . ' guibg='.s:g_grey       . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:none     . ' ctermbg='.s:t_grey      . ' cterm='.s:none
exe 'hi Comment        guifg='.s:g_silver     . ' guibg='.s:none         . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_silver . ' ctermbg='.s:none        . ' cterm='.s:none
exe 'hi Conditional    guifg='.s:g_blue       . ' guibg='.s:none         . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_blue   . ' ctermbg='.s:none        . ' cterm='.s:none
exe 'hi Constant       guifg='.s:g_purple     . ' guibg='.s:none         . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_purple . ' ctermbg='.s:none        . ' cterm='.s:none
exe 'hi CursorColumn   guifg='.s:none         . ' guibg='.s:g_grey       . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:none     . ' ctermbg='.s:t_grey      . ' cterm='.s:none
exe 'hi CursorLine     guifg='.s:none         . ' guibg='.s:g_grey       . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:none     . ' ctermbg='.s:t_grey      . ' cterm='.s:none
exe 'hi Debug          guifg='.s:g_pink       . ' guibg='.s:none         . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_pink   . ' ctermbg='.s:none        . ' cterm='.s:none
exe 'hi Define         guifg='.s:g_pink       . ' guibg='.s:none         . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_pink   . ' ctermbg='.s:none        . ' cterm='.s:none
exe 'hi Delimiter      guifg='.s:g_pink       . ' guibg='.s:none         . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_pink   . ' ctermbg='.s:none        . ' cterm='.s:none
exe 'hi DiffAdd        guifg='.s:none         . ' guibg='.s:g_darkgreen  . ' guisp='.s:none . ' gui='.s:bold . ' ctermfg='.s:none     . ' ctermbg='.s:t_darkgreen . ' cterm='.s:none
exe 'hi DiffChange     guifg='.s:none         . ' guibg='.s:g_darkblue   . ' guisp='.s:none . ' gui='.s:bold . ' ctermfg='.s:none     . ' ctermbg='.s:t_darkblue  . ' cterm='.s:none
exe 'hi DiffDelete     guifg='.s:g_black      . ' guibg='.s:g_pink       . ' guisp='.s:none . ' gui='.s:bold . ' ctermfg='.s:t_black  . ' ctermbg='.s:t_pink      . ' cterm='.s:none
exe 'hi DiffText       guifg='.s:g_red        . ' guibg='.s:g_grey2      . ' guisp='.s:none . ' gui='.s:bold . ' ctermfg='.s:t_red    . ' ctermbg='.s:t_grey2     . ' cterm='.s:none
exe 'hi EndOfBuffer    guifg='.s:g_background . ' guibg='.s:none         . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_clear  . ' ctermbg='.s:none        . ' cterm='.s:none
exe 'hi Error          guifg='.s:g_red        . ' guibg='.s:g_grey3      . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_red    . ' ctermbg='.s:t_grey3     . ' cterm='.s:none
exe 'hi ErrorMsg       guifg='.s:g_black      . ' guibg='.s:g_red        . ' guisp='.s:none . ' gui='.s:bold . ' ctermfg='.s:t_black  . ' ctermbg='.s:t_red       . ' cterm='.s:bold
exe 'hi Exception      guifg='.s:g_blue       . ' guibg='.s:none         . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_blue   . ' ctermbg='.s:none        . ' cterm='.s:none
exe 'hi Float          guifg='.s:g_purple     . ' guibg='.s:none         . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_purple . ' ctermbg='.s:none        . ' cterm='.s:none
exe 'hi FoldColumn     guifg='.s:none         . ' guibg='.s:none         . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:none     . ' ctermbg='.s:none        . ' cterm='.s:none
exe 'hi Folded         guifg='.s:g_white      . ' guibg='.s:g_grey       . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_white  . ' ctermbg='.s:t_grey      . ' cterm='.s:none
exe 'hi Function       guifg='.s:g_green      . ' guibg='.s:none         . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_green  . ' ctermbg='.s:none        . ' cterm='.s:none
exe 'hi Identifier     guifg='.s:g_green      . ' guibg='.s:none         . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_green  . ' ctermbg='.s:none        . ' cterm='.s:none
exe 'hi Ignore         guifg='.s:g_silver     . ' guibg='.s:none         . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_silver . ' ctermbg='.s:none        . ' cterm='.s:none
exe 'hi IncSearch      guifg='.s:g_black      . ' guibg='.s:g_yellow     . ' guisp='.s:none . ' gui='.s:bold . ' ctermfg='.s:t_black  . ' ctermbg='.s:t_yellow    . ' cterm='.s:bold
exe 'hi Include        guifg='.s:g_pink       . ' guibg='.s:none         . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_pink   . ' ctermbg='.s:none        . ' cterm='.s:none
exe 'hi Keyword        guifg='.s:g_blue       . ' guibg='.s:none         . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_blue   . ' ctermbg='.s:none        . ' cterm='.s:none
exe 'hi Label          guifg='.s:g_pink       . ' guibg='.s:none         . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_pink   . ' ctermbg='.s:none        . ' cterm='.s:none
exe 'hi Macro          guifg='.s:g_green      . ' guibg='.s:none         . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_green  . ' ctermbg='.s:none        . ' cterm='.s:none
exe 'hi MatchParen     guifg='.s:g_black      . ' guibg='.s:g_purple     . ' guisp='.s:none . ' gui='.s:bold . ' ctermfg='.s:t_black  . ' ctermbg='.s:t_purple    . ' cterm='.s:bold
exe 'hi ModeMsg        guifg='.s:g_yellow     . ' guibg='.s:none         . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_yellow . ' ctermbg='.s:none        . ' cterm='.s:none
exe 'hi MoreMsg        guifg='.s:g_yellow     . ' guibg='.s:none         . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_yellow . ' ctermbg='.s:none        . ' cterm='.s:none
exe 'hi Normal         guifg='.s:g_white      . ' guibg='.s:g_background . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_white  . ' ctermbg='.s:none        . ' cterm='.s:none
exe 'hi Number         guifg='.s:g_purple     . ' guibg='.s:none         . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_purple . ' ctermbg='.s:none        . ' cterm='.s:none
exe 'hi Operator       guifg='.s:g_pink       . ' guibg='.s:none         . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_pink   . ' ctermbg='.s:none        . ' cterm='.s:none
exe 'hi PreCondit      guifg='.s:g_green      . ' guibg='.s:none         . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_green  . ' ctermbg='.s:none        . ' cterm='.s:none
exe 'hi PreProc        guifg='.s:g_green      . ' guibg='.s:none         . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_green  . ' ctermbg='.s:none        . ' cterm='.s:none
exe 'hi Question       guifg='.s:g_yellow     . ' guibg='.s:none         . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_yellow . ' ctermbg='.s:none        . ' cterm='.s:none
exe 'hi Repeat         guifg='.s:g_blue       . ' guibg='.s:none         . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_blue   . ' ctermbg='.s:none        . ' cterm='.s:none
exe 'hi Search         guifg='.s:g_black      . ' guibg='.s:g_yellow     . ' guisp='.s:none . ' gui='.s:bold . ' ctermfg='.s:t_black  . ' ctermbg='.s:t_yellow    . ' cterm='.s:bold
exe 'hi Special        guifg='.s:g_blue       . ' guibg='.s:none         . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_blue   . ' ctermbg='.s:none        . ' cterm='.s:none
exe 'hi SpecialChar    guifg='.s:g_pink       . ' guibg='.s:none         . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_pink   . ' ctermbg='.s:none        . ' cterm='.s:none
exe 'hi SpecialComment guifg='.s:g_blue       . ' guibg='.s:none         . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_blue   . ' ctermbg='.s:none        . ' cterm='.s:none
exe 'hi SpellBad       guifg='.s:g_black      . ' guibg='.s:g_red        . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_black  . ' ctermbg='.s:t_red       . ' cterm='.s:none
exe 'hi SpellCap       guifg='.s:none         . ' guibg='.s:none         . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:none     . ' ctermbg='.s:none        . ' cterm='.s:none
exe 'hi SpellLocal     guifg='.s:g_black      . ' guibg='.s:g_red        . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_black  . ' ctermbg='.s:t_red       . ' cterm='.s:none
exe 'hi SpellRare      guifg='.s:g_black      . ' guibg='.s:g_red        . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_black  . ' ctermbg='.s:t_red       . ' cterm='.s:none
exe 'hi Statement      guifg='.s:g_pink       . ' guibg='.s:none         . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_pink   . ' ctermbg='.s:none        . ' cterm='.s:none
exe 'hi StatusLine     guifg='.s:none         . ' guibg='.s:g_grey2      . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:none     . ' ctermbg='.s:t_grey2     . ' cterm='.s:none
exe 'hi StatusLineNC   guifg='.s:g_background . ' guibg='.s:g_silver     . ' guisp='.s:none . ' gui='.s:bold . ' ctermfg='.s:t_black  . ' ctermbg='.s:t_silver    . ' cterm='.s:bold
exe 'hi StorageClass   guifg='.s:g_blue       . ' guibg='.s:none         . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_blue   . ' ctermbg='.s:none        . ' cterm='.s:none
exe 'hi String         guifg='.s:g_yellow     . ' guibg='.s:none         . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_yellow . ' ctermbg='.s:none        . ' cterm='.s:none
exe 'hi Structure      guifg='.s:g_blue       . ' guibg='.s:none         . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_blue   . ' ctermbg='.s:none        . ' cterm='.s:none
exe 'hi Tag            guifg='.s:g_pink       . ' guibg='.s:none         . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_pink   . ' ctermbg='.s:none        . ' cterm='.s:none
exe 'hi Todo           guifg='.s:g_blue       . ' guibg='.s:none         . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_blue   . ' ctermbg='.s:none        . ' cterm='.s:none
exe 'hi Type           guifg='.s:g_blue       . ' guibg='.s:none         . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_blue   . ' ctermbg='.s:none        . ' cterm='.s:none
exe 'hi Typedef        guifg='.s:g_blue       . ' guibg='.s:none         . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_blue   . ' ctermbg='.s:none        . ' cterm='.s:none
exe 'hi Underlined     guifg='.s:g_green      . ' guibg='.s:none         . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:t_green  . ' ctermbg='.s:none        . ' cterm='.s:none
exe 'hi VertSplit      guifg='.s:none         . ' guibg='.s:g_grey2      . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:none     . ' ctermbg='.s:t_grey2     . ' cterm='.s:none
exe 'hi Visual         guifg='.s:none         . ' guibg='.s:g_grey1      . ' guisp='.s:none . ' gui='.s:none . ' ctermfg='.s:none     . ' ctermbg='.s:t_grey1     . ' cterm='.s:none
exe 'hi WarningMsg     guifg='.s:g_black      . ' guibg='.s:g_yellow     . ' guisp='.s:none . ' gui='.s:bold . ' ctermfg='.s:t_black  . ' ctermbg='.s:t_yellow    . ' cterm='.s:bold
