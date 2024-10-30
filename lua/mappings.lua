vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "{", "{zzzv")
vim.keymap.set("n", "}", "}zzzv")

vim.keymap.set("n", "<leader>sv", "<C-w>v<C-w>w", { desc = "[S]plit window [V]ertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s<C-w>w", { desc = "[S]plit window [H]orizontally" })
vim.keymap.set("n", "<leader>ww", "<C-w>w", { desc = "Switch [W]indow" })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

vim.keymap.set("i", "<A-q>", "<Esc>:q<CR>")
vim.keymap.set("i", "<A-w>", "<Esc>:w<CR>")
vim.keymap.set("i", "<A-z>", "<Esc><C-z>")
vim.keymap.set("n", "<A-q>", ":q<CR>")
vim.keymap.set("n", "<A-w>", ":w<CR>")
vim.keymap.set("n", "<A-z>", "<C-z>")
