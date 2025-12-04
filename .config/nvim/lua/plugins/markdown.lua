return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  config = function()
    require("render-markdown").setup({
      code = {
        language = false,
        disable_background = true,
        highlight_border = false,
        border = "none",
        width = "block",
      },
    })
  end,
  opts = {},
}
