return {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
  config = function()
    local mc = require("multicursor-nvim")

    mc.setup({
      hint_config = { border = "rounded" },
    })

    -- ✅ Keymaps
    -- Add a new cursor on the next match of the current word (like <C-n> in vim-multiple-cursors)
    vim.keymap.set({ "n", "v" }, "<C-n>", function()
      mc.match_add_cursor(1) -- 1 = forward, -1 = backward
    end, { desc = "Add cursor on next match" })

    -- Go to next match without adding cursor
    vim.keymap.set({ "n", "v" }, "<C-z>", function()
      mc.match_skip_cursor(1)
    end, { desc = "Skip to next match" })

    -- Quit multicursor mode
    vim.keymap.set(
      "n",
      "<C-e>",
      mc.clear_cursors,
      { desc = "Exit multicursor mode" }
    )
  end,
}
