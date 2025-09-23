return {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")  -- <- load actions first

    telescope.setup({
      defaults = {
        sorting_strategy = "ascending",  -- results start at the top
        layout_config = {
          horizontal = {
            prompt_position = "top",
          },
          vertical = {
            prompt_position = "top",
          },
        },
        mappings = {
          i = {  -- insert mode
            ["<Esc>"] = actions.close,
          },
          n = {  -- normal mode
            ["<Esc>"] = actions.close,
          },
        },
      },
    })

    local builtin = require('telescope.builtin')
    vim.keymap.set(
      'n',
      '<leader>p',
      builtin.find_files,
      { desc = 'Telescope find files' }
    )
    vim.keymap.set(
      'n',
      '<leader>rg',
      builtin.live_grep,
      { desc = 'Telescope live grep' }
    )
    vim.keymap.set(
      'n',
      ';',
      builtin.buffers,
      { desc = 'Telescope buffers' }
    )
    vim.keymap.set(
      'n',
      '<leader>fh',
      builtin.lsp_dynamic_workspace_symbols,
      { desc = 'Telescope workspace LSP tags' }
    )
  end,
}
