-- vim.g.neoformat_enabled_python = { 'ruff' }
-- vim.g.neoformat_enabled_go = { 'goimports' }
vim.g.neoformat_enabled_markdown = { 'prettierd' }
vim.g.neoformat_enabled_xml = { 'xmllint' }
-- vim.g.neoformat_enabled_ocaml = { 'ocamlformat', 'ocpindent' }
-- vim.g.neoformat_enabled_nim = { 'nimpretty' }
-- vim.g.neoformat_enabled_html = { 'prettierd' }
-- vim.g.neoformat_enabled_css = { 'prettierd' }
-- vim.g.neoformat_enabled_sh = { 'shfmt' }
--
-- local ext_to_lang = {
--   py = "python",
--   lua = "lua",
--   rs = "rust",
--   go = "go",
--   sql = "sql",
--   md = "markdown",
--   plist = "xml",
--   xml = "xml",
--   ml = "ocaml",
--   nim = "nim",
--   html = "html",
--   css = "css",
--   sh = "sh"
-- }

local function format()
  if #vim.lsp.get_clients({ bufnr = 0, method = "textDocument/formatting" }) > 0 then
    vim.lsp.buf.format({ async = true })
  else
    vim.cmd("Neoformat")
  end
end

--  Look for a formatter executable in the node_modules/.bin directory
vim.g.neoformat_try_node_exe = 1

-- Enable alignment
vim.g.neoformat_basic_format_align = 1

-- Enable tab to spaces conversion
vim.g.neoformat_basic_format_retab = 1

-- Enable trimmming of trailing whitespace
vim.g.neoformat_basic_format_trim = 1

-- Only msg when there is an error
vim.g.neoformat_only_msg_on_error = 1

vim.keymap.set("n", "<leader>p", format, { desc = "Format buf with Neoformat or lsp", silent = true, noremap = true })
vim.keymap.set("v", "<leader>p", ":'<,'>format<CR>", { noremap = true, silent = true })
