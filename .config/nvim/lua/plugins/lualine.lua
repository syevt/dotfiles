return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        component_separators = { left = "", right = "" },
      },
      sections = {
        lualine_x = { "encoding", "fileformat", "filetype", "lsp_status" },
      },
    })
  end,
}
