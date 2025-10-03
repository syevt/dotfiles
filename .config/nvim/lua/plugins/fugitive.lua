return {
  "tpope/vim-fugitive",

  config = function()
    local map = vim.keymap.set

    map(
      "n",
      "<leader>gco",
      ":Git checkout ",
      { desc = "Git checkout (fugitive)" }
    )
    -- map("n", "<leader>gb", ":Gblame<CR>", { desc = "Git blame" })
    map("n", "<leader>gd", ":Gvdiff ", { desc = "Git diff vertical" })
    map("n", "<leader>gd3", ":Gdiffsplit!<CR>", { desc = "Git 3-way diff" })
    map("n", "<leader>ge", ":Gedit<CR>", { desc = "Git edit" })
    map("n", "<leader>gw", ":Gwrite<CR>", { desc = "Git write" })
    map("n", "<leader>gwf", ":Gwrite!<CR>", { desc = "Git force write" })
    map("n", "<leader>gr", ":Gread<CR>", { desc = "Git read" })
    map("n", "<leader>gu", ":Gdiffupdate<CR>", { desc = "Git diff update" })
    map("n", "<leader>gh", ":0Gclog<CR>", { desc = "Git commit log (HEAD)" })

    -- 🔹 Auto close fugitive:// buffers
    vim.api.nvim_create_autocmd("BufReadPost", {
      pattern = "fugitive://*",
      command = "set bufhidden=delete",
    })

    -- 🔹 Custom behavior for fugitive tree/blob buffers
    vim.api.nvim_create_autocmd("User", {
      pattern = "fugitive",
      callback = function()
        local fugitive = vim.fn["fugitive#buffer"]()
        if fugitive.type:match("tree") or fugitive.type:match("blob") then
          vim.keymap.set("n", "..", ":edit %:h<CR>", { buffer = true })
        end
      end,
    })
  end,
}
