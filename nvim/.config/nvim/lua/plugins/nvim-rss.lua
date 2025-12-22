local ok, rss = pcall(require, "nvim-rss")
if not ok then
	print("nvim-rss not loaded")
	return
end

rss.setup({ feeds_dir = "~/.config/nvim" })

vim.cmd('command! OpenRssView lua require("nvim-rss").open_feeds_tab()')

vim.api.nvim_create_autocmd("BufReadPost", {
	desc = "Fetch all feeds when nvim.rss is opened; Add mapping for Enter key",
	pattern = "*/nvim.rss",
	callback = function()
		require("nvim-rss").fetch_all_feeds()

		vim.keymap.set("n", "<CR>", function()
			require("nvim-rss").view_feed()
		end, { buffer = true, silent = true, noremap = true })
	end,
})
