" Vim personal plugin for style improvement
" Last Change:	2003 Dec 14
" Maintainer:	Reinhard Wobst <r.wobst@gmx.de>
" License:      This file is placed in the public domain.

"usage: put it together with wdh (can be edited, to your language and
"your personal weaknesses :-) in $HOME/.vim/plugin/
"typing ":Style" activated the feature, then press F4 and look for the
"first pattern, press F4 again etc. until a green "READY" appears in
"the status line
"cf. "vim ge-packt" (mitp), 7.5.2

function! s:Init(...)
  if a:0 | let s:fn=a:1 | else | let s:fn='wdh' | endif
  let s:fn=$HOME . '/.vim/plugin/' . s:fn

  if !filereadable(s:fn)
    echoerr '----> file "' . s:fn . '" is not readable!'
    return
  endif

  let s:cnt=0
  map <F4> :call <SID>Do_search()<CR>
endf

function! s:Do_search()
  if !s:cnt
    let s:oso=&sessionoptions
    let &sessionoptions='options' | mkview
    highlight Search cterm=bold ctermfg=7 ctermbg=Red
    let &wrapscan=0 | let &hlsearch=1 | let &ignorecase=1
    let &scrolloff=3 | let s:cnt=1
  endif

  let pat=system('tail +' . s:cnt . ' ' . s:fn . '|head -1')

  if !strlen(pat)
    "end of file reached, restore and quit
    let s:cnt=0
    echohl Question
    echon '******************** READY ********************'
    set all& | loadview | let &sessionoptions=s:oso
    return
  endif

  let @/=substitute(pat, "\n", '', '')
  1
  try
    normal n
    catch
  endtry
  redraw
  let s:cnt=s:cnt+1
endf

command! -nargs=? Style call <SID>Init(<f-args>)
