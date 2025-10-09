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

-- Register the mdx filetype
vim.filetype.add({ extension = { mdx = "mdx" } })

-- Configure treesitter to use the markdown parser for mdx files
vim.treesitter.language.register("markdown", "mdx")

-- If the current buffer has the extension mdx, but not the newly create filetype, set it
if vim.endswith(vim.api.nvim_buf_get_name(0), ".mdx") and vim.o.filetype ~= "mdx" then
	vim.o.filetype = "mdx"
end

-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
