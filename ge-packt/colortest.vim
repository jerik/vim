" Vim script for testing colorschemes
" Last Change:	2003 Dec 14
" Maintainer:	Reinhard Wobst <r.wobst@gmx.de>
" License:      This file is placed in the public domain.

"usage: start as ":source colortest.vim"

let a='cd ' . $VIMRUNTIME . '/colors; ls *.vim | ' .
   \ 'sed -e "s/\([a-z]*\)\.vim/' .
   \ 'hi clear|colorscheme \1|redraw|' .
   \ 'call input(\"this is \1, press ENTER\")/"'
exe system(a)
