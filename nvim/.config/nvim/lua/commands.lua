vim.cmd([=[

augroup CustomCmds
  autocmd!
  " Blink yanked text
  autocmd TextYankPost * silent! lua vim.hl.on_yank()

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

  " Hide the <!--gtask:abc123--> ids from tasks
   autocmd FileType markdown syntax match gtaskComment /<!--\s*gtask:[^>]*-->/ conceal

  " Sync Google Tasks on writing any file in ~/Notes dir
  autocmd BufWritePost ~/Notes/*.md :GtaskSync
augroup END
]=])
