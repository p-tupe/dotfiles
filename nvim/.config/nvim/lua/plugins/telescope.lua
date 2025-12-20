local telescope = require("telescope")

telescope.setup({
	defaults = {
		selection_caret = " ",
		prompt_prefix = "",
		highlight = false,
		mappings = {
			i = { ["<ESC>"] = require("telescope.actions").close, ["<C-[>"] = require("telescope.actions").close },
		},
	},
	pickers = {
		find_files = { theme = "dropdown", previewer = false, no_ignore = false },
		buffers = { prompt_title = "Find Buffer" },
		lsp_code_actions = { theme = "cursor" },
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
		},
	},
})

telescope.load_extension("fzf")

local s = { noremap = true, silent = true }
local k = vim.api.nvim_set_keymap

k("n", "<C-t>", "<cmd>Telescope find_files<CR>", s)
k("n", "<C-S-t>", "<cmd>Telescope find_files no_ignore=true<CR>", s)
k("n", "<C-p>", "<cmd>Telescope buffers<CR>", s)
k("n", "<C-s>", "<cmd>Telescope live_grep<CR>", s)
