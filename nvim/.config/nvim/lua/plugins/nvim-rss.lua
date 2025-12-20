local ok, rss = pcall(require, "nvim-rss")
if not ok then
	print("nvim-rss not loaded")
	return
end

rss.setup({ feeds_dir = "~/.config/nvim" })

vim.cmd([[

  command! OpenRssView lua require("nvim-rss").open_feeds_tab()

  command! FetchFeed lua require("nvim-rss").fetch_feed()

  command! FetchAllFeeds lua require("nvim-rss").fetch_all_feeds()

  command! ViewFeed lua require("nvim-rss").view_feed()

  " Pressing "Enter" opens the feed under cursor
  autocmd! BufRead */nvim.rss noremap <buffer><silent><Enter> :lua require("nvim-rss").view_feed()<CR>

  " Fetch all feeds when nvim.rss is opened
  autocmd! BufRead */nvim.rss :lua require("nvim-rss").fetch_all_feeds()
]])
