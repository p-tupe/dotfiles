-- Do :TSUpdate on change
require("nvim-treesitter.configs").setup({
	modules = {},
	ensure_installed = {},
	ignore_install = {},
	sync_install = false,
	highlight = { enable = true },
	indent = { enable = true, disable = { "python", "yaml" } },
	auto_install = true,
})

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
