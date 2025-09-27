-- -- Use system clipboard
vim.opt.clipboard = "unnamedplus"

-- Enable mouse support
vim.opt.mouse = "a"

-- Indentation settings
vim.opt.shiftwidth = 2      -- indent size
vim.opt.softtabstop = 2     -- how many spaces a <Tab> feels like while editing
vim.opt.tabstop = 2         -- how many spaces a real tab character represents
vim.opt.smarttab = true     -- tab respects 'shiftwidth'
vim.opt.expandtab = true    -- convert tabs to spaces
vim.opt.smartindent = true  -- smart autoindenting on new lines

vim.opt.list = true
vim.opt.listchars = {
  tab = ">·",
  trail = "~",
  extends = ">",
  precedes = "<",
}

vim.opt.number = true

vim.opt.wildignore:append({
  "*/tmp/*", "*/node_modules/*", "*.so", "*.swp", "*.log", "*.zip",       -- macOS/Linux
})

vim.opt.termguicolors = true
vim.opt.colorcolumn = "80"
vim.opt.foldmethod = "indent"
vim.opt.foldenable = false
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true

