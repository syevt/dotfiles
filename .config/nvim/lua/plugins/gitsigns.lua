return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      current_line_blame = true,
      current_line_blame_formatter = "<author> • <author_time:%d.%m.%Y> • <summary>",

      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        vim.keymap.set(
          "n",
          "<leader>gph",
          gitsigns.reset_hunk,
          { buffer = bufnr }
        )
        vim.keymap.set(
          "n",
          "<leader>grh",
          gitsigns.preview_hunk,
          { buffer = bufnr }
        )
      end,
    })
  end,
}
