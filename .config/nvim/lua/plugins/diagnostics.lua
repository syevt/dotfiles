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
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
