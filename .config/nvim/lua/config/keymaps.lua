-- Set leader key
vim.g.mapleader = ","

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- 🟦 Mode exits
-- Insert mode: '<<' → exit to normal
map(
  "i",
  "<<",
  "<Esc>",
  vim.tbl_extend("force", opts, { desc = "Exit insert mode with <<" })
)

-- Visual mode: '<<' → exit to normal
map(
  "v",
  "<<",
  "<Esc>",
  vim.tbl_extend("force", opts, { desc = "Exit visual mode with <<" })
)

-- 🟩 Search
map(
  "n",
  "<Leader><Space>",
  ":nohlsearch<CR>",
  vim.tbl_extend("force", opts, { desc = "Clear search highlights" })
)

-- 🟧 Tools
-- Format JSON document in current buffer
map(
  "n",
  "<leader>fj",
  ":%!jq<CR>",
  vim.tbl_extend("force", opts, { desc = "Format JSON with jq" })
)

-- Helper to get project root (Git root or cwd fallback)
local function get_project_root()
  local handle = io.popen("git rev-parse --show-toplevel 2> /dev/null")
  if handle then
    local result = handle:read("*a"):gsub("%s+$", "")
    handle:close()
    if result ~= "" then
      return result
    end
  end
  return vim.fn.getcwd()
end

-- Copy current buffer file path relative to project root
map("n", "<leader>cfp", function()
  local bufname = vim.fn.expand("%:p") -- full path
  local root = get_project_root()
  local relpath = vim.fn.fnamemodify(bufname, ":." .. root)
  vim.fn.setreg("+", relpath) -- copy to system clipboard
  vim.notify(
    "📋 File path copied (relative to project root)",
    vim.log.levels.INFO
  )
end, { desc = "Copy file path relative to project root", silent = true })

-- Yank visual lines with file name once + line numbers
map(
  "v",
  "<leader>yn",
  function()
    local start_line = vim.fn.line("v") -- visual start
    local end_line = vim.fn.line(".") -- visual end
    if start_line > end_line then
      start_line, end_line = end_line, start_line
    end

    -- Get buffer lines
    local lines = vim.fn.getline(start_line, end_line)

    -- Determine project root and relative file path
    local root = get_project_root()
    local bufname = vim.fn.expand("%:p") -- full path
    local relpath = vim.fn.fnamemodify(bufname, ":." .. root)

    -- Prefix lines with line numbers only
    for i, l in ipairs(lines) do
      lines[i] = string.format("%d: %s", start_line + i - 1, l)
    end

    -- Insert the file path at the top
    table.insert(lines, 1, relpath)

    -- Copy to system clipboard
    vim.fn.setreg("+", table.concat(lines, "\n"))
    vim.notify("Copied lines with file name and numbers", vim.log.levels.INFO)
  end,
  { desc = "Yank lines with file name once and line numbers", silent = true }
)

-- map("n", "gd", vim.lsp.buf.definition, opts)
map("n", "gT", vim.lsp.buf.type_definition, opts)
map("n", "gD", vim.lsp.buf.declaration, opts)
map("n", "gi", vim.lsp.buf.implementation, opts)
map("n", "gr", function()
  require("telescope.builtin").lsp_references({ show_line = true })
end, { desc = "Telescope LSP References", buffer = buf })
map("n", "rn", vim.lsp.buf.rename, opts)
map("n", "ca", vim.lsp.buf.code_action, opts)
map("n", "<leader>ds", function()
  require("telescope.builtin").lsp_document_symbols()
end, { desc = "Telescope document symbols", buffer = buf })

-- does not work so far
-- map("n", "<leader>ws", function()
--   require("telescope.builtin").lsp_workspace_symbols()
-- end, { desc = "Telescope workspace symbols", buffer = buf })

map("n", "<leader>ws", "<cmd>Telescope lsp_workspace_symbols", opts)
map(
  "n",
  "<leader>ws",
  vim.lsp.buf.workspace_symbol,
  { desc = "Workspace Symbols" }
)
-- map("n", "K", vim.lsp.buf.hover, opts)
