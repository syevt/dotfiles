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
