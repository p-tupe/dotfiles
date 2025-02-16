vim.api.nvim_set_keymap("n", "<leader>p", ":Neoformat<CR>", { noremap = true, silent = true })

-- Enable alignment
vim.g.neoformat_basic_format_align = 1

-- Enable tab to spaces conversion
vim.g.neoformat_basic_format_retab = 1

-- Enable trimmming of trailing whitespace
vim.g.neoformat_basic_format_trim = 1

-- Only msg when there is an error
vim.g.neoformat_only_msg_on_error = 1
