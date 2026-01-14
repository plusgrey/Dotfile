vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-l>", "<Right>")
vim.keymap.set("i", "<C-j>", "<Down>")
vim.keymap.set("i", "<C-k>", "<Up>")

vim.keymap.set("i", "jk", "<Esc>")

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")

vim.keymap.set({ "n", "x", "o" }, "<S-H>", "^", { desc = "Start of line" })
vim.keymap.set({ "n", "x", "o" }, "<S-L>", "$", { desc = "End of line" })

vim.keymap.set({ "n", "x" }, "Q", "<CMD>:qa<CR>")
vim.keymap.set({ "n", "x" }, "qq", "<CMD>:q<CR>")

vim.keymap.set("n", "<A-z>", "<CMD>set wrap!<CR>", { desc = "Toggle line wrap" })

-- Quick save with Ctrl+S
vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<CMD>w<CR>", { desc = "Save file" })

--delete without yanking
vim.keymap.set({ "n", "x" }, "x", '"_x')
vim.keymap.set({ "n", "x" }, "d", '"_d')
vim.keymap.set("n", "c", '"_c')
vim.keymap.set({ "n", "v" }, "dd", '"_dd')


-- 让 'y' 默认复制到系统剪贴板 ("+y)
vim.keymap.set({ "n", "x" }, "y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("n", "yy", '"+yy', { desc = "Yank line to system clipboard" })

-- 让 '<leader>y' 对应原版的 yank 功能 (复制到内部寄存器)
vim.keymap.set({ "n", "x" }, "<leader>y", '""y', { desc = "Yank to internal register" })
vim.keymap.set("n", "<leader>yy", '""yy', { desc = "Yank line to internal register" })

-- <C-o> 回跳并居中
vim.keymap.set("n", "<C-o>", "<C-o>zz", { desc = "Go back and center" })
vim.keymap.set("n", "<C-i>", "<C-i>zz", { desc = "Go forward and center" })


