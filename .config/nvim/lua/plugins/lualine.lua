return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        component_separators = { left = "", right = "" },
      },
      sections = {
        -- lualine_b = { { "branch", icon = "" } },
        lualine_b = { { "branch", icon = "" } },
        -- lualine_x = { "encoding", "fileformat", "filetype", "lsp_status" },
        lualine_x = { "filetype", "lsp_status" },
      },
    })
  end,
}
