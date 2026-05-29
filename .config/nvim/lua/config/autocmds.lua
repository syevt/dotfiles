-- This is to remove default LSP keymaps
-- The custom keymaps are defined in keymaps.lua
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local keys_to_remove = { "grr", "gra", "grn", "grd", "gri", "grt" }
    for _, k in ipairs(keys_to_remove) do
      pcall(vim.keymap.del, "n", k)
      pcall(vim.keymap.del, "n", k, { buffer = args.buf })
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true

    vim.opt_local.indentexpr = nil
    vim.opt_local.autoindent = true
    vim.opt_local.smartindent = false
    vim.opt_local.cindent = false
  end,
})
