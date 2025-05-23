vim.cmd('mapclear')                 -- Clear all mappings
vim.cmd('colorscheme druid')        -- Set color scheme

vim.g.mapleader = ' '               -- Set global leader key
vim.g.netrw_banner = 0              -- Disable file manager top banner

vim.opt.ignorecase     = true       -- Ignore case on search
vim.opt.infercase      = true       -- Infer the case on completion
vim.opt.smartcase      = true       -- Search by case smartly
vim.opt.fileignorecase = true       -- Ignore case for file and directories
vim.opt.clipboard      = "unnamed"  -- Use clipboard as default register
vim.opt.laststatus     =  0         -- Disable status bar
vim.opt.foldcolumn     =  "2"       -- Set fold column width
vim.opt.showtabline    =  0         -- Disable top tab bar
vim.opt.undofile       =  true      -- Enable undo files
vim.opt.splitbelow     =  true      -- Open horizontal splits below
vim.opt.splitright     =  true      -- Open vertical splits to the right
vim.opt.path           = "**"       -- Search subfolders
vim.opt.wrap           = false      -- Disable line wrapping
vim.opt.tabstop        = 2          -- Number of spaces per tab
vim.opt.shiftwidth     = 2          -- Number of spaces per tab using shift
vim.opt.expandtab      = true       -- Set spaces over tabs
vim.opt.completeopt    = ""         -- Disable <C-p> completion popup
vim.opt.wildmenu       = false      -- Disable short command completion popup
vim.opt.scrolloff      = 5          -- Set vertical scroll headroom
vim.opt.sidescrolloff  = 10         -- Set horizontal scroll headroom

vim.opt.shortmess:append("I")       -- Disable startup message
vim.opt.fillchars:append("eob: ")   -- Disable end of buffer ~ character indicator

vim.opt.listchars = {               -- Set hidden character identifiers when `:set list`
  eol      = "¬", tab     = '>·',
  trail    = '~', extends = ">",
  precedes = "<", space   = '␣'
}

vim.keymap.set('n', '<leader>ev', ':tab drop ~/.config/nvim/init.lua<cr>')  -- Edit configuration
vim.keymap.set('n', '<leader>rs', ':%s/\\s\\+$')                            -- Remove trailing whitespace
vim.keymap.set('n', '<leader>grep', ':silent grep ')                        -- Run search functions
vim.keymap.set('n', '<Esc>', 'v<Esc>:nohl<cr>', { silent = true })          -- Exit incremental search

vim.keymap.set('n', '<Tab><Tab>', ':redir @a | silent ls   | redir END | 10split [buffers] | %d | set ft=vim | put a | setlocal readonly | call feedkeys("")<cr>')
vim.keymap.set('n', '<Tab>s',     ':redir @a | silent echo | redir END | 10split [scratch]      | set ft=vim | put a | setlocal readonly | call feedkeys("")<cr>')
vim.keymap.set('n', '<Tab>t',     ':redir @a | silent tabs | redir END | 10split [tabs]    | %d | set ft=vim | put a | setlocal readonly | call feedkeys("gg3dd")<cr>')
vim.keymap.set('n', '<Tab>m',     ':redir @a | silent map  | redir END | 10split [maps]    | %d | set ft=vim | put a | setlocal readonly | call feedkeys("gg3dd")<cr>')
vim.keymap.set('n', '<Tab>c',     ':redir @a | silent hi   | redir END | 10split [colors]  | %d | set ft=vim | put a | setlocal readonly | call feedkeys("gg2dd")<cr>')

vim.keymap.set('v', '<C-j>', ":m'>+<cr>gv", { silent = true })   -- Move visual selection down
vim.keymap.set('v', '<C-k>', ":m -2<cr>gv", { silent = true })   -- Move visual selection up
vim.keymap.set('v', '//', "y/<C-R>*<cr>N")                       -- Search visual selection
vim.keymap.set('v', '??', 'y/\\%V')                              -- Search within last visual selection

vim.keymap.set('n', '<C-L>', '<Cmd>nohlsearch|diffupdate|normal! <C-L><CR>')
vim.keymap.set('n', 'Y', 'y$', { desc = 'Mimics the behavior of D and C' })

vim.keymap.set('n', '<leader>qq', ':bd<cr>', { desc = 'Close buffer' })
vim.keymap.set('n', '<leader>qw', '<C-w>c',  { desc = 'Close window' })

vim.keymap.set({'v'}, 'gc', function() return require('vim._comment').operator() end,        { expr = true, desc = 'Toggle comment' })
vim.keymap.set({'n'}, 'gc', function() return require('vim._comment').operator() .. '_' end, { expr = true, desc = 'Toggle comment line' })

vim.keymap.set('v', 'y',  "ygv<Esc>",                           { silent = true, desc = "Prevent cursor from jumping in visual block yanking context" })
vim.keymap.set('n', 'yy', "yy:call setreg('c', col('.'))<cr>",  { silent = true, desc = "Prevent cursor from jumping in yanking context" })
vim.keymap.set('n', 'p',   "p:call cursor(0, getreg('c'))<cr>", { silent = true, desc = "Prevent cursor from jumping in pasting context" })

vim.keymap.set('n', 'h', "h:call setreg('c', col('.'))<cr>", { silent = true })  -- Persist cursor column
vim.keymap.set('n', 'j', "j:call setreg('c', col('.'))<cr>", { silent = true })  -- Persist cursor column
vim.keymap.set('n', 'k', "k:call setreg('c', col('.'))<cr>", { silent = true })  -- Persist cursor column
vim.keymap.set('n', 'l', "l:call setreg('c', col('.'))<cr>", { silent = true })  -- Persist cursor column

vim.keymap.set('v', '<leader>sn', "<Esc>:call setreg('c', col('.'))<cr>:call setreg('l', line('.'))<cr>gv!perl -e 'print sort { length($a) <=> length($b) } <>'<cr>:call cursor(getreg('l'), getreg('c'))<cr>", { silent = true, desc = 'Sort lines by length' })

-- Auto commands
autocommands = vim.api.nvim_create_augroup('', { clear = true })

-- Source reloads
vim.api.nvim_create_autocmd({"BufWritePost"}, { group = autocommands, pattern = {"init.lua"}, callback = function()
  vim.cmd(':source %')                -- Auto reload configuration
  vim.bo.filetype = vim.bo.filetype   -- Retrigger FileType events
end, })

--  Format using visual select + gq
vim.api.nvim_create_autocmd({"FileType"}, { group = autocommands, pattern = "lua", callback = function() vim.opt_local.formatprg = "lua-format" end, })

-- Keyword documentation lookups
vim.api.nvim_create_autocmd({"FileType"}, { group = autocommands, pattern = {"lua"}, callback = function() vim.keymap.set('n', 'K', 'viwy/<C-R>*<cr>N:h <C-R>*<cr><C-w>w') end })
vim.api.nvim_create_autocmd({"FileType"}, { group = autocommands, pattern = {"lua"}, callback = function() vim.keymap.set('v', 'K',    'y/<C-R>*<cr>N:h <C-R>*<cr><C-w>w') end })

-- REPL Commands
vim.api.nvim_create_autocmd({"FileType"}, { group = autocommands, pattern = {"lua"},
callback = function()
  vim.keymap.set('n', '<leader>cc', 'Vy:lua <C-R>*<cr>', { buffer = true })
  vim.keymap.set('v', '<leader>cc',  'y:lua <C-R>*<cr>', { buffer = true })
  vim.keymap.set('n', '<leader>co', "Vy:redir @a      | silent! exe 'lua' '<C-R>*' | redir END | call feedkeys('gvy$\"ap')<cr>", { buffer = true, silent = true })
  vim.keymap.set('v', '<leader>co',  "y:<C-w>redir @a | silent! exe 'lua' '<C-R>*' | redir END | call feedkeys('gvy$\"ap')<cr>", { buffer = true, silent = true })
end
})

-- Quick fix commands
vim.api.nvim_create_autocmd({"FileType"}, {
    group = autocommands,
    pattern = {"qf"},
    callback = function()
      vim.keymap.set('n', '<cr>', "<cr><C-w>w", { silent = true, buffer = true })
      vim.keymap.set('n', 'j',    "j:cnext<cr><C-w>w:call cursor(0, getreg('c'))<cr>", { silent = true, buffer = true })
      vim.keymap.set('n', 'k',    "k:cprev<cr><C-w>w:call cursor(0, getreg('c'))<cr>", { silent = true, buffer = true })
      switch = vim.api.nvim_create_augroup('', { clear = true })
      vim.api.nvim_create_autocmd({"BufRead"}, { group = switch, pattern = {"*"},
      callback = function()
        vim.cmd('wincmd p | call feedkeys("gg")')
        vim.api.nvim_clear_autocmds({ group = switch })
      end
      })
    end
})

vim.api.nvim_create_autocmd({"QuickFixCmdPost"}, { group = autocommands, pattern = {"*"}, command = ":copen" })

-- Auto save
vim.api.nvim_create_autocmd({"InsertLeave", "CursorHold"}, { group = autocommands, pattern = {"*"}, command = ":silent! write | echo '[filetype=' . &filetype . ']'" })
