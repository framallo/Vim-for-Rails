" ReloadScript.vim: Reload a VIM script during script development. 
"
" DESCRIPTION:
"   Re-sources a VIM script. The script may use a multiple inclusion guard
"   variable g:loaded_<scriptname> (with <scriptname> having either the same
"   case as specified or all lowercase.) 
"   If you specify the bare scriptname (without .vim extension), the script must
"   reside in $VIMRUNTIME/plugin/<scriptname>.vim. Otherwise, the passed
"   filespec is interpreted as the file system location of a VIM script and
"   sourced as-is. 
"   If you execute :ReloadScript without passing a scriptname, the current
"   buffer is re-sourced. 
"
" USAGE:
"   :ReloadScript			Re-sources the current buffer. 
"   :ReloadScript <scriptname>		Re-sources the passed plugin script. 
"   :ReloadScript <path/to/script.vim>	Re-sources the passed file. 
"
" INSTALLATION:
"   Put the script into your user or system VIM plugin directory (e.g.
"   ~/.vim/plugin). 
"
" DEPENDENCIES:
"   - Requires VIM 7.0 or higher. 
"
" CONFIGURATION:
"
" LIMITATIONS:
"   - The script cannot reload itself :-)
"
" ASSUMPTIONS:
"   Not every script supports reloading. There may be error messages like
"   "function already exists". To support reloading, the script should use the
"   bang (!) variants of :function! and :command!, which will automatically
"   override already existing elements. 
"
"   Ensure that the script uses a multiple inclusion guard variable that
"   conforms to the conventions mentioned above. The :ReloadScript command will
"   issue a warning if it cannot find the inclusion guard variable. 
"
" TODO:
"   - For compiler, ftplugin, indent and syntax scripts, find all buffers that
"     have the script sourced and re-source in that buffer. Currently, one must
"     manually :e! these buffers. 
"
" Copyright: (C) 2007-2008 by Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'. 
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
" REVISION	DATE		REMARKS 
"   1.10.005	25-Jul-2008	Combined missing inclusion guard warning with
"				reload message to avoid the "Hit ENTER" prompt. 
"				No missing inclusion guard warning for scripts
"				that do not need one (e.g. after-directory,
"				autoload, ftplugin, indent, syntax, ...)
"   1.10.004	28-Feb-2008	A scriptname argument with path and/or extension
"				is sourced as-is. This allows a third usage:
"				:ReloadScript <path/to/script.vim>
"   1.00.003	22-May-2007	Added documentation. 
"	002	02-Apr-2007	Inclusion guard variable can have the same case
"				as the script name or be all lowercase. 
"	0.01	14-Dec-2006	file creation

" Avoid installing twice or when in compatible mode
if exists('g:loaded_ReloadScript') || (v:version < 700)
    finish
endif
let g:loaded_ReloadScript = 1

function! s:RemoveInclusionGuard( scriptName )
    let l:scriptInclusionGuard = 'g:loaded_' . a:scriptName
    if ! exists( l:scriptInclusionGuard )
	let l:scriptInclusionGuard = 'g:loaded_' . tolower(a:scriptName)
    endif
    if exists( l:scriptInclusionGuard )
	execute 'unlet ' . l:scriptInclusionGuard
	return 1
    else
	return 0
    endif
endfunction

let s:noGlobalInclusionGuardPattern = '^\%(autoload\|colors\|compiler\|ftplugin\|indent\|keymap\|lang\|syntax\)$'
function! s:IsScriptTypeWithInclusionGuard( scriptFileSpec )
    " Scripts that only modify the current buffer do not have a global inclusion
    " guard (but should have a buffer-local one). 
    " Autoload, color scheme, keymap and language scripts do not need an
    " inclusion guard. 
    " Scripts in the after-directory do not need an inclusion guard. 
    let l:scriptDir = fnamemodify( a:scriptFileSpec, ':p:h:t' )
    " Because VIM supports both .vim/ftplugin/filetype_*.vim and
    " .vim/ftplugin/filetype/*.vim, we need to check the two directories
    " upwards. 
    let l:scriptParentDir = fnamemodify( a:scriptFileSpec, ':p:h:h:t' )
    let l:scriptParentParentDir = fnamemodify( a:scriptFileSpec, ':p:h:h:h:t' )

    return ! (l:scriptDir =~? s:noGlobalInclusionGuardPattern || l:scriptParentDir =~? s:noGlobalInclusionGuardPattern || l:scriptParentDir =~? '^after$' || l:scriptParentParentDir =~? '^after$')
endfunction

function! s:ReloadScript(...)
    if a:0 == 0
	" Note: We do not check whether the current buffer contains a VIM
	" script; :source will tell. 
	let l:scriptName = expand('%:t:r')
	let l:scriptFilespec = expand('%')
	let l:sourceCommand = 'source'
	let l:canContainInclusionGuard = s:IsScriptTypeWithInclusionGuard(l:scriptFilespec)
    else
	let l:scriptName = fnamemodify( a:1, ':t:r' ) " Strip off file path and extension. 
	if l:scriptName == a:1
	    " A bare scriptname has been passed. 
	    let l:scriptFilespec = 'plugin/' . l:scriptName . '.vim'
	    let l:sourceCommand = 'runtime'
	    " Note: the :runtime command does not complain if no script was found. 
	else
	    " We assume the passed filespec represents an existing VIM script
	    " somewhere on the file system. 
	    let l:scriptFilespec = a:1
	    let l:sourceCommand = 'source'
	endif
	let l:canContainInclusionGuard = 1
    endif

    let l:isRemovedInclusionGuard = s:RemoveInclusionGuard( l:scriptName )

    execute l:sourceCommand . ' ' . l:scriptFilespec
    if ! l:canContainInclusionGuard || l:isRemovedInclusionGuard
	echomsg 'Reloaded "' . l:scriptFilespec . '"'
    else
	echohl WarningMsg
	echomsg 'Reloaded "' . l:scriptFilespec . '"; no inclusion guard variable found.'
	echohl None
    endif
endfunction

"command! -nargs=1 -complete=file ReloadScript if exists("g:loaded_<args>") | unlet g:loaded_<args> | endif | runtime plugin/<args>.vim
command! -nargs=? -complete=file ReloadScript call <SID>ReloadScript(<f-args>)

" vim: set sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
