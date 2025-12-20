require("nvim-tree").setup({ disable_netrw = true }) -- False when sshing

-- Open nvim tree side window
vim.api.nvim_set_keymap("n", "<leader>z", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- Open current file in nvim tree
vim.api.nvim_set_keymap("n", "<leader>f", ":NvimTreeFindFileToggle<CR>", { noremap = true, silent = true })
