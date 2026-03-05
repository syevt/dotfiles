-- teal-paper.nvim
-- fg: #004357 | bg: #b8bba4

-- ========================
-- Options
-- ========================
local italics = vim.g["teal-paper-italics"]
if italics == nil then
  italics = true
end

-- ========================
-- Boilerplate
-- ========================
vim.o.termguicolors = true
vim.o.background = "light"

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "teal-paper"

local hi = vim.api.nvim_set_hl

-- ========================
-- Palette
-- ========================
local c = {
  fg      = "#004357",
  bg      = "#b8bba4",

  bg_alt  = "#aeb19b",
  bg_dark = "#9fa28e",

  subtle  = "#7b8b8f",
  comment = "#5f6f73",

  red     = "#8b2e2e",
  orange  = "#9a5a1f",
  yellow  = "#8a7a1f",
  green   = "#3e6f4f",
  cyan    = "#2f6f7a",
  blue    = "#2a5f87",
  purple  = "#5a4a7a",

  error   = "#8b1e1e",
  warn    = "#9a6a1f",
  info    = "#2f6f7a",
  hint    = "#4f7a6a",
}

-- ========================
-- Core UI
-- ========================
hi(0, "Normal",       { fg = c.fg, bg = c.bg })
hi(0, "NormalFloat",  { fg = c.fg, bg = c.bg_alt })
hi(0, "CursorLine",   { bg = c.bg_alt })
hi(0, "Visual",       { bg = c.bg_dark })

hi(0, "LineNr",       { fg = c.subtle })
hi(0, "CursorLineNr", { fg = c.blue, bold = true })

hi(0, "VertSplit",    { fg = c.bg_dark })
hi(0, "WinSeparator", { fg = c.bg_dark })

hi(0, "StatusLine",   { fg = c.fg, bg = c.bg_alt })
hi(0, "StatusLineNC", { fg = c.subtle, bg = c.bg_alt })

hi(0, "Search",       { fg = c.bg, bg = c.blue })
hi(0, "IncSearch",    { fg = c.bg, bg = c.orange })

-- ========================
-- Popup / Completion
-- ========================
hi(0, "Pmenu",        { fg = c.fg, bg = c.bg_alt })
hi(0, "PmenuSel",     { fg = c.bg, bg = c.blue })
hi(0, "PmenuSbar",    { bg = c.bg_dark })
hi(0, "PmenuThumb",   { bg = c.blue })

-- ========================
-- Syntax
-- ========================
hi(0, "Comment",    { fg = c.comment, italic = italics })
hi(0, "String",     { fg = c.green })
hi(0, "Number",     { fg = c.orange })
hi(0, "Boolean",    { fg = c.orange })
hi(0, "Constant",   { fg = c.orange })

hi(0, "Identifier", { fg = c.fg })
hi(0, "Function",   { fg = c.blue })
hi(0, "Keyword",    { fg = c.purple, italic = italics })
hi(0, "Operator",   { fg = c.cyan })
hi(0, "Type",       { fg = c.yellow, italic = italics })

-- ========================
-- Diagnostics (LSP)
-- ========================
hi(0, "DiagnosticError", { fg = c.error })
hi(0, "DiagnosticWarn",  { fg = c.warn })
hi(0, "DiagnosticInfo",  { fg = c.info })
hi(0, "DiagnosticHint",  { fg = c.hint })

hi(0, "DiagnosticUnderlineError", { undercurl = true, sp = c.error })
hi(0, "DiagnosticUnderlineWarn",  { undercurl = true, sp = c.warn })
hi(0, "DiagnosticUnderlineInfo",  { undercurl = true, sp = c.info })
hi(0, "DiagnosticUnderlineHint",  { undercurl = true, sp = c.hint })

-- ========================
-- Git
-- ========================
hi(0, "GitSignsAdd",    { fg = c.green })
hi(0, "GitSignsChange", { fg = c.yellow })
hi(0, "GitSignsDelete", { fg = c.red })

-- ========================
-- Telescope
-- ========================
hi(0, "TelescopeNormal",    { fg = c.fg, bg = c.bg })
hi(0, "TelescopeBorder",    { fg = c.bg_dark })
hi(0, "TelescopeSelection", { bg = c.bg_alt })
hi(0, "TelescopeMatching",  { fg = c.blue, bold = true })

-- ========================
-- WhichKey
-- ========================
hi(0, "WhichKey",      { fg = c.blue })
hi(0, "WhichKeyGroup", { fg = c.purple })
hi(0, "WhichKeyDesc",  { fg = c.fg })

-- ========================
-- Tree-sitter
-- ========================
hi(0, "@comment",   { link = "Comment" })
hi(0, "@string",    { link = "String" })
hi(0, "@function",  { link = "Function" })
hi(0, "@keyword",   { link = "Keyword" })
hi(0, "@type",      { link = "Type" })
hi(0, "@constant",  { link = "Constant" })
