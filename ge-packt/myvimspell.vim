" Vim personal plugin for spellchecking
" Last Change:	2003 Dec 14
" Maintainer:	Reinhard Wobst <r.wobst@gmx.de>
" License:      This file is placed in the public domain.

"usage: put it in $HOME/.vim/myscripts and use the "visp" script!
"cf. "vim ge-packt" (mitp), 7.6

nmap <Esc>s  <Plug>SpellCheck
nmap <Esc>A  <Plug>SpellAutoEnable
nmap <Esc>?  <Plug>SpellProposeAlternatives
nmap <Esc>l  <Plug>SpellChangeLanguage
nmap <Esc>q  <Plug>SpellAutoDisable

so $HOME/.vim/myscripts/vimspell.vim

let spell_case_accept_map="<Esc>i"
let spell_executable = "ispell"
let spell_language_list = "german,english"
let spell_auto_type = ""
let spell_update_time=500
