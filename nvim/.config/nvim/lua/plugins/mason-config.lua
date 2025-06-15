local servers = {
	"astro",
	"bashls",
	"cssls",
	"dockerls",
	"elixirls",
	"html",
	"jsonls",
	"lua_ls",
	"pylsp",
	"ts_ls",
	"vimls",
	"yamlls",
	"gopls",
	"docker_compose_language_service",
	"taplo",
}

require("mason-lspconfig")

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

local function on_attach(_, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	local opts = { noremap = true, silent = true }

	buf_set_keymap("n", "grr", "<cmd>Telescope lsp_references<CR>", opts)
	buf_set_keymap("n", "gri", "<cmd>Telescope lsp_implementation<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
	buf_set_keymap("n", "gO", "<Cmd>Telescope lsp_document_symbols<CR>", opts)
	buf_set_keymap("n", "<localleader>d", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
end

local lspconfig = require("lspconfig")

-- Extra config for some servers
local enhance_server_opts = {

	["lua_ls"] = function(opts)
		opts.settings = {
			Lua = {
				runtime = { version = "LuaJIT" },
				diagnostics = { globals = { "vim", "describe", "it" } },
				workspace = { library = vim.api.nvim_get_runtime_file("", true) },
				telemetry = { enable = false },
			},
		}
	end,

	["pylsp"] = function(opts)
		opts.settings = {
			configurationSources = { "ruff" },
			formatCommand = { "black" },
			pylsp = { plugins = { pycodestyle = { enabled = true, ignore = { "E501", "E231" }, maxLineLength = 90 } } },
		}
	end,

	["ltex"] = function(opts)
		-- this is like the grammarly thingy
		opts.filetypes = { "markdown", "text", "latex" }
	end,

	["sourcekit"] = function(opts)
		opts.single_file_support = true
	end,

	["kotlin_language_server"] = function(opts)
		opts.single_file_support = true
	end,
}

for _, name in pairs(servers) do
	local opts = { on_attach = on_attach, capabilities = capabilities }

	if enhance_server_opts[name] then
		enhance_server_opts[name](opts)
	end

	lspconfig[name].setup(opts)
end

-- Does not show the diagnostics in buffer (use mapping <localleader>d instead)
vim.diagnostic.config({ virtual_text = false })

--[[
    Installed
        clangd
        yaml-language-server yamlls
        sql-formatter
        lua-language-server lua_ls
        shfmt
        bash-language-server bashls
        black
        cpplint
        css-lsp cssls
        docker-compose-language-service docker_compose_language_service
        dockerfile-language-server dockerls
        goimports
        gopls
        html-lsp html
        json-lsp jsonls
        marksman
        prettierd
        python-lsp-server pylsp
        sqlls
        stylua
        taplo
        typescript-language-server ts_ls
  ]]
