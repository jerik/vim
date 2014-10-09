" Boost programming in vim
inoremap { {  }<LEFT><LEFT>
inoremap [ []<LEFT>
inoremap ( (  )<LEFT><LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
inoremap \| \|\|<LEFT>

"ruby support"
"inoremap <% <%=   %> <LEFT><LEFT><LEFT><LEFT><LEFT>
"inoremap ,end <% end  %> 
"inoremap ,if <% if   %> <LEFT><LEFT><LEFT><LEFT><LEFT>

"	Rechtschreibfehler automatisch verbessern
"	See also:  http://www.igd.fhg.de/~zach/programs/acl/
iab alos    also
iab aslo    also
iab sonder	sondern

" 	hilfreiche Ersetzungen
iab ydate <C-R>=strftime("%d.%m.%Y")<CR>
iab isodate <C-R>=strftime("%Y-%m-%d")<CR>

"	Verbessertes arbeiten im Vim
nmap ,h <ESC>:e $HOME/.vim/doc/jerik.txt<CR>
" What does this function do 
nmap ,< <C-W>w
""nmap � f"a
nmap <M-v> f"a

" Open vimrc with ,v shortcut
""nmap ,v <ESC>:e $HOME/.vimrc<CR>
nmap ,v <ESC>:Vimrc<CR>
function! Vimrc()
	let s:vimrc = ".vimrc"
	if has( "win32" )
		let s:vimrc = "_vimrc"
	endif 
	echo s:vimrc
    exec ":e $HOME/" . s:vimrc
endfunction
command! Vimrc call Vimrc()

:command! Sand Sandbox
" Perhaps switch for OS needed, as vimfiles is in *nix .vim "
:command! Sandbox :e $HOME/vimfiles/plugin/sandbox.vim

imap ;; <ESC>:normal A;<CR>:w<CR>
nmap ;; <ESC>:normal A;<CR>:w<CR>

"	001201:  Deleting text in normal mode
"	using the BackSpace and Delete keys:
nmap <BS>  X
nmap <DEL> x
nmap <F12> <ESC>:w<CR>

"	jerik: L�schen von Text im insert mode
"	WICHTIG, die Backspacetaste l�scht wie sie soll nach <--
imap <DEL> <DEL>
imap <F12> <ESC>:w<CR>

"	jerik: zwischen den Buffern wechseln - vorw�rts"
" Entfernen Taste (Funktionalit�t) auch �ber shift + Backspace
nmap <C-Tab> :bn<CR>
imap <C-Tab> :bn<CR>
" verf�gbar machen.
""imap <S-BS> <DEL>

" jerik 2009-02-10: Text in den zwischenspeicher kopieren, damit man diesen woanders mit strg + v einf�gen kann
" http://codecocktail.wordpress.com/2008/10/27/vim-copypaste/
" normalerweise um eine zeile zu kopieren: "+dd
nmap <M-d> "+dd

"" jerik: Sobald ich mich im Vim mit dem Cursor bewege verschwinden alle search highligts
"" Tip: 14 http://www.vim.org/tips/tip.php?tip_id=14 in den Comments
""map j <Down>:noh<CR>
""map k <Up>:noh<CR>
""map h <Left>:noh<CR>
""map l <Right>:noh<CR>
