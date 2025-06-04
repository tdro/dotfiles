vim.cmd('mapclear')                 -- Clear all mappings
vim.cmd('colorscheme druid')        -- Set color scheme

vim.g.mapleader     = ' '           -- Set global leader key
vim.g.netrw_banner  = 0             -- Disable file manager top banner
vim.g.netrw_winsize = 15            -- Set file manager default window size

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
vim.opt.signcolumn     = "no"       -- Disable diagnostics column left

vim.opt.grepprg = "rg --no-heading --line-number --column --smart-case --multiline --regexp" -- Set search program
vim.opt.grepformat = "%f:%l:%m,%f:%l%m,%f  %l%m" -- Set string format

vim.opt.shortmess:append("I")       -- Disable startup message
vim.opt.fillchars:append("eob: ")   -- Disable end of buffer ~ character indicator

vim.opt.listchars = {               -- Set hidden character identifiers when `:set list`
  eol      = "¬", tab     = '>·',
  trail    = '~', extends = ">",
  precedes = "<", space   = '␣'
}

-- Functions
local function grep(pattern)
  vim.cmd(string.format("silent grep '%s'", string.gsub (pattern, "[#|(){}+%[%]]", "\\%1"))) -- Choose magic characters
  vim.cmd(string.format("silent! /%s",      string.gsub (pattern, "[/|]",          "\\%1")))
end

vim.api.nvim_create_user_command('Find', function(opts) grep(opts.args) end, { nargs = 1 })

vim.keymap.set('n', '<leader>ev',   ':tab drop ~/.config/nvim/init.lua<cr>')  -- Edit configuration
vim.keymap.set('n', '<leader>rs',   ':%s/\\s\\+$')                            -- Remove trailing whitespace
vim.keymap.set('n', '<leader>grep', ':Find ')                                 -- Run search functions
vim.keymap.set('v', '<leader>grep', 'y/<C-R>*<cr>:silent grep <C-R>*<cr>')    -- Run search functions for symbol under cursor
vim.keymap.set('n', '<leader>vrep', ':vimgrep //g *<left><left><left><left>') -- Run internal search functions
vim.keymap.set('n', '<leader>nn',   ":exe 'Lexplore' expand('%:p:h')<cr>")    -- Open file manager at current file path

vim.keymap.set('n', '<Esc>', 'v<Esc>:nohl<cr>', { silent = true })          -- Exit incremental search

vim.keymap.set('n', '<Tab><Tab>', ':redir @a | silent ls   | redir END | 10split [buffers] | %d | set ft=vim | put a | setlocal buftype=nofile | call feedkeys("")<cr>')
vim.keymap.set('n', '<Tab>s',     ':redir @a | silent echo | redir END | 10split [scratch]      | set ft=vim | put a | setlocal buftype=nofile | call feedkeys("")<cr>')
vim.keymap.set('n', '<Tab>t',     ':redir @a | silent tabs | redir END | 10split [tabs]    | %d | set ft=vim | put a | setlocal buftype=nofile | call feedkeys("gg3dd")<cr>')
vim.keymap.set('n', '<Tab>m',     ':redir @a | silent map  | redir END | 10split [maps]    | %d | set ft=vim | put a | setlocal buftype=nofile | call feedkeys("gg3dd")<cr>')
vim.keymap.set('n', '<Tab>c',     ':redir @a | silent hi   | redir END | 10split [colors]  | %d | set ft=vim | put a | setlocal buftype=nofile | call feedkeys("gg2dd")<cr>')
vim.keymap.set('n', '<Tab>r',     ':redir @a | silent reg  | redir END | 10split [reg]     | %d | set ft=vim | put a | setlocal buftype=nofile | call feedkeys("gg2dd")<cr>')

vim.keymap.set('v', '<C-j>', ":m'>+<cr>gv",         { silent = true })  -- Move visual selection down
vim.keymap.set('v', '<C-k>', ":m -2<cr>gv",         { silent = true })  -- Move visual selection up
vim.keymap.set('i', '<C-j>', "<Esc>:m .+1<CR>==gi", { silent = true })  -- Move insert line down
vim.keymap.set('i', '<C-k>', "<Esc>:m .-2<CR>==gi", { silent = true })  -- Move insert line up
vim.keymap.set('v', '//', "y/<C-R>*<cr>N")                              -- Search visual selection
vim.keymap.set('v', '??', 'y/\\%V')                                     -- Search within last visual selection

vim.keymap.set('n', 'Y', 'y$',  { desc = 'Mimics the behavior of D and C'             })
vim.keymap.set('v', '<', "<gv", { desc = 'Retain visual selection when tabbing left'  })
vim.keymap.set('v', '>', ">gv", { desc = 'Retain visual selection when tabbing right' })

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

vim.keymap.set('i', '<C-o>', "<C-x><C-n>", { desc = "Keyword local completion" })
vim.keymap.set('i', '<C-s>', "<C-x><C-f>", { desc = "File name completion"     })
vim.keymap.set('i', '<C-y>', "<C-x><C-l>", { desc = "Whole line completion"    })

vim.keymap.set('n', '<Bslash>',   ":vsplit<cr>",             { desc = "Vertical split"               })
vim.keymap.set('n', '<C-Bslash>', ":split<cr>",              { desc = "Horizontal split"             })
vim.keymap.set('n', '<C-h>',      ":vertical resize +5<cr>", { desc = "Vertical split resize left"   })
vim.keymap.set('n', '<C-j>',      ":if winnr('$') > 1 | resize +5 | else | :m.+1 | end<cr>",                                              { silent = true, desc = "Horizontal split resize or move line down"     })
vim.keymap.set('n', '<C-k>',      ":if winnr('$') > 1 | resize -5 | else | :m.-2 | end<cr>",                                              { silent = true, desc = "Horizontal split resize or move line up"       })
vim.keymap.set('n', '<C-l>',      ":if winnr('$') > 1 | vertical resize -5 | else | exe 'nohlsearch|diffupdate|normal! <C-l>' | end<cr>", { silent = true, desc = "Vertical split resize right or clear terminal" })

vim.keymap.set('n',       'grn', 'viwy:cclose|lclose<cr>/<C-R>*<cr>N:lua vim.lsp.buf.rename()<cr>',          { desc = 'Renames symbol under cursor'             })
vim.keymap.set('n',       'gdd', 'viwy:cclose|lclose<cr>/<C-R>*<cr>N:lua vim.lsp.buf.definition()<cr>',      { desc = 'Jumps to definition under cursor'        })
vim.keymap.set('n',       'gtt', 'viwy:cclose|lclose<cr>/<C-R>*<cr>N:lua vim.lsp.buf.type_definition()<cr>', { desc = 'Jumps to type definition under cursor'   })
vim.keymap.set('n',       'grr', 'viwy:cclose|lclose<cr>/<C-R>*<cr>N:lua vim.lsp.buf.references()<cr>',      { desc = 'References to symbol under cursor'       })
vim.keymap.set('n',       'gro', 'viwy:cclose|lclose<cr>/<C-R>*<cr>N:lua vim.lsp.buf.document_symbol()<cr>', { desc = 'Symbols in current buffer'               })
vim.keymap.set('n',       'gri', 'viwy:cclose|lclose<cr>/<C-R>*<cr>N:lua vim.lsp.buf.implementation()<cr>',  { desc = 'Implementations for symbol under cursor' })
vim.keymap.set('n',       'gee', ':cclose|lclose<cr>:lua vim.diagnostic.setloclist()<cr>:lopen<cr>',         { desc = 'Open diagnostics in a location list'     })
vim.keymap.set({'n','x'}, 'gra', function() vim.lsp.buf.code_action() end,                                   { desc = 'Run code actions'                        })

vim.keymap.set('v', '<leader>sn', "<Esc>:call setreg('c', col('.'))<cr>:call setreg('l', line('.'))<cr>gv!perl -e 'print sort { length($a) <=> length($b) } <>'<cr>:call cursor(getreg('l'), getreg('c'))<cr>", { silent = true, desc = 'Sort lines by length' })

-- Auto commands
vim.api.nvim_create_augroup('autocommands', { clear = true })

-- Source reloads
vim.api.nvim_create_autocmd({"BufWritePost"}, { group = 'autocommands', pattern = {"init.lua"}, callback = function()
  vim.cmd(':source %')                -- Auto reload configuration
  vim.bo.filetype = vim.bo.filetype   -- Retrigger FileType events
end, })

--  Format using visual select + gq
vim.api.nvim_create_autocmd({"FileType"}, { group = 'autocommands', pattern = "lua", callback = function() vim.opt_local.formatprg = "lua-format" end, })

-- Keyword documentation lookups
vim.api.nvim_create_autocmd({"FileType"}, { group = 'autocommands', pattern = {"lua"},  callback = function() vim.keymap.set('n', 'K', 'viwy/<C-R>*<cr>N:h <C-R>*<cr><C-w>w', { buffer = true }) end })
vim.api.nvim_create_autocmd({"FileType"}, { group = 'autocommands', pattern = {"lua"},  callback = function() vim.keymap.set('v', 'K',    'y/<C-R>*<cr>N:h <C-R>*<cr><C-w>w', { buffer = true }) end })
vim.api.nvim_create_autocmd({"FileType"}, { group = 'autocommands', pattern = {"help"}, callback = function() vim.keymap.set('n', 'K', 'viwy/<C-R>*<cr>N:h <C-R>*<cr>',       { buffer = true }) end })
vim.api.nvim_create_autocmd({"FileType"}, { group = 'autocommands', pattern = {"help"}, callback = function() vim.keymap.set('v', 'K',    'y/<C-R>*<cr>N:h <C-R>*<cr>',       { buffer = true }) end })

-- REPL Commands
vim.api.nvim_create_autocmd({"FileType"}, { group = 'autocommands', pattern = {"lua"},
  callback = function()
    vim.keymap.set('n', '<leader>cc', 'Vy:lua <C-R>*<cr>', { buffer = true })
    vim.keymap.set('v', '<leader>cc',  'y:lua <C-R>*<cr>', { buffer = true })
    vim.keymap.set('n', '<leader>co', "Vy:redir @a      | silent! exe 'lua' '<C-R>*' | redir END | call feedkeys('gvy$\"ap')<cr>", { buffer = true, silent = true })
    vim.keymap.set('v', '<leader>co',  "y:<C-w>redir @a | silent! exe 'lua' '<C-R>*' | redir END | call feedkeys('gvy$\"ap')<cr>", { buffer = true, silent = true })
  end
})

vim.api.nvim_create_autocmd({"FileType"}, { group = 'autocommands', pattern = {"vim"},
  callback = function()
    vim.keymap.set('n', '<leader>cc', 'yVy:<C-R>*<cr>',   { buffer = true })
    vim.keymap.set('n', '<leader>co',  "Vy:<C-w>redir @a | silent! exe substitute('<C-R>*', '\\r', '', 'g') | redir END | call feedkeys('gvy$\"ap')<cr>", { buffer = true })
    vim.keymap.set('v', '<leader>co',   "y:<C-w>redir @a | silent! exe substitute('<C-R>*', '\\r', '', 'g') | redir END | call feedkeys('gvy$\"ap')<cr>", { buffer = true })
  end
})

-- File manager bindings
vim.api.nvim_create_autocmd({"FileType"}, { group = 'autocommands', pattern = {"netrw"},
  callback = function()
    vim.keymap.set('n', 'l',    '<cr>cd',                      { remap = true, buffer = true, desc = "Browse directory under cursor" })
    vim.keymap.set('n', 'h',    '-cd',                         { remap = true, buffer = true, desc = "Browse up a directory"         })
    vim.keymap.set('n', 'i',    'mfR',                         { remap = true, buffer = true, desc = "Rename file under cursor"      })
    vim.keymap.set('n', 'p',    'mtmc',                        { remap = true, buffer = true, desc = "Paste marked files here"       })
    vim.keymap.set('n', 'v',    'mfj',                         { remap = true, buffer = true, desc = "Mark files incrementally"      })
    vim.keymap.set('n', 'u',    'mF',                          { remap = true, buffer = true, desc = "Unmark marked files"           })
    vim.keymap.set('n', 'a',    'd',                           { remap = true, buffer = true, desc = "Add new directory"             })
    vim.keymap.set('n', 'dd',   'vD',                          { remap = true, buffer = true, desc = "Delete file under cursor"      })
    vim.keymap.set('n', '<cr>', '<Plug>NetrwLocalBrowseCheck', { remap = true, buffer = true, desc = "Select file"                   })
  end
})

-- Quick fix commands
vim.api.nvim_create_autocmd({"FileType"}, { group = 'autocommands', pattern = {"qf"},
  callback = function()
    vim.keymap.set('n', '<cr>', "<cr><C-w>w",                            { remap = false, silent = true, buffer = true })
    vim.keymap.set('n', 'j',    "j<cr>:call cursor(0, getreg('c'))<cr>", { remap = true,  silent = true, buffer = true })
    vim.keymap.set('n', 'k',    "k<cr>:call cursor(0, getreg('c'))<cr>", { remap = true,  silent = true, buffer = true })
    vim.api.nvim_create_augroup('switch', { clear = true })
    vim.api.nvim_create_autocmd({"BufRead"}, { group = 'switch', pattern = {"*"},
      callback = function()
        vim.cmd(':silent! wincmd p | call feedkeys("ggjk")')
        vim.api.nvim_clear_autocmds({ group = 'switch' })
      end
    })
  end
})

vim.api.nvim_create_autocmd({"QuickFixCmdPost"}, { group = 'autocommands', pattern = {"*"}, command = "silent! bufdo bd! | :cclose | :only | :copen" })

-- Auto save
vim.api.nvim_create_autocmd({"InsertLeave", "CursorHold"}, { group = 'autocommands', pattern = {"*"}, command = ":silent! write | echo '[filetype=' . &filetype . ']'" })

-- Language server protocol (LSP) configuration
vim.lsp.config['clangd'] = { cmd = {'clangd'}, filetypes = {"c", "cpp", "objc", "objcpp", "cuda", "proto"} }

-- Language server protocol (LSP) enable
vim.lsp.enable({'clangd'})
