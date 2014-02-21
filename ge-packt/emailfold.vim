" Vim personal plugin for folding email files
" Last Change:	2003 Dec 14
" Maintainer:	Reinhard Wobst <r.wobst@gmx.de>
" License:      This file is placed in the public domain.

"usage: for demonstration purposes, can be loaded by ":source"
"cf. "vim ge-packt" (mitp), 6.5.2

function! Fold_email_expression(lnum)
  let a = getline(a:lnum)
  let a = substitute(a, " ", "", "g")
  let b = match(a, "[^>]")
  return b < 0 ? 0 : b
endfunction

set foldexpr=Fold_email_expression(v:lnum)
set foldmethod=expr
