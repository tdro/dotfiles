vim.cmd('nohls | highlight clear | syntax reset')  -- Clear highlights and reset syntax

local colors = {

  black       = { fg = "#c0c0c0", bg = "#080808", ctermfg = 7,   ctermbg = 232 },
  yellow      = { fg = "",        bg = "#ffd700", ctermfg = 0,   ctermbg = 220 },
  lightyellow = { fg = "",        bg = "#ffdf23", ctermfg = 0,   ctermbg = 186 },
  grey        = { fg = "#080808", bg = "#e4e4e4", ctermfg = 232, ctermbg = 254 },
  white       = { fg = "#080808", bg = "#ffffff", ctermfg = 232, ctermbg = 231 },
  red         = { fg = "#080808", bg = "#ff005f", ctermfg = 232, ctermbg = 197 },
  teal        = { fg = "#080808", bg = "#00ffff", ctermfg = 232, ctermbg = 14  },
  lightred    = { fg = "#080808", bg = "#ff8787", ctermfg = 0,   ctermbg = 210 },
  green       = { fg = "#080808", bg = "#a6e22e", ctermfg = 232, ctermbg = 148 },
  orange      = { fg = "#080808", bg = "#e84f4f", ctermfg = 232, ctermbg = 208 },
  blue        = { fg = "#080808", bg = "#82b1ff", ctermfg = 232, ctermbg = 81  },
  purple      = { fg = "#080808", bg = "#ae81ff", ctermfg = 232, ctermbg = 141 },

}

local theme = {

  CurSearch      = { fg = colors.black.bg,    bg = colors.yellow.bg,      ctermfg = colors.black.ctermbg,    ctermbg = colors.yellow.ctermbg,      cterm = { bold = true  } },
  Cursor         = { fg = colors.black.bg,    bg = colors.black.fg,       ctermfg = colors.black.ctermbg,    ctermbg = colors.black.ctermfg,       cterm = { bold = true  } },
  ErrorMsg       = { fg = colors.red.fg,      bg = colors.red.bg,         ctermfg = colors.red.ctermfg,      ctermbg = colors.red.ctermbg,         cterm = { bold = true  } },
  IncSearch      = { fg = colors.black.bg,    bg = colors.lightyellow.bg, ctermfg = colors.black.ctermbg,    ctermbg = colors.lightyellow.ctermbg, cterm = { bold = true  } },
  MatchParen     = { fg = colors.purple.fg,   bg = colors.purple.bg,      ctermfg = colors.purple.ctermfg,   ctermbg = colors.purple.ctermbg,      cterm = { bold = true  } },
  Search         = { fg = colors.black.bg,    bg = colors.lightyellow.bg, ctermfg = colors.black.ctermbg,    ctermbg = colors.lightyellow.ctermbg, cterm = { bold = true  } },
  StatusLine     = { fg = colors.teal.fg,     bg = colors.teal.bg,        ctermfg = colors.teal.ctermfg,     ctermbg = colors.teal.ctermbg,        cterm = { bold = false } },
  StatusLineNC   = { fg = colors.teal.bg,     bg = colors.teal.bg,        ctermfg = colors.teal.ctermfg,     ctermbg = colors.teal.ctermbg,        cterm = { bold = true  } },
  StatusLineTerm = { fg = colors.green.bg,    bg = colors.green.bg,       ctermfg = colors.green.ctermfg,    ctermbg = colors.green.ctermbg,       cterm = { bold = false } },
  Visual         = { fg = colors.black.bg,    bg = colors.black.fg,       ctermfg = colors.black.ctermbg,    ctermbg = colors.black.ctermfg,       cterm = { bold = true  } },
  VisualNOS      = { fg = colors.black.bg,    bg = colors.black.fg,       ctermfg = colors.black.ctermbg,    ctermbg = colors.black.ctermfg,       cterm = { bold = true  } },
  WinSeparator   = { fg = colors.teal.bg,     bg = colors.teal.bg,        ctermfg = colors.teal.ctermbg,     ctermbg = colors.teal.ctermbg,        cterm = { bold = false } },
  qfError        = { fg = colors.lightred.bg, bg = colors.lightred.fg,    ctermfg = colors.lightred.ctermbg, ctermbg = colors.lightred.ctermfg,    cterm = { bold = true  } },

  Comment    = { fg = colors.black.fg, bg = "", ctermfg = colors.black.ctermfg, ctermbg = "" },
  Function   = { fg = colors.teal.bg,  bg = "", ctermfg = colors.teal.ctermbg,  ctermbg = "" },
  Identifier = { fg = colors.white.bg, bg = "", ctermfg = colors.white.ctermbg, ctermbg = "" },
  Statement  = { fg = colors.white.bg, bg = "", ctermfg = colors.white.ctermbg, ctermbg = "" },
  String     = { fg = colors.grey.bg,  bg = "", ctermfg = colors.grey.ctermbg,  ctermbg = "" },

  SpellBad =   { fg = colors.red.fg, bg = colors.red.bg, ctermfg = colors.red.ctermfg, ctermbg = colors.red.ctermbg },
  SpellLocal = { link = "SpellBad" },
  SpellRare  = { link = "SpellBad" },
  SpellCap   = { link = "Normal"   },

  TabLine     = { link = "StatusLine"   },
  TabLineFill = { link = "StatusLine"   },
  TabLineSel  = { link = "StatusLineNC" },

  DiffDelete = { fg = colors.lightred.bg, bg = "", ctermfg = colors.lightred.ctermbg, ctermbg = "" },
  DiffAdd    = { fg = colors.green.bg,    bg = "", ctermfg = colors.green.ctermbg,    ctermbg = "" },
  DiffChange = { fg = colors.blue.bg,     bg = "", ctermfg = colors.blue.ctermbg,     ctermbg = "" },
  DiffText   = { link = "DiffDelete" },

  NvimInternalError = { link = "ErrorMsg" },
  PreProc           = { link = "Function" },
  Special           = { link = "Function" },
  Type              = { link = "Function" },
  WarningMsg        = { link = "Search"   },

  Pmenu    = { link = "WildMenu" },
  PmenuSel = { fg = colors.orange.fg, bg = colors.orange.bg, ctermfg = colors.orange.ctermfg, ctermbg = colors.orange.ctermbg, cterm = { bold = true,  underline = false } },
  WildMenu = { fg = colors.orange.fg, bg = colors.orange.bg, ctermfg = colors.orange.ctermfg, ctermbg = colors.orange.ctermbg, cterm = { bold = false, underline = false } },

  DiagnosticUnderlineError = { fg = colors.lightred.bg,    bg = "", ctermfg = colors.lightred.ctermbg,    ctermbg = "", cterm = { bold = true, underline = false } },
  DiagnosticUnderlineWarn  = { fg = colors.lightyellow.bg, bg = "", ctermfg = colors.lightyellow.ctermbg, ctermbg = "", cterm = { bold = true, underline = false } },

}

for group, value in pairs(theme) do vim.api.nvim_set_hl(0, group, value) end
