return {
  "numToStr/Comment.nvim",
  config = function()
    local comment = require("Comment")
    comment.setup({
      toggler = {
        line = "<leader>c<Space>",
      },
      opleader = {
        line = "<leader>c<Space>",
        block = "<leader>cb<Space>",
      },
    })
  end,
}
