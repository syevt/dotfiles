return {
  "lewis6991/gitsigns.nvim",

  config = function()
    require("gitsigns").setup({
      current_line_blame = true,

      current_line_blame_formatter = "<author> • <author_time:%d.%m.%Y> • <summary>",

      on_attach = function(bufnr)
        local gs = require("gitsigns")

        local map = function(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, {
            buffer = bufnr,
            desc = desc,
          })
        end

        map("[g", function()
          gs.nav_hunk("prev")
        end, "Previous git hunk")

        map("]g", function()
          gs.nav_hunk("next")
        end, "Next git hunk")

        map("[G", function()
          gs.nav_hunk("first")
        end, "First git hunk")

        map("]G", function()
          gs.nav_hunk("last")
        end, "Last git hunk")

        map("<leader>ghr", gs.reset_hunk, "Reset git hunk")

        map("<leader>ghp", gs.preview_hunk_inline, "Preview git hunk")
      end,
    })
  end,
}
-- return {
--   "lewis6991/gitsigns.nvim",
--   config = function()
--     require("gitsigns").setup({
--       current_line_blame = true,
--       current_line_blame_formatter = "<author> • <author_time:%d.%m.%Y> • <summary>",
--
--       on_attach = function(bufnr)
--         local gitsigns = require("gitsigns")
--
--         vim.keymap.set(
--           "n",
--           "[G",
--           gitsigns.nav_hunk({ "first" }),
--           { buffer = bufnr }
--         )
--         vim.keymap.set(
--           "n",
--           "[g",
--           gitsigns.nav_hunk({ "prev" }),
--           { buffer = bufnr }
--         )
--         vim.keymap.set(
--           "n",
--           "]g",
--           gitsigns.nav_hunk({ "next" }),
--           { buffer = bufnr }
--         )
--         vim.keymap.set(
--           "n",
--           "]G",
--           gitsigns.nav_hunk({ "last" }),
--           { buffer = bufnr }
--         )
--         vim.keymap.set(
--           "n",
--           "<leader>ghr",
--           gitsigns.reset_hunk,
--           { buffer = bufnr }
--         )
--         vim.keymap.set(
--           "n",
--           "<leader>ghp",
--           gitsigns.preview_hunk_inline,
--           { buffer = bufnr }
--         )
--       end,
--     })
--   end,
-- }
