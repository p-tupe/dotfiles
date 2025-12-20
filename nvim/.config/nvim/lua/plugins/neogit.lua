local neogit = require("neogit")

neogit.setup({
	-- Hides the hints at the top of the status buffer
	disable_hint = true,

	-- Disables changing the buffer highlights based on where the cursor is.
	disable_context_highlighting = true,

	-- Open in a split window below
	kind = "auto",

	-- Don't show recent commits in status
	status = {
		recent_commit_count = 0,
	},

	-- Disables signs for sections/items/hunks
	disable_signs = true,
})

vim.api.nvim_set_keymap("n", "<leader>G", ":Neogit<CR>", { noremap = true, silent = true })
