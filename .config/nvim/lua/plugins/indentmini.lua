return {
  "nvim-mini/mini.indentscope",
  version = "*",
  config = function()
    require("mini.indentscope").setup({
      draw = {
        delay = 50,           -- how fast to draw after moving cursor
      },
      symbol = "│",           -- the character used for guides
      options = {
        border = "both",      -- show guides only inside the scope
        indent_at_cursor = true,
        try_as_border = true,
      },
    })

    -- Disable for certain filetypes
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "help", "neo-tree", "dashboard" },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })
  end,
}
