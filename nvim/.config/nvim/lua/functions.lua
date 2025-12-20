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
  highlight! DiffAdd guibg=#254035 guifg=NONE gui=NONE
  highlight! DiffDelete guibg=#440000 guifg=NONE gui=NONE
  highlight! DiffChange guibg=#292929 guifg=NONE gui=NONE
  highlight! DiffText guibg=#252525 guifg=orange gui=underline

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

function! TermOptions()
  if exists('b:termOptionsSet')
    return
  endif

  " Do not show number line
  setlocal nonu nornu
  " No offset
  setlocal scrolloff=0 sidescrolloff=0
  " Increase scrollback
  setlocal scrollback=10000
  " Enable terminal insert mode
  execute "startinsert"

  let b:termOptionsSet = '1'
endfunction

" Clear cmdline function
function! EmptyCmdline(timer)
  if mode() ==# 'n'
    echon ''
  endif
endfunction

" Create a zettel/note
function! CreateZettel()
  " Get parent buffer name :t = tail, :r = root (w/o extension)
  " Buffer name is same as directory in which zettels will be stored
  let dir = expand("%:p:r")
  let rdir = expand("%:t:r")

  " Put line under cursor as title/file-name
  let cline = getline(".")
  let line = tolower(cline)
  let sub = substitute(line, " ", "-", "g") . ".md"

  let path =  dir . "/" . sub
  let link = "./" . rdir . "/" . sub

  if rdir == "index"
    let path =  "./" . sub
    let link = "./" . sub
  endif

  " Add markdown link to new zettel
  execute "normal! 0i- [$a](" . link . ")"

  " open new zettel in vertical split
  execute "vsp " . path

  " Add title
  execute "normal! i# " . cline

endfunction

function! GoToFile()
  let cwd = expand("%:p:h")
  let cfile = expand("<cfile>")

  if matchstr(cfile, "../") == "../"
    :execute 'vsplit' substitute(cfile, '..', expand("%:p:h:h"), '')
  elseif matchstr(cfile, "./") == "./"
    :execute 'vsplit' substitute(cfile, '.', cwd, '')
  endif
endfunction

" Create a small floating terminal window
" Credits: https://www.statox.fr/posts/2021/03/breaking_habits_floating_window/
function! FloatTerm() abort
    let width = 100
    let height = 30

    " Create the scratch buffer displayed in the floating window
    let buf = nvim_create_buf(v:false, v:true)

    " Get the current UI
    let ui = nvim_list_uis()[0]

    " Create the floating window
    let opts = {'relative': 'editor',
                \ 'width': width,
                \ 'height': height,
                \ 'col': (ui.width/2) - (width/2),
                \ 'row': (ui.height/2) - (height/2),
                \ 'anchor': 'NW',
                \ 'style': 'minimal',
                \ 'border': 'rounded',
                \ }

    let win = nvim_open_win(buf, 1, opts)

    :terminal
endfunction

]=])
