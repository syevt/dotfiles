return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  dependencies = {
    "neovim-treesitter/treesitter-parser-registry",
  },
  lazy = false,
  build = ":TSUpdate",

  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local buf = args.buf

        -- Ignore special buffers (Telescope, terminals, etc.).
        if vim.bo[buf].buftype ~= "" then
          return
        end

        local ft = vim.bo[buf].filetype
        local lang = vim.treesitter.language.get_lang(ft)

        if not lang then
          return
        end

        local filename = vim.api.nvim_buf_get_name(buf)
        local stats = vim.uv.fs_stat(filename)

        -- Skip highlighting for files larger than 100 KB.
        if stats and stats.size > 100 * 1024 then
          return
        end

        -- Enable highlighting only if the parser works.
        local ok = pcall(vim.treesitter.start, buf, lang)

        if not ok then
          return
        end
      end,
    })
  end,
}

-- return {
--   "nvim-treesitter/nvim-treesitter",
--   build = ":TSUpdate",
--   branch = "master", -- this is for Neovim < 0.11
--   -- event = { "BufReadPost", "BufNewFile" },
--   -- lazy = false,
--
--   config = function()
--     require("nvim-treesitter.configs").setup({
--       auto_install = true,
--
--       highlight = {
--         enable = true,
--
--         -- Disable treesitter highlight for large files
--         disable = function(lang, buf)
--           local max_filesize = 100 * 1024 -- 100 KB
--           local ok, stats =
--             pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
--           if ok and stats and stats.size > max_filesize then
--             return true
--           end
--         end,
--
--         additional_vim_regex_highlighting = false,
--       },
--
--       indent = {
--         enable = true,
--         disable = { "markdown", "markdown_inline" },
--       },
--     })
--   end,
-- }
