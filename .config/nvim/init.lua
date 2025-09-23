-- Load core config
-- require("config.options")
require("config.keymaps")
-- require("config.autocmds")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("plugins")

vim.lsp.enable({ 'tsls', 'psls' })

-- vim.api.nvim_create_autocmd('LspAttach', {
  -- callback = function(ev)
    -- local client = vim.lsp.get_client_by_id(ev.data.client_id)
    -- if client:supports_method('textDocument/completion') then
      -- vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    -- end
  -- end,
-- })

vim.diagnostic.config({
  -- virtual_text = { current_line = true }
  virtual_lines = { current_line = true }
})

-- still loading old config
-- vim.opt.runtimepath:prepend("~/.vim")
-- vim.opt.runtimepath:append("~/.vim/after")
-- vim.opt.packpath = vim.opt.runtimepath:get()
vim.cmd("source ~/.vimrc")
