-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
	return
end

lazy.setup({
	spec = {
		-- A dark theme
		{ "dracula/vim", name = "dracula" },

		-- Library of lua functions.
		{ "nvim-lua/plenary.nvim" },

		-- An implementation of the Popup API from vim in Neovim.
		{ "nvim-lua/popup.nvim" },

		-- Collection of common configurations for Neovim's built-in language server client.
		{ "neovim/nvim-lspconfig" },

		-- Easily install and manage LSP servers, DAP servers, linters, and formatters.
		{ "williamboman/mason.nvim" },

		-- mason-lspconfig bridges mason.nvim with the lspconfig plugin
		{ "williamboman/mason-lspconfig.nvim" },

		-- A highly extendable fuzzy finder over lists.
		{ "nvim-telescope/telescope.nvim" },

		-- fzf-native is a c port of fzf
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

		-- Wraps the Neovim treesitter API
		{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

		-- A completion engine plugin for neovim written in Lua.
		{
			"hrsh7th/nvim-cmp",
			dependencies = {
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-cmdline",
				"ray-x/cmp-treesitter",
				"saadparwaiz1/cmp_luasnip",
			},
		},

		-- A file system explorer for the Vim editor.
		{ "kyazdani42/nvim-tree.lua", dependencies = { "kyazdani42/nvim-web-devicons" } },

		-- Provides mappings to easily delete, change and add such surroundings in pairs.
		{ "tpope/vim-surround" },

		-- Smart and Powerful commenting plugin for neovim
		{ "numToStr/Comment.nvim" },

		-- A minimalist autopairs for Neovim written by Lua.
		{ "windwp/nvim-autopairs" },

		-- Git signs written in pure lua.
		{ "lewis6991/gitsigns.nvim" },

		-- Snippet engine in LUA
		{
			"L3MON4D3/LuaSnip",
			build = "make install_jsregexp",
		},
		{ "rafamadriz/friendly-snippets" },

		-- navigate seamlessly between vim and kitty splits
		{ "knubie/vim-kitty-navigator", build = "cp ./*.py ~/.config/kitty" },

		-- This (neo)vim plugin makes scrolling nice and smooth.
		{ "psliwka/vim-smoothie" },

		-- Distraction-free writing for Neovim.
		{ "folke/zen-mode.nvim" },

		-- A (Neo)vim plugin for formatting code.
		{ "sbdchd/neoformat", cmd = "Neoformat" },

		-- Provides a single command that deletes the current buffer in a smart way.
		{ "mhinz/vim-sayonara", cmd = "Sayonara" },

		-- Git plugin
		{ "NeogitOrg/neogit", dependencies = { "sindrets/diffview.nvim" } },

		-- Codeim AI code helper
		{ "Exafunction/codeium.nvim" },
	},

	install = { colorscheme = { "dracula" } },
})

require("codeium").setup({})

require("mason").setup({})

require("Comment").setup()

require("plugins.telescope")

require("plugins.treesitter")

require("plugins.mason-config")

require("plugins.cmp")

require("plugins.gitsigns")

require("plugins.nvim-autopairs")

require("plugins.neoformat")

require("plugins.nvim-tree")

require("plugins.zen-mode")

require("plugins.neogit")

require("luasnip.loaders.from_vscode").lazy_load()

-- require "plugins.nvim-rss" -- Uncomment when using github uri

-- Tools
-- npm i -g neovim
-- pip install pynvim
