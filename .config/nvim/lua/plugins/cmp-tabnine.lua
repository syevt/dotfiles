return {
  "tzachar/cmp-tabnine",
  build = "./install.sh",
  dependencies = "hrsh7th/nvim-cmp",
  config = function()
    -- vim.g.cmp_tabnine_binary_path =
    -- "/home/syevt/.local/share/nvim/lazy/cmp-tabnine/binaries/4.304.0/x86_64-unknown-linux-musl/TabNine"

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
