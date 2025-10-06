return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      event_handlers = {
        {
          event = "file_opened",
          handler = function(file_path)
            -- auto close neo-tree when a file is opened
            require("neo-tree.command").execute({ action = "close" })
          end,
        },
      },

      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_ignored = true,
        },
      },
    })

    vim.keymap.set(
      "n",
      "<S-Tab>",
      "<cmd>Neotree toggle<CR>",
      { desc = "Toggle Neo-tree" }
    )
    vim.keymap.set(
      "n",
      "<leader>nf",
      "<cmd>Neotree reveal<CR>",
      { desc = "Neo-tree reveal current file" }
    )
  end,
}
