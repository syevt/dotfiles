vim.g.mapleader = ","

-- Insert mode: '<<' → exit to normal
vim.keymap.set("i", "<<", "<Esc>", { desc = "Exit insert mode with <<" })

-- Visual mode: '<<' → exit to normal
vim.keymap.set("v", "<<", "<Esc>", { desc = "Exit visual mode with <<" })

vim.keymap.set("n", "<Leader><Space>", ":nohlsearch<CR>", { desc = "Clear search highlights" })

