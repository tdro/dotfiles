vim.g.mapleader = ' '               -- Set global leader key

vim.opt.ignorecase     = true       -- Ignore case on search
vim.opt.infercase      = true       -- Infer the case on completion
vim.opt.smartcase      = true       -- Search by case smartly
vim.opt.fileignorecase = true       -- Ignore case for file and directories
vim.opt.clipboard      = "unnamed"  -- Use clipboard as default register
vim.opt.laststatus     =  0         -- Disable status bar
vim.opt.foldcolumn     =  "2"       -- Set fold column width
vim.opt.showtabline    =  0         -- Disable top tab bar
vim.opt.undofile       =  true      -- Enable undo files

vim.opt.shortmess:append("I")       -- Disable startup message
vim.opt.fillchars:append("eob: ")   -- Disable end of buffer ~ character indicator

vim.opt.listchars = {               -- Set hidden character identifiers when `:set list`
  eol      = "¬", tab     = '>·',
  trail    = '~', extends = ">",
  precedes = "<", space   = '␣'
}

vim.keymap.set('n', '<leader>ev', ':tab drop ~/.config/nvim/init.lua<cr>') -- Edit configuration

vim.keymap.set('n', '<Esc>', ':nohl<cr>')     -- Exit incremental search

vim.keymap.set('v', '<C-j>', ":m'>+<cr>gv")   -- Move visual selection down
vim.keymap.set('v', '<C-k>', ":m -2<cr>gv")   -- Move visual selection up
vim.keymap.set('v', '//', "y/<C-R>*<cr>N")    -- Search visual selection
vim.keymap.set('v', '??', 'y/\\%V')           -- Search within last visual selection

autocommands = vim.api.nvim_create_augroup('default', { clear = true })

vim.api.nvim_create_autocmd({ "BufWritePost" }, { group = autocommands, pattern = { "init.lua" }, command = ":source %", })   -- Auto reload configuration
vim.api.nvim_create_autocmd({ "TextYankPost" }, { group = autocommands, callback = function() vim.highlight.on_yank() end, }) -- Highlight yanked text
