return {
  "hrsh7th/nvim-cmp",

  -- event = "InsertEnter", -- load only when you start typing
  config = function()
    local cmp = require("cmp")
    local lspkind = require("lspkind")

    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      sources = {
        { name = "path" },
        { name = "cmdline" },
        { name = "nvim_lsp", keyword_length = 1 },
        { name = "buffer", keyword_length = 3 },
        { name = "cmp_tabnine", keyword_length = 1 },
      },
      window = {
        documentation = cmp.config.window.bordered(),
      },
      -- 🔹 Use cmdline & path source for ':' (commands)
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "path" },
          { name = "cmdline" },
        },
      }),
      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol_text", -- "text", "text_symbol", "symbol_text", "symbol"
          maxwidth = 50, -- truncate long entries
          ellipsis_char = "...",
          menu = {
            buffer = "[Buf]",
            nvim_lsp = "[LSP]",
            path = "[Path]",
            cmdline = "[Cmd]",
            cmp_tabnine = "[TN]",
          },
        }),
      },
    })
  end,
}
