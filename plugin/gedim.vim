" MacVim automatic editor resizing script.

" Copyright (c) 2010, Eugene Ciurana (pr3d4t0r)
" All rights reserved.
"
" Redistribution and use in source and binary forms, with or without
" modification, are permitted provided that the following conditions are met:
"     * Redistributions of source code must retain the above copyright
"       notice, this list of conditions, the URL http://eugeneciurana.com/paster.vim,
"       and the following disclaimer.
"     * Redistributions in binary form must reproduce the above copyright
"       notice, this list of conditions, the URL http://eugeneciurana.com/paster.vim,
"       and the following disclaimer in the documentation and/or other materials
"       provided with the distribution.
"     * Neither the name Eugene Ciurana, nor pr3d4t0r, nor the
"       names of its contributors may be used to endorse or promote products
"       derived from this software without specific prior written permission.
"
" THIS SOFTWARE IS PROVIDED BY EUGENE CIURANA ''AS IS'' AND ANY
" EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
" WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
" DISCLAIMED. IN NO EVENT SHALL EUGENE CIURANA BE LIABLE FOR ANY
" DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
" (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
" LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
" ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
" (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
" SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
"
"
" CONTRIBUTOR           EMAIL                         IRC /NICK
" ----------            -----                         ---------
" Eugene Ciurana        http://ciurana.eu/contact     pr3d4t0r
" Scott Balmos          sbalmos@fastmail.fm           [TechGuy]
" Nathan Tenney         ntenney@gmail.com
"
" Special thanks to jamessan, spline, dmlloyd, bairu, graywh, and other denizens of the
" #vim, ##mac, and other channels (irc://irc.freenode.net/#vim).
"
"
" Version history:
" ----------------
" 20100811              1.1  Initial public release.
" 20100813              1.1b Fixed Windows detection bug based on EOL (\r\n) - by Nathan Tenney

function! GEditorDimensions()
  " Set nColumns, nRows to some reasonable default for your screen.

  let nColumns = 128
  let nLines   = 40

  " Set default values to your liking here.  The key is the screen resolution
  " that the systemProfiler reports.  The value is the [columns, lines] to which
  " you'd like to set MacVim.
  "
  " NOTICE:  You *must* set these values to the ones that you like/want!  These
  " are set up for the author's personal configuration as an example.
  "
  " The best places to set these up is in .vimrc or .gvimrc - thanks!

  if !exists("g:screenDimensions")
    let g:screenDimensions = { '1920,1080': [ 200, 40 ], '1440,900': [ 160, 24 ] }
  endif

  " Identify host OS and GUI and set executable, resolution:
  let rez = "None"
  if has("gui_win32")
    " NEEDS ADDITIONAL TESTING BY A KIND WINDOWS USER!
    let executable   = "wmic desktopmonitor get screenheight, screenwidth /format:csv | find \",\" | find /V \"ScreenHeight\""
    let output       = system(executable)
    let items        = split(split(output, "\r\n")[0], ",")
    let g:rezWindows = items[2].",".items[1]
    let rez          = g:rezWindows
  endif
  if has("gui_gtk")
    let executable = "/usr/bin/xrandr | awk '/Screen 0/ { printf(\"%d,%d\", $8, $10); exit(0); }'"
    let rez        = system(executable)
  endif
  if has("gui_macvim")
    let executable = "/usr/sbin/system_profiler | awk '/Resolution:/ { printf(\"%d,%d\", $2, $4); exit(0); }'"
    let rez        = system(executable)
  endif
  if has("gui_mac")
    let executable = "/usr/sbin/system_profiler | awk '/Resolution:/ { printf(\"%d,%d\", $2, $4); exit(0); }'"
    let rez        = system(executable)
  endif

  if rez != "None"
    if has_key(g:screenDimensions, rez)
      let nColumns = g:screenDimensions[rez][0]
      let nLines   = g:screenDimensions[rez][1]
    endif

    let &columns=nColumns
    let &lines=nLines
  endif
endfunction

autocmd GUIEnter * call GEditorDimensions()

