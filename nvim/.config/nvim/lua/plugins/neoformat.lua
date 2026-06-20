vim.g.neoformat_enabled_python = { 'ruff' }
vim.g.neoformat_enabled_go = { 'goimports' }

local ext_to_lang = {
  py = "python",
  lua = "lua",
  rs = "rust",
  go = "go"
}

local function format()
  local buf = vim.api.nvim_get_current_buf()
  local name = vim.api.nvim_buf_get_name(buf)
  local ext = name:match("%.(%w+)$")
  local lang = ext_to_lang[ext]
  if lang then
    local key = "neoformat_enabled_" .. lang
    if vim.g[key] then
      vim.cmd("Neoformat")
      return
    end
  end
  vim.lsp.buf.format()
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


vim.keymap.set('n', '<leader>p', format, { desc = "Format buf with Neoformat or ls", silent = true, noremap = true })
-- vim.api.nvim_set_keymap("n", "<leader>p", ":format<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("v", "<leader>p", ":'<,'>format<CR>", { noremap = true, silent = true })
