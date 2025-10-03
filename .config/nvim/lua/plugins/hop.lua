return {
  "smoka7/hop.nvim",
  version = "*",
  opts = {}, -- use defaults
  config = function(_, opts)
    local hop = require("hop")
    hop.setup(opts)

    local set = vim.keymap.set
    local hop_hint = require("hop.hint")

    -- 🔹 Keymaps
    set("n", "<leader>s", function()
      hop.hint_char1()
    end, { desc = "Hop to single character" })

    set("n", "<leader>z", function()
      hop.hint_char2()
    end, { desc = "Hop to two-character sequence" })

    -- 🔹 Highlights (replaces `hi link`)
    vim.api.nvim_set_hl(0, "HopNextKey", { link = "WarningMsg" })
    vim.api.nvim_set_hl(0, "HopNextKey1", { link = "WarningMsg" })
    vim.api.nvim_set_hl(0, "HopNextKey2", { link = "WarningMsg" })
  end,
}
