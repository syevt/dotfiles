return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy",
  priority = 1000,
  config = function()
    require("tiny-inline-diagnostic").setup({
      options = {
        virt_texts = {
          -- Priority for virtual text display (higher values appear on top)
          -- Increase if other plugins (like GitBlame) override diagnostics
          -- priority = 8048,
        },
        use_icons_from_diagnostic = true,
      },
    })
    vim.diagnostic.config({ virtual_text = false }) -- Disable default virtual text
  end,
}
