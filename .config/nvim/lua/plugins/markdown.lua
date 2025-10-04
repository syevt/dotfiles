return {
  "iamcco/markdown-preview.nvim",
  ft = { "markdown" },
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  config = function()
    -- Plugin settings
    vim.g.mkdp_command_for_global = 1
    vim.g.mkdp_browser = "vivaldi-stable"

    -- Keymaps
    vim.keymap.set(
      "n",
      "<Leader>mp",
      "<Plug>MarkdownPreview",
      { desc = "Start Markdown Preview" }
    )
    vim.keymap.set(
      "n",
      "<Leader>ms",
      "<Plug>MarkdownPreviewStop",
      { desc = "Stop Markdown Preview" }
    )

    -- Enable spellcheck for markdown and gitcommit files
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "gitcommit", "markdown" },
      callback = function()
        vim.opt_local.spell = true
      end,
    })
  end,
}
