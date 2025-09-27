return {
  "tzachar/cmp-tabnine",
  run = "./install.sh",
  dependencies = { "hrsh7th/nvim-cmp" },
  config = function()
    local tabnine = require("cmp_tabnine.config")
    tabnine:setup({
      max_lines = 1000,
      max_num_results = 20,
      sort = true,
      run_on_every_keystroke = true,
      snippet_placeholder = "..",
      ignored_file_types = {},
      show_prediction_strength = false,
      min_percent = 0,
    })

    vim.keymap.set("n", "<leader>tn", function()
      print(vim.inspect(require("cmp").get_config().sources))
    end, { desc = "Show nvim-cmp sources" })
  end,
}
