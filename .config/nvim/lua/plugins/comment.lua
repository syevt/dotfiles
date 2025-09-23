return {
  "numToStr/Comment.nvim",
  config = function()
    local comment = require("Comment")
    comment.setup({
      toggler = {
        line = '<leader>c<Space>',
      },
      oppleader = {
        line = '<leader>c<Space>',
      },
    })
  end,
}
