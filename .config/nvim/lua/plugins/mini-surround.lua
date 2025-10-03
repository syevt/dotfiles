return {
  "echasnovski/mini.surround",
  version = "*", -- use latest stable release
  config = function()
    local surround = require("mini.surround")

    surround.setup({
      -- You can override default keymaps here if you want
      mappings = {
        add = "ys", -- Add surrounding
        delete = "ds", -- Delete surrounding
        replace = "cs", -- Change surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        update_n_lines = "gsn", -- Update surrounding across lines
      },
      -- Optional: configure delimiters or any custom behavior
    })
  end,
}
