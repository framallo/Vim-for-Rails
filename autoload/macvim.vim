if has("gui_macvim")
  map <D-d> :NERDTreeToggle<cr>
  map <D-D> :NERDTreeFind<cr>
  map <D-r> :FufFile **/<cr>
endif

function! HandleURI()
  let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;:]*')
  echo s:uri
  if s:uri != ""
	  exec "!open \"" . s:uri . "\""
  else
	  echo "No URI found in line."
  endif
endfunction
map <Leader>w :call HandleURI()<CR>

