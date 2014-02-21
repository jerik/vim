" Vim personal plugin for style checking - simple version (German)
" Last Change:	2003 Dec 14
" Maintainer:	Reinhard Wobst <r.wobst@gmx.de>
" License:      This file is placed in the public domain.

"usage: put it in $HOME/.vim/syntax/
"to use it, type ":set ft=sywdh"
"cf. "vim ge-packt" (mitp), 7.5.1

sy clear
set t_Co=16

hi doch ctermbg=Red ctermfg=White
hi ist ctermbg=Green ctermfg=Black
hi aber ctermbg=Yellow ctermfg=Black
hi wird ctermbg=DarkBlue ctermfg=White
hi kann ctermbg=Magenta ctermfg=White
hi da ctermbg=Black ctermfg=White
hi aller ctermbg=Brown ctermfg=Black
hi jede ctermbg=LightBlue ctermfg=Gray
"hi XXX ctermfg=8 ctermbg=5

sy case ignore
sy match doch /doch/
sy keyword ist  ist
sy keyword aber aber
sy match wird /\<w[ie]rd/
sy match kann /k[aoö]nn/
sy match da   /\<da\ze[s .]/
sy match aller /\<aller/
sy match jede /\<jede/
