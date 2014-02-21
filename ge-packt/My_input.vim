" Vim personal plugin for debugging purposes
" Last Change:	2003 Dec 14
" Maintainer:	Reinhard Wobst <r.wobst@gmx.de>
" License:      This file is placed in the public domain.

"usage: cf. "vim ge-packt" (mitp), 5.8

function My_input(lcnt, ...)
  if a:lcnt
    return a:lcnt-1
  endif
  if a:0 > 0
    let i = 0
    while i < a:0
      echon a:{i+1} . " "
      let i = i+1
    endw
    echo ""
  endif
  return input("hit ENTER or enter number: ")
endf
