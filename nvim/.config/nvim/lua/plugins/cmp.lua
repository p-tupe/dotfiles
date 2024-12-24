local cmp = require("cmp")

if cmp == nil then
	return
end

local kind_icons = {
	Text = " ",
	Method = "m",
	Function = "󰊕",
	Constructor = " ",
	Field = " ",
	Variable = "󰫧 ",
	Class = " ",
	Interface = " ",
	Module = " ",
	Property = " ",
	Unit = " ",
	Value = " ",
	Enum = " ",
	Keyword = " ",
	Snippet = " ",
	Color = " ",
	File = " ",
	Reference = " ",
	Folder = " ",
	EnumMember = " ",
	Constant = "π",
	Struct = " ",
	Event = "",
	Operator = " ",
	TypeParameter = " ",
	Codeium = " ",
}

local luasnip = require("luasnip")

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	performance = {
		max_view_entries = 10,
	},
	completion = { keyword_length = 2 },
	experimental = { ghost_text = true },
	window = { completion = cmp.config.window.bordered(), documentation = cmp.config.window.bordered() },
	mapping = cmp.mapping.preset.insert({
		["<C-d>"] = cmp.mapping.scroll_docs(-1),
		["<C-u>"] = cmp.mapping.scroll_docs(1),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	formatting = {
		fields = { "abbr", "kind" },
		format = function(_, vim_item)
			vim_item.kind = string.format("%s", kind_icons[vim_item.kind] or "")
			return vim_item
		end,
	},
	-- Each {} is one group, when present excludes other
	sources = cmp.config.sources({
		{ name = "codeium", max_item_count = 3 },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "path" },
	}, { { name = "buffer" } }),
})

-- Use cmdline & path source for ':'
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
})

cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})
