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

local mappings = {
	["<localleader>g"] = ":lua vim.diagnostic.goto_next({ severity=vim.diagnostic.severity.ERROR, wrap = true })<CR>",
	["grr"] = "<cmd>Telescope lsp_references<CR>",
	["gri"] = "<cmd>Telescope lsp_implementation<CR>",
	["gd"] = "<cmd>Telescope lsp_definitions<CR>",
	["gO"] = "<Cmd>Telescope lsp_document_symbols<CR>",
	["<localleader>d"] = "<cmd>lua vim.diagnostic.open_float()<CR>",
}

for key, map in pairs(mappings) do
	vim.api.nvim_set_keymap("n", key, map, { noremap = true, silent = true })
end
