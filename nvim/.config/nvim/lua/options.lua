local set = vim.opt

-- Enables full color mode
set.termguicolors = true

-- Minimal UI
set.laststatus = 1
set.statusline = "%t"
set.ruler = false
set.showmode = false

-- No tabline, prefer terminal tabs instead
set.showtabline = 0

-- Enables mouse support for all modes
set.mouse = "a"

-- Natural splitting of windows
set.splitright = true
set.splitbelow = true

-- Hybrid number line
set.number = true
set.relativenumber = true

-- Case of normal letters in pattern is ignored unless capital
set.ignorecase = true
set.smartcase = true

-- Convert tabs to spaces, one tab = 2 spaces, one indent = 2 spaces
set.expandtab = true
set.tabstop = 2
set.shiftwidth = 2

-- Copy indent from previous line smartly
set.smartindent = true
set.autoindent = true

-- Allows closing buffer windows without needing to save first
set.hidden = true

-- Do not create backup or swapfiles
set.backup = false
set.swapfile = false
set.writebackup = false

-- Time after cursor no update after which to run autocmds
set.updatetime = 100

-- Always show sign column beside the number line
set.signcolumn = "yes"

-- Use system clipboard for yank and delete by default
set.clipboard = "unnamedplus"

-- Minimal number of screen lines to keep above and below the cursor.
set.scrolloff = 5
set.sidescrolloff = 5

-- Number of screen lines to use for the command-line.
set.cmdheight = 2

-- Height/Width of popup menu for completion items
set.pumheight = 10
set.pumwidth = 0

-- The screen will not be redrawn while executing macros, registers and other commands that have not been typed.
-- Also, updating the window title is postponed.
set.lazyredraw = true

-- Minimal number of columns to use for the line number.
set.numberwidth = 5

-- List mode on, with custom chars
set.list = true
set.listchars = {
	tab = "  ",
	trail = "·",
	extends = "»",
	precedes = "«",
}

-- Remove end of buffer ~, diff delted - and fold closed -
-- For some reason, table don't work
set.fcs = "eob: ,diff: ,fold: "

-- Insert mode completion.
set.completeopt = { "menu", "menuone", "noselect" }

-- Don't give long insert mode messages.
set.shortmess = "aosTwAIcFs"

-- Don't fold on high-levels on start.
set.foldlevel = 10

-- Wrap with line break
set.linebreak = true

-- Hide all that can be hidden
set.conceallevel = 2

-- Don't use shadafile
set.shadafile = "NONE"

-- Disable unused stiff
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_remote_plugins = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
