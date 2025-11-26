-- mappings table takes the form:
-- { {lhs, rhs, desc?, silent? } }

local normal_mode_mappings = {
	{ "<SPACE>", "<NOP>", "Space becomes NOP" },
	{ ",", "<NOP>", "Comma becomes NOP" },
	{ "j", "gj", "Scroll down by visual line" },
	{ "k", "gk", "Scroll up by visual line" },
	{ "0", "^", "Go to sentence start in normal mode" },
	{ "-", "g_", "Go to sentence end in normal mode" },
	{ ";", ":", "Colon switch", false },
	{ "<leader>s", ":update<CR>", "Save if changed" },
	{ "<leader>Q", ":Sayonara!<CR>", "Force Quit" },
	{ "<leader>q", ":Sayonara<CR>", "Quit gracefully" },
	{ "<leader>w", "ZZ", "Save and quit" },
	{ "<leader>v", ":vsplit<CR>", "Open vertical split" },
	{ "<leader>x", ":split<CR>", "Open horizontal split" },
	{ "<leader>t", ":tabnew <CR>", "Open new tab" },
	{ "<C-'>", ":call FloatTerm()<CR>", "Open floating terminal" },
	{ "<", "<<", "Quick indent left" },
	{ ">", ">>", "Quick indent left" },
	{ "<leader>j", "o<ESC>k", "Insert line above" },
	{ "<leader>k", "O<ESC>j", "Insert line below" },
	{ "<leader>r", ":%s//g<Left><Left>", "Search and replace in file" },
	{ "<leader><CR>", ":nohls<CR>", "Clear highlights" },
	{ "gx", ":!open <cfile><CR>", "Open link under cursor" },
	{ "<leader>n", ":call CreateZettel()<CR>", "Create new file with link" },
	{ "gf", ":call GoToFile()<CR>", "Open file under cursor" },
	{ "z=", ":Telescope spell_suggest<CR>", "Open spell suggestions in Telescope" },
	{ "<leader>m", ":!music<CR>", "Start music player" },
}

local insert_mode_mappings = {
	{ "jk", "<Esc>", "Quick Escape" },
	{ "<C-e>", "<ESC>A", "Go to end of line" },
	{ "<C-a>", "<ESC>I", "Go to start of line" },
	{ "<C-'>", ":call FloatTerm()<CR>", "Open loading terminal" },
}

local visual_mode_mappings = {
	{ "j", "gj", "Scroll down by visual line" },
	{ "k", "gk", "Scroll ip by visual line" },
	{ "<leader>r", ":s//g<Left><Left>", "Search and replace in range" },
	{ "p", "P", "Paste before and don't copy if pasted over" },
	{ ";", ":", "Colon switch" },
	{ "<C-'>", ":call FloatTerm()<CR>", "Open loading terminal" },
}

local term_mode_mappings = {
	{ "<Esc>", [[<C-\><C-n>]], "Quick Escape" },
	{ "<C-[>", [[<C-\><C-n>]], "Quick Escape" },
}

local all_mappings = {
	n = normal_mode_mappings,
	i = insert_mode_mappings,
	v = visual_mode_mappings,
	t = term_mode_mappings,
}

for mode, mappings in pairs(all_mappings) do
	for _, m in ipairs(mappings) do
		local opts = vim.tbl_extend("force", { noremap = true, silent = true }, { desc = m[3], silent = m[4] })
		vim.api.nvim_set_keymap(mode, m[1], m[2], opts)
	end
end

-- Remap space as leader key and comma as localleader
vim.g.mapleader = " "
vim.g.maplocalleader = ","
