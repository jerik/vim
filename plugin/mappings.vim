"	Rechtschreibfehler automatisch verbessern
"	See also:  http://www.igd.fhg.de/~zach/programs/acl/
iab alos    also
iab aslo    also
iab sonder	sondern

" 	hilfreiche Ersetzungen
iab ydate <C-R>=strftime("%d.%m.%Y")<CR>
iab isodate <C-R>=strftime("%Y-%m-%d")<CR>

"	Verbessertes arbeiten im Vim
nmap ,v <ESC>:e $HOME/.vimrc<CR>
nmap ,h <ESC>:e $HOME/.vim/doc/jerik.txt<CR>
nmap ,< <C-W>w
""nmap ö f"a
nmap <M-v> f"a

imap ;; <ESC>:normal A;<CR>:w<CR>
nmap ;; <ESC>:normal A;<CR>:w<CR>

"	001201:  Deleting text in normal mode
"	using the BackSpace and Delete keys:
nmap <BS>  X
nmap <DEL> x
nmap <F12> <ESC>:w<CR>

"	jerik: Löschen von Text im insert mode
"	WICHTIG, die Backspacetaste löscht wie sie soll nach <--
imap <DEL> <DEL>
imap <F12> <ESC>:w<CR>

"	jerik: zwischen den Buffern wechseln - vorwärts"
" Entfernen Taste (Funktionalität) auch über shift + Backspace
nmap <C-Tab> :bn<CR>
imap <C-Tab> :bn<CR>
" verfügbar machen.
""imap <S-BS> <DEL>

" jerik 2009-02-10: Text in den zwischenspeicher kopieren, damit man diesen woanders mit strg + v einfügen kann
" http://codecocktail.wordpress.com/2008/10/27/vim-copypaste/
" normalerweise um eine zeile zu kopieren: "+dd
nmap <M-d> "+dd

"" jerik: Sobald ich mich im Vim mit dem Cursor bewege verschwinden alle search highligts
"" Tip: 14 http://www.vim.org/tips/tip.php?tip_id=14 in den Comments
""map j <Down>:noh<CR>
""map k <Up>:noh<CR>
""map h <Left>:noh<CR>
""map l <Right>:noh<CR>
