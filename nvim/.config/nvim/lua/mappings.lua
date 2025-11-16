local o = { noremap = true, silent = false }
local s = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap

-- Remap space as leader key and comma as localleader
map("n", "<SPACE>", "<NOP>", s)
map("n", ",", "<NOP>", s)
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Quick Escape
map("i", "jk", "<Esc>", s)

-- Remap j and k to scroll by visual lines
map("n", "j", "gj", s)
map("n", "k", "gk", s)
map("v", "j", "gj", s)
map("v", "k", "gk", s)

-- Quick line start/end in insert mode
map("i", "<C-e>", "<ESC>A", s)
map("i", "<C-a>", "<ESC>I", s)

-- Quick sentence start/end in normal mode
map("n", "0", "^", s)
map("n", "-", "g_", s)

-- Colon switch
map("n", ";", ":", o)
map("v", ";", ":", o)

-- Save and quit
map("n", "<leader>s", ":update<CR>", s) -- Save only
map("n", "<leader>Q", ":Sayonara!<CR>", s) -- Close buffer but keep window
map("n", "<leader>q", ":Sayonara<CR>", s) -- Close buffer and window
map("n", "<leader>w", "ZZ", s) -- Save and close buffer and window

-- Quick splits and tabs
map("n", "<leader>v", ":vsplit<CR>", s)
map("n", "<leader>x", ":split<CR>", s)
map("n", "<leader>t", ":tabnew <CR>", s)

-- Open floating terminal
map("n", "<C-'>", ":call FloatTerm()<CR>", s)
map("i", "<C-'>", ":call FloatTerm()<CR>", s)

-- Indents
map("n", "<", "<<", s)
map("n", ">", ">>", s)

-- Blank lines
map("n", "<leader>j", "o<ESC>k", s)
map("n", "<leader>k", "O<ESC>j", s)

-- Search and replace
map("n", "<leader>r", ":%s//g<Left><Left>", o)
map("v", "<leader>r", ":s//g<Left><Left>", o)

-- Clear search highlights
map("n", "<leader><CR>", ":nohls<CR>", s)

-- Inbuild terminal ESC normal mode
map("t", "<Esc>", [[<C-\><C-n>]], s)
map("t", "<C-[>", [[<C-\><C-n>]], s)

-- Open url under cursor into browser
map("n", "gx", ":!open <cfile><CR>", o)

-- Create a new zettel note
map("n", "<leader>n", ":call CreateZettel()<CR>", s)

-- Open path under cursor in vertical split
map("n", "gf", ":call GoToFile()<CR>", s)

-- Use telescope whenever possible for consistent flow
map("n", "z=", ":Telescope spell_suggest<CR>", s)

-- Do not copy deleted text in visual mode
-- I personally use it for replacing in already copied text
map("v", "p", "P", s)

-- Start music player
map("n", "<leader>m", ":!music<CR>", s)
