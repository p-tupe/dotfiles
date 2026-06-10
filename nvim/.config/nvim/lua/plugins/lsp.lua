local lsp_servers = {
  'lua_ls', --  lua-language-server
  'gopls',
  'ts_ls', -- typescript-language-server
  'pyright',
}

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = { globals = { 'vim' } },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          '${3rd}/luv/library',
        },
      },
      telemetry = { enable = false },
    },
  },
})


vim.lsp.config('gopls', {
  settings = {
    gopls = {
      staticcheck = true,
      gofumpt = true,
      usePlaceholders = true,
    },
  },
})

vim.lsp.config('ts_ls', {
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
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

vim.lsp.enable(lsp_servers)
