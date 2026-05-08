vim.cmd([=[
function! MyHighlights()
  highlight! Normal guibg=none

  highlight! StatusLine gui=bold guibg=none guifg=#6272A4
  highlight! StatusLineNC guibg=none guifg=#424450
  highlight! StatusLineTerm gui=bold guibg=none guifg=#6272A4
  highlight! StatusLineTermNC guibg=none guifg=#424450

  highlight! LineNr guifg=#6272A4
  highlight! LineNrAbove guifg=#424450
  highlight! LineNrBelow guifg=#424450

  highlight! Folded gui=bold guibg=NONE guifg=#6272A4
  highlight! SpecialKey guibg=NONE
  highlight! SignColumn guibg=NONE
  highlight! Todo gui=bold,italic guibg=NONE guifg=Purple
  highlight! Search guibg=#707070
  highlight! VertSplit gui=none guifg=#6272a4 guibg=black
  highlight! Trail guifg=#FF5555
  match Trail /\s\+$/

  highlight! link GitSignsAdd DraculaGreen
  highlight! link GitSignsChange DraculaYellow
  highlight! link GitSignsDelete DraculaRed
  highlight! link GitSignsChangeDelete DraculaOrange

  highlight! DiffAdd guibg=#254035 guifg=DraculaGreen gui=NONE
  highlight! DiffDelete guibg=#440000 guifg=DraculaRed gui=NONE
  highlight! DiffChange guibg=#292929 guifg=DraculaYellow gui=NONE
  highlight! DiffText guibg=None guifg=Normal gui=underline

  highlight! link NeogitDiffAdd DraculaGreen
  highlight! link NeogitDiffDelete DraculaRed
  highlight! link NeogitDiffChange DraculaYellow
  highlight! link NeogitDiffText Comment
  highlight! link NeogitDiffAddInline DraculaGreen
  highlight! link NeogitDiffDeleteInline DraculaRed
  highlight! link NeogitDiffChangeInline DraculaYellow
  highlight! link NeogitDiffTextInline Comment
  highlight! link NeogitHunkHeader Comment

  highlight! link DiagnosticHint white
  highlight! link DiagnosticInfo white
  highlight! link DiagnosticSignHint NonText
  highlight! link DiagnosticSignInfo NonText
  highlight! link DiagnosticVirtualTextHint NonText
  highlight! link DiagnosticVirtualTextInfo NonText
  highlight! link DiagnosticUnderlineHint NONE
  highlight! link DiagnosticUnderlineInfo NONE
  highlight! link DiagnosticUnderlineError NONE
  highlight! link DiagnosticUnderlineWarn NONE
  highlight! link LspDiagnosticsDefaultHint NonText
  highlight! link LspDiagnosticsDefaultInformation NonText
  highlight! link LspDiagnosticsUnderlineHint NONE
  highlight! link LspDiagnosticsUnderlineInformation NONE
  highlight! link LspDiagnosticsUnderlineError NONE
  highlight! link LspDiagnosticsUnderlineWarning NONE
endfunction
]=])
