-- Mappings

vim.cmd("map <ScrollWheelUp> <Nop>")
vim.cmd("map <ScrollWheelDown> <Nop>")
vim.g.user_emmet_Leader_key = ","
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "<Leader>w", "<C-w>v<C-w>l")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("x", "<Leader>p", '"_dP')
vim.keymap.set("n", "<space>a", "ggVG")
vim.keymap.set("n", "<space>w", "<cmd>write<CR>")
vim.keymap.set("n", "<leader>f", "<cmd>Format<CR>")
vim.keymap.set({"n", "v", "o"}, "Q", "<Nop>")
vim.keymap.set("n", "<up>", "ddkP")
vim.keymap.set("n", "<down>", "ddp")
vim.keymap.set({"v", "i", "o"}, "<up>", "<Nop>")
vim.keymap.set({"v", "i", "o"}, "<down>", "<Nop>")
vim.keymap.set({"v", "n", "i", "o"}, "<left>", "<Nop>")
vim.keymap.set({"v", "n", "i", "o"}, "<right>", "<Nop>")

-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", builtin.find_files, {})
