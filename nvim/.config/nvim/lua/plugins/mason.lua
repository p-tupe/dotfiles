local lsp_servers = {
  "astro",
  "lua_ls",
  "dmypy",
  "golangci_lint_ls",
  "ts_ls",
  "eslint",
  "tailwindcss",
  "cssls",
  "html",
  "jsonls",
  "svelte",
  "ruff",
  "zls",
  "ocamllsp",
  "nim_langserver"
  -- "rust_analyzer", -- using rustaceanim
  -- "gopls", -- using golangci_lint_ls
}

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

vim.lsp.config('golangci_lint_ls', {
  cmd = { 'golangci-lint-langserver' },
  root_markers = { '.git', 'go.mod' },
  init_options = {
    command = {
      'golangci-lint', 'run',
      '--output.json.path', 'stdout',
      '--show-stats=false', '--issues-exit-code=1'
    },
  },
})

---@type rustaceanvim.Opts
vim.g.rustaceanvim = {
  ---@type rustaceanvim.tools.Opts
  tools = {
    enable_clippy = true,
  },
  ---@type rustaceanvim.lsp.ClientOpts
  server = {
    status_notify_level = false,
  }
}

vim.lsp.config('nim_langserver', {
  -- It's erroring out on completions, disable them
  on_attach = function(c) c.server_capabilities.completionProvider = nil end,
  settings = {
    nim = {
      nimsuggestIdleTimeout = 86400000,
      notificationVerbosity = "none"
    }
  }
})

vim.diagnostic.config({ virtual_text = false })

require("mason-lspconfig").setup({ automatic_enable = lsp_servers })
