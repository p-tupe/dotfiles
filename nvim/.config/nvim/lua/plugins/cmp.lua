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

cmp.setup({
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

		-- If prompt visible
		--    If only one entry -> confirm it
		--    Else -> select next entry
		-- Else -> fallback to default
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				if #cmp.get_entries() == 1 then
					cmp.confirm({ select = true })
				else
					cmp.select_next_item()
				end
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				if #cmp.get_entries() == 1 then
					cmp.confirm({ select = true })
				else
					cmp.select_prev_item()
				end
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
		{ name = "nvim_lsp" },
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
