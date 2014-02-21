" Vim personal plugin for generating continuous text
" Last Change:	2003 Dec 14
" Maintainer:	Reinhard Wobst <r.wobst@gmx.de>
" License:      This file is placed in the public domain.

"usage: put it in $HOME/.vim/plugin/; key F12 joins all lines in the
"buffer which are not separated by blank lines
"cf. "vim ge-packt" (mitp), 5.7

function! Fliess()
  %s/\s*$//			" leere Zeilen und -anhang löschen
  let oldj=&joinspaces		" alten Wert retten
  set joinspaces
  let old = 1

  while 1
    let old = nextnonblank(old)
    if !old || old == line("$")
      let &joinspaces=oldj	" alten Wert wieder herstellen
      return
    endif

    " auf erste nichtleere Zeile
    exe old

    normal V}			" visuell, Absatz markieren
    let new = line(".")
    if getline(new) =~ '^\s*$'
      normal k			"aktuelle Zeile leer, eine hoch
      let new = new-1
    endif

    if new != old
      normal J}			" mehr als eine Zeile im Absatz, Join
      let old = line(".")
    else
      normal Vj			" visuell aus, auf nächste Zeile
      let old = new+1
      continue
    endif

  endw

  let &joinspaces=oldj		" alten Wert wieder herstellen
endf

map <F12> :call Fliess()<CR>
