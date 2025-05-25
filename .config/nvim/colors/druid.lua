local colors = {

  black       = {fg = "#080808", bg = "#c0c0c0", ctermfg = 232, ctermbg = 7},
  yellow      = {fg = "",        bg = "#ffd700", ctermfg = 0,   ctermbg = 220},
  lightyellow = {fg = "",        bg = "#ffdf23", ctermfg = 0,   ctermbg = 186},
  grey        = {fg = "#e4e4e4", bg = "#080808", ctermfg = 254, ctermbg = 232},
  white       = {fg = "#ffffff", bg = "#080808", ctermfg = 231, ctermbg = 232},
  red         = {fg = "#080808", bg = "#ff005f", ctermfg = 232, ctermbg = 197},
  teal        = {fg = "#00ffff", bg = "",        ctermfg = 14,  ctermbg = 0},
  lightred    = {fg = "#080808", bg = "#ff8787", ctermfg = 0,   ctermbg = 210},

}

local theme = {

  CurSearch = {fg = colors.black.fg, bg = colors.yellow.bg,      ctermfg = colors.black.ctermfg, ctermbg = colors.yellow.ctermbg,      cterm = { bold = true }},
  IncSearch = {fg = colors.black.fg, bg = colors.lightyellow.bg, ctermfg = colors.black.ctermfg, ctermbg = colors.lightyellow.ctermbg, cterm = { bold = true }},
  Search    = {fg = colors.black.fg, bg = colors.lightyellow.bg, ctermfg = colors.black.ctermfg, ctermbg = colors.lightyellow.ctermbg, cterm = { bold = true }},

  StatusLine   = {fg = colors.black.fg,    bg = colors.black.bg,    ctermfg = colors.black.ctermfg,    ctermbg = colors.black.ctermbg,    cterm = { bold = false }},
  StatusLineNC = {fg = colors.black.fg,    bg = colors.black.bg,    ctermfg = colors.black.ctermfg,    ctermbg = colors.black.ctermbg,    cterm = { bold = true  }},
  ErrorMsg     = {fg = colors.red.fg,      bg = colors.red.bg,      ctermfg = colors.red.ctermfg,      ctermbg = colors.red.ctermbg,      cterm = { bold = true  }},
  Visual       = {fg = colors.black.fg,    bg = colors.black.bg,    ctermfg = colors.black.ctermfg,    ctermbg = colors.black.ctermbg,    cterm = { bold = true  }},
  qfError      = {fg = colors.lightred.bg, bg = colors.lightred.fg, ctermfg = colors.lightred.ctermbg, ctermbg = colors.lightred.ctermfg, cterm = { bold = true  }},

  String     = {fg = colors.grey.fg,  bg = "", ctermfg = colors.grey.ctermfg,  ctermbg = ""},
  Comment    = {fg = colors.black.bg, bg = "", ctermfg = colors.black.ctermbg, ctermbg = ""},
  Identifier = {fg = colors.white.fg, bg = "", ctermfg = colors.white.ctermfg, ctermbg = ""},
  Statement  = {fg = colors.white.fg, bg = "", ctermfg = colors.white.ctermfg, ctermbg = ""},
  Function   = {fg = colors.teal.fg,  bg = "", ctermfg = colors.teal.ctermfg,  ctermbg = ""},

  PreProc           = { link = "Function"},
  Type              = { link = "Function"},
  Special           = { link = "Function"},
  NvimInternalError = { link = "ErrorMsg"},
  WarningMsg        = { link = "Search"},

  DiagnosticUnderlineError = {fg = colors.lightred.bg,    bg = "", ctermfg = colors.lightred.ctermbg,    ctermbg = "", cterm = { bold = true, underline = false }},
  DiagnosticUnderlineWarn  = {fg = colors.lightyellow.bg, bg = "", ctermfg = colors.lightyellow.ctermbg, ctermbg = "", cterm = { bold = true, underline = false }},

}

for group, value in pairs(theme) do vim.api.nvim_set_hl(0, group, value) end
