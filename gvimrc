" -----------------------------------------------------------------------------  
" |                            VIM Settings                                   |
" |                              GUI stuff                                    |
" -----------------------------------------------------------------------------  


" Default size of window
set columns=120 
set lines=50

" OS Specific *****************************************************************
if has("gui_macvim")

  set fuoptions=maxvert,maxhorz " fullscreen options (MacVim only), resized window when changed to fullscreen
  set guifont=Monaci:h13 
  set guioptions-=T  " remove toolbar
  set stal=2 " turn on tabs by default
  set guioptions+=c " remove mac dialogs or Ctrl+F7 toggles keyboard dialog navigation
elseif has("gui_gtk2")
  set guifont=Monaco
  set guioptions-=T  " remove toolbar
elseif has("x11")
elseif has("gui_win32")
end

" General *********************************************************************
set anti " Antialias font

"set transparency=0

" Tab headings 
set gtl=%t gtt=%F

" gedim plugin
" 1440x900: MacBookPro 15"
" 1280x800: MacBookPro 13"
let g:screenDimensions = { '1920,1080': [ 145, 77 ], '1280,800': [ 207,60 ], 'default' :[50,50] }
