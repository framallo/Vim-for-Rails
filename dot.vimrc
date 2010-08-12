if has("gui_macvim")
  map <D-d> :NERDTreeToggle<cr>
  map <D-D> :NERDTreeFind<cr>
  map <D-r> :FufFile **/<cr>
endif

func GitGrep(...)
  let save = &grepprg
  set grepprg=git\ grep\ -n\ $*
  let s = 'grep'
  for i in a:000
    let s = s . ' ' . i
  endfor
  exe s
  let &grepprg = save
endfun
command -nargs=? G call GitGrep(<f-args>)


