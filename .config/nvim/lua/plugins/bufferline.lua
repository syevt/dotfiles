return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    require("bufferline").setup({
      options = {
        separator_style = "slant",
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(
          count,
          level,
          diagnostics_dict,
          context
        )
          local icon = (level:match("error") and " ")
            or (level:match("warn") and " ")
            or (level:match("info") and " ")
            or (level:match("hint") and " ")
          return " " .. icon .. count
        end,
      },
    })
  end,
}
