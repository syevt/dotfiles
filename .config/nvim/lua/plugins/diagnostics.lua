-- vim.diagnostics.Opts.float doesn't work at all
-- so need this autofunction to show floats on hover
--vim.o.updatetime = 250
--vim.api.nvim_create_autocmd("CursorHold", {
--callback = function()
--vim.diagnostic.open_float(nil, { focusable = false })
--end,
--})

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = " ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
  --virtual_lines = { current_line = true },
  --virtual_text = { current_line = true },
  virtual_text = false,
  virtual_lines = false,
  float = true,
  --float = {},
  --float = {
  --border = "rounded",
  --source = "always",    -- show source in float
  --focusable = false,    -- let cursor move past the float
  --style = "minimal",
  --header = "",
  --prefix = "",
  --},
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
