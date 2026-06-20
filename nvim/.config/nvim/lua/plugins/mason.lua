vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim", "require" } },
      workspace = { library = vim.api.nvim_get_runtime_file("", true) },
    },
  },
})

vim.lsp.config("pyright", {
  settings = {
    python = {
      pythonPath = (vim.fn.filereadable(".venv/bin/python") == 1) and (vim.fn.getcwd() .. "/.venv/bin/python")
          or vim.fn.exepath("python3"),
    },
  },
})

vim.lsp.config("gopls", {
  settings = {
    gofumpt = true,
    staticcheck = true,
  }
})

vim.lsp.enable({ "lua_ls", "pyright", "rust-analyzer", "gopls" })

vim.diagnostic.config({ virtual_text = false })

local mappings = {
  ["<localleader>g"] = ":lua vim.diagnostic.jump({ count = 1, severity=vim.diagnostic.severity.ERROR, wrap = true })<CR>",
  ["<localleader>d"] = "<cmd>lua vim.diagnostic.open_float()<CR>",
}

for key, map in pairs(mappings) do
  vim.api.nvim_set_keymap("n", key, map, { noremap = true, silent = true })
end

require("mason-lspconfig").setup()
