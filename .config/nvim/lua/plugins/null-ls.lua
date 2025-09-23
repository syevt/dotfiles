--return {
  --"nvimtools/none-ls.nvim",
  --dependencies = { "nvim-lua/plenary.nvim" },
  --config = function()
    --local null_ls = require("null-ls")

    --null_ls.setup({
      --sources = {
        ---- Lua only
        --null_ls.builtins.formatting.stylua.with({
          --filetypes = { "lua" },
        --}),

        ---- JS/TS only
        --null_ls.builtins.formatting.prettier.with({
          --filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        --}),
        --null_ls.builtins.diagnostics.eslint_d.with({
          --filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        --}),

        ---- PureScript only
        --null_ls.builtins.formatting.purs_tidy.with({
          --filetypes = { "purescript" },
        --}),
      --},
      --on_attach = function(client, bufnr)
        --if client.supports_method("textDocument/formatting") then
          --vim.api.nvim_buf_set_keymap(
            --bufnr,
            --"n",
            --"<leader>f",
            --"<cmd>lua vim.lsp.buf.format({ async = true })<CR>",
            --{ noremap = true, silent = true }
          --)
        --end
      --end,
    --})

    --vim.api.nvim_create_autocmd("BufWritePre", {
      --pattern = "*",
      --callback = function()
        --vim.lsp.buf.format({ async = false })
      --end,
    --})

  --end,
--}
return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        -- Lua
        null_ls.builtins.formatting.stylua.with({
          filetypes = { "lua" },
        }),

        -- JS/TS
        null_ls.builtins.formatting.prettier.with({
          filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
          },
        }),
        require("none-ls.diagnostics.eslint").with({
        --require("none-ls-extras.diagnostics.eslint_d").with({
          filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
          },
        }),

        -- PureScript
        null_ls.builtins.formatting.purs_tidy.with({
          filetypes = { "purescript" },
        }),
      },

      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_buf_set_keymap(
            bufnr,
            "n",
            "<leader>af",
            "<cmd>lua vim.lsp.buf.format({ async = true })<CR>",
            { noremap = true, silent = true }
          )
        end
      end,
    })


    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end,
}
