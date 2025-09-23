local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  local map = vim.keymap.set
  map("n", "gd", vim.lsp.buf.definition, opts)
  map("n", "gD", vim.lsp.buf.declaration, opts)
  map("n", "gi", vim.lsp.buf.implementation, opts)
  map("n", "gr", vim.lsp.buf.references, opts)
  map("n", "K", vim.lsp.buf.hover, opts)
  map("n", "<leader>rn", vim.lsp.buf.rename, opts)
  map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
end

-- This ensures nvim-lspconfig is loaded
-- local ok, _ = pcall(require, "lspconfig")
-- if not ok then
  -- vim.notify("nvim-lspconfig not found", vim.log.levels.ERROR)
  -- return
-- end

-- -- TypeScript: use local node_modules/.bin if available
-- vim.lsp.config.tsserver.setup({
  -- on_attach = on_attach,
  -- capabilities = capabilities,
  -- cmd = { vim.fn.getcwd() .. "/node_modules/.bin/typescript-language-server", "--stdio" },
  -- root_dir = vim.fs.root(0, { "package.json", "tsconfig.json", ".git" }),
-- })

-- -- PureScript: similar, point to project-local binary
-- vim.lsp.config.purescriptls.setup({
  -- on_attach = on_attach,
  -- capabilities = capabilities,
  -- cmd = { vim.fn.getcwd() .. "/node_modules/.bin/purescript-language-server", "--stdio" },
  -- root_dir = vim.fs.root(0, { "spago.dhall", "bower.json", ".git" }),
-- })
-- vim.lsp.config('tsserver', {
  -- settings = {
    -- ['rust-analyzer'] = {
      -- checkOnSave = {
        -- command = "clippy",
      -- },
    -- },
  -- },
-- })
