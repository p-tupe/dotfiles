-- https://github.com/p-tupe/gtask.nvim

require("gtask").setup({
	markdown_dir = "~/Notes",
	ignore_patterns = { "code-notes", "archive", "idea-board.md", "objectives.md" },
	-- verbosity = "info",
})
