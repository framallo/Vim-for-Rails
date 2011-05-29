" fossil.vim - A fossil wrapper that is shameless, cute and sexy
" Maintainer:   Federico RAmallo <framallo@gmail.com>
" Version:      0.1
"

if exists('g:loaded_fossil') || &cp
  finish
endif
let g:loaded_fossil = 1

" Setting up commands

command -nargs=0  Fdiff  :call s:FossilSDiff()
command -nargs=0  Fvdiff  :call s:FossilVDiff()

function s:createScratch() abort
  :enew
  :setlocal buftype=nofile
  :setlocal bufhidden=hide
  :setlocal noswapfile
endfunction

function s:FossilVDiff() abort
  :vsplit
  call s:FossilDiff()
endfunction

function s:FossilSDiff() abort
  :split
  call s:FossilDiff()
endfunction

function s:FossilDiff() abort
  call s:createScratch()
  :set ft=diff
  :silent r ! fossil diff
endfunction


