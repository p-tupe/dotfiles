-- Do :TSUpdate on change
require("nvim-treesitter").setup({
	install_dir = vim.fn.stdpath("data") .. "/site",
})

-- Register the mdx filetype
vim.filetype.add({ extension = { mdx = "mdx" } })

-- Configure treesitter to use the markdown parser for mdx files
vim.treesitter.language.register("markdown", "mdx")

-- If the current buffer has the extension mdx, but not the newly create filetype, set it
if vim.endswith(vim.api.nvim_buf_get_name(0), ".mdx") and vim.o.filetype ~= "mdx" then
	vim.o.filetype = "mdx"
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "*" },
	callback = function(args)
		local ft = vim.bo[args.buf].filetype
		local lang = vim.treesitter.language.get_lang(ft)

		if not lang then
			return
		end

		if not vim.treesitter.language.add(lang) then
			local available = vim.g.ts_available or require("nvim-treesitter").get_available()
			if not vim.g.ts_available then
				vim.g.ts_available = available
			end
			if vim.tbl_contains(available, lang) then
				require("nvim-treesitter").install(lang)
			end
		end

		if vim.treesitter.language.add(lang) then
			vim.treesitter.start(args.buf, lang)
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
			vim.wo[0][0].foldmethod = "expr"
		end
	end,
})
