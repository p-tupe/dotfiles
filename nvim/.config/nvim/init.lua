require("options")

require("mappings")

require("plugins")

require("functions")

require("commands")

-- vim.g.node_host_prog = "~/.local/npm/lib/node_modules/neovim/bin/cli.js"
-- vim.g.python3_host_prog = "/opt/homebrew/opt/python@3.12/libexec/bin/python"
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.cmd("colorscheme dracula")
