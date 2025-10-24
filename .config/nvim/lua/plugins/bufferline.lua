return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local highlights = require("nord").bufferline.highlights({
      italic = true,
      bold = false,
      fill = "#181c24",
      diagnostic_error = { fg = "#fb4934" }, -- red
      diagnostic_warn = { fg = "#fabd2f" }, -- yellow
      diagnostic_info = { fg = "#83a598" }, -- blue
      diagnostic_hint = { fg = "#8ec07c" }, -- green
    })

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
      highlights = highlights,
    })
  end,
}
