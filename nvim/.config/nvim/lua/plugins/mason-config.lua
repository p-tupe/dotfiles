require("mason").setup()

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim", "require" } },
			workspace = { library = vim.api.nvim_get_runtime_file("", true) },
		},
	},
})

require("mason-lspconfig").setup()
vim.diagnostic.config({ virtual_text = false })
