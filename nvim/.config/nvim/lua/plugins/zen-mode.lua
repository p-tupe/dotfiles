require("zen-mode").setup({
	window = {
		backdrop = 0,
		width = 90,
		height = 1,
		options = { signcolumn = "no", number = false, relativenumber = false },
	},
	plugins = {
		gitsigns = { enabled = false }, -- disables git signs
	},
	-- on_open = function() end,
	-- on_close = function() end,
})

vim.api.nvim_set_keymap("n", "<leader>g", ":ZenMode<CR>", { noremap = true, silent = true })
