vim.cmd([=[

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
