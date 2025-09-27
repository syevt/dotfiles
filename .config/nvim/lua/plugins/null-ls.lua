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
          -- extra_args = { "--config-path", vim.fn.expand("~/.stylua.toml") },
        }),

        -- null_ls.builtins.diagnostics.luacheck.with({
        -- filetypes = { "lua" },
        -- extra_args = { "--globals", "vim" }, -- so it doesn’t complain about vim
        -- }),

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

        -- Nix
        -- null_ls.builtins.formatting.alejandra.with({
        -- filetypes = { "nix" },
        -- }),
        -- or nixpkgs_fmt:
        -- null_ls.builtins.formatting.nixpkgs_fmt.with({
        --   filetypes = { "nix" },
        -- }),

        -- Linters
        -- null_ls.builtins.diagnostics.statix.with({
        -- filetypes = { "nix" },
        -- }),
        -- null_ls.builtins.diagnostics.deadnix.with({
        -- filetypes = { "nix" },
        -- }),
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
