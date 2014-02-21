" Vim personal plugin for C source folding
" Last Change:	2003 Dec 14
" Maintainer:	Reinhard Wobst <r.wobst@gmx.de>
" License:      This file is placed in the public domain.

"usage: put it in $HOME/.vim/myscripts/ and use script "vic"!
"cf. "vim ge-packt" (mitp), 7.9

set cindent
set cino=f2,>3,{2,=2,l2,g3,h2,p2,+3,(0,:3
if(&ft != 'c' && &ft != 'cpp')
  let &ft='c'
endif

syn region cMyBrace transparent fold start=/{/ end=/}/
	\ containedin=ALLBUT,cString,cComment,cCharacter,cMyPreproc

syn region cMyString start=/L\="/ skip=/\\\\\|\\"/ end=/"/
	\ transparent keepend contains=ALL

syn region cMyPreproc start=/^\s*#/ skip=/\\$/ end=/$/
	\ transparent keepend contains=ALL

set foldmethod=syntax
normal zi
