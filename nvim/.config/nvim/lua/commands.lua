vim.cmd([=[

augroup CustomCmds
  autocmd!
  " Blink yanked text
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()

  " Set custom highlights
  autocmd ColorScheme * call MyHighlights()

  " Set custom terminal options on open
  autocmd TermOpen * call TermOptions()

  " Clear commandline after 2 seconds
  autocmd CmdlineLeave : call timer_start(2000, funcref('EmptyCmdline'))

  " Disable nvim-cmp on the specific buffer
  autocmd FileType TelescopePrompt lua require('cmp').setup.buffer { enabled = false }

  " Create note mapping only if markdown
  autocmd FileType markdown noremap <buffer><silent><leader>n :call CreateZettel()<CR>
augroup END

command! -nargs=1 CreateZettelHub :call CreateZettelHub(<args>)

]=])

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = vim.fn.expand("~/Notes") .. "/*.md",
	callback = function()
		vim.cmd(":GtaskSync")
	end,
})
