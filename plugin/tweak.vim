" Boost programming in vim
" 05.04.2017 perhaps obsolete with https://github.com/Raimondi/delimitMate
"inoremap { {  }<LEFT><LEFT>
"inoremap [ []<LEFT>
"inoremap ( (  )<LEFT><LEFT>
"inoremap " ""<LEFT>
"inoremap ' ''<LEFT>
"inoremap \| \|\|<LEFT>

" Toogle ignorecase on search
" http://stackoverflow.com/a/2317808/19335
nmap <F9> :set ignorecase! ignorecase?<CR>

" 	Use Leader c and Leader v to copy and paste using the OS clipboard: 
map <Leader>v "+gP 
map <Leader>c "+y
" 	http://vim.wikia.com/wiki/Quick_command_in_insert_mode 
"	insert OS clipboard in insert mode
" inoremap VV <Esc>"+gp "works but leaves me in the normal mode, not the insert mode
" 	http://stackoverflow.com/q/26486948/1933185
inoremap VV <C-r>+

" https://stackoverflow.com/a/18948530/1933185
" how about adding an autocmd, when FileType python, create a mapping:
" autocmd FileType python nnoremap <buffer> <F5> :exec '!py' shellescape(@%, 1)<cr> " # 2019-10-01 not working
"nnoremap <buffer> <F5> :exec '!py' shellescape(@%, 1)<cr>
" TODO @todo should run only on a pyhton buffer ( with a python file )
nmap <F5> :exec '!py' shellescape(@%, 1)<cr>

" 	hilfreiche Ersetzungen
iab ydate <C-R>=strftime("%d.%m.%Y")<CR>
iab isodate <C-R>=strftime("%Y-%m-%d")<CR>

"	Verbessertes arbeiten im Vim
nmap ,h <ESC>:Myhelp<CR>
" Open vimrc with ,v shortcut
nmap ,v <ESC>:e $MYVIMRC<CR>

" 	Move between splitted windows
nmap ,< <C-W>w
""nmap ö f"a
" 20150213 Was bringt mir das?
nmap <M-v> f"a

" jerik 20150213 get easy access to tweak and sandbox
function! MyVimFiles( command )
	"
	"default is tweak.vim
	let s:file = "/plugin/tweak.vim"

	if a:command == "myhelp"
		let s:file = "/doc/jerik.txt"
	elseif a:command == "sandbox"
		let s:file = "/plugin/sandbox.vim"
	endif
	echo s:file
    ""exec ":e $HOME/" . s:vimfolder . s:file
    ""exec ":e $HOME/" . MyVimFolder() . s:file
    exec ":e " . MyVimFolder() . s:file
endfunction

" jerik 20150213 return the vim folder based on the current OS
function! MyVimFolder(  )
	let s:vimfolder = ".vim"
	if has( "win32" )
		:let s:vimfolder = "vimfiles"
	endif 
	return "$HOME/" . s:vimfolder
endfunction


" Perhaps switch for OS needed, as vimfiles is in *nix .vim "
":command! Sandbox :e $HOME/vimfiles/plugin/sandbox.vim
":command! Tweak :e $HOME/vimfiles/plugin/tweak.vim
command! Sandbox call MyVimFiles( "sandbox" )
command! Tweak call MyVimFiles( "tweak" )
command! Myhelp call MyVimFiles( "myhelp" )

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
" jerik 2019-10-01 Funktioniert das noch? Alt+m hat auf osx nicht die
" beschriebene funktion
nmap <M-d> "+dd

"" jerik: Sobald ich mich im Vim mit dem Cursor bewege verschwinden alle search highligts
"" Tip: 14 http://www.vim.org/tips/tip.php?tip_id=14 in den Comments
""map j <Down>:noh<CR>
""map k <Up>:noh<CR>
""map h <Left>:noh<CR>
""map l <Right>:noh<CR>

" ************************ old mygft.vim

" my project vim

" For a better workspace logfiles 
iab ato		@todo
iab atn 	@todo-next
iab atw		@todo-wait
iab atc 	@todo-changes
iab tb		@thinkbox
"iab atp		@todo :prototyp
iab <expr> heu strftime("=%Y%m%d")
"iab <expr> tom strftime("%%%Y%m%d", localtime(  ) + ( 24*3600 ))
iab <expr> nwe strftime("%%%Y%m%d", localtime(  ) + ( 7*24*3600 ))

" Add *unwanted* carriage return
""iab tom <C-o>:r !date -v+1d "+=\%Y\%m\%d"<CR>
""iab too <ESC>:r !ruby -e "puts (Time.now + 24*60*60).strftime('\%Y\%m\%d')"<CR>   

" Strip tags from buffer "
" http://aftnn.org/post/47880443079/strip-tags-in-a-vim-buffer
:command! STag :%s/<\_.\{-1,\}>//g  

" format @Todo to @todo
" As iOS replace of ato is @Todo insteal of @todo
:command! Ctodo :%s/^@Todo/@todo/g  

" 	jerik 20141015
" 	Show all tags in my journal. A tag is =tag =test =foobar
:command! Tags /=\w\+

" 	jerik 20141013
" 	add bullet points '-' in front of sentences"
" 	Example: 
"    this is a point
"       and this is another point
" 	After the command: 
"  	 - this is a point
"      - and this is another point
" 	mainly used to format lists that I take via copy/paste into vim
:command! List :'<,'>s/\w/- &

" um mit project_notes besser zu arbeiten
""nmap ,d <ESC>:s/@todo-next/@done/<CR>:w<CR>
" replaces no every variation of @todo*"
nmap ,d <ESC>:call ToDo( "done" )<CR>
nmap ,w <ESC>:call ToDo( "wait" )<CR>
" todo start. Vorher war es ,o aber das konkurriet mit Nextv2
nmap ,s <ESC>:call ToDo( "todo" )<CR>
nmap ,c <ESC>:call ToDo( "cancel" )<CR>
nmap ,p <ESC>:call ToDo( "postponed" )<CR>
nmap ,x <ESC>:call ToDo( "notmybusiness" )<CR>
" move = delegated
nmap ,m <ESC>:call ToDo( "delegated" )<CR>
" alte vergangene Sachen die nicht gemacht wurden
nmap ,a <ESC>:call ToDo( "past" )<CR> 

"nmap ,d <ESC>:s/@todo.\{-} /@done /<CR>:w<CR>
nmap ,n <ESC>:s/@todo/@todo-next/<CR>:w<CR>
nmap ,t <ESC>:call NewTodos()<CR>
nmap ,l <ESC>:Log<CR>
nmap ,u <ESC>:call NextTodos()<CR>
nmap ,o <ESC>:call Nextv2Todos()<CR>
nmap ,f <ESC>:call FindCurrentLine()<CR>

" Pfade sollte betriebssystem unabhaengig sein. ruby funktion die dann den Pfad
" zusammenbaut...

" Not used
:command! Issue :e ..\log\issue.log
:command! Lessons :e ..\log\lessons_learned.log
:command! Decisions :e ..\log\decisions.log
:command! Notes :e ..\log\project_notes.log
:command! Com :e ..\plan\communication.plan

" global variable, needs to be referenced with prefix g: in function
:let tempfile = "~/Library/Journal-VIC777C.tmp"
:let journal = "~/Dropbox/Journal.txt"

if has( "win32" )
	:let g:tempfile = "~/AppData/Local/Temp/Journal-VIC777C.tmp"
	:let g:journal="~\workspace\logs\Journal.log"
endif

" call with arguments next, wait, 
" bugfix: command should work
function! NewTodos() 
	" :let tempfile = tempname()
	:echo g:tempfile
	:exe 'e ' . g:tempfile
	" delete all existing lines, see
	" https://alvinalexander.com/linux-unix/vi-vim-delete-all-lines-how
	:1,$d
	"":r ~/Dropbox/Journal.txt
	:exe 'r ' . g:journal
	:silent v/^@todo/d
	" reverse list, does not work correctly
	:g/^/m0		
	:w
	:syn match String "^@todo"
endfunction 

function! NextTodos()
	:exe 'e ' . g:tempfile
	" delete all existing lines, see
	" https://alvinalexander.com/linux-unix/vi-vim-delete-all-lines-how
	:1,$d
	:exe 'r ' . g:journal
	":silent v/^@todo/d
	:silent v/-next\|-wait\|-periodic/d
	" reverse list, does not work correctly
	:g/^/m0		
	:sort
	:execute "normal gg"
	" https://stackoverflow.com/a/21277670/1933185
	if has( "win32" )
		" only needed on work journal, as there are the productivity rules
		":put =readfile(expand('~/Dropbox/Journal.txt'))[1:19]
		:put =readfile(expand(g:journal))[1:19]
	endif
	" http://learnvimscriptthehardway.stevelosh.com/chapters/29.html
	:execute "normal ggdd"
	:w
	:set cursorline
	:syn match String "-next"
	:syn match Comment "-periodic"
	:syn match Special "-wait"
endfunction

function! Nextv2Todos(  )
	:exe 'e ' . g:tempfile
	:1,$d
	:silent r ! /Users/jerik/sbin/todo-wait.py
	:g/^/m0		
	:sort
	:exe 'w! ' . g:tempfile
	:set cursorline
	:syn match String "-next"
	:syn match Comment "-periodic"
	:syn match Special "-wait"
	:syn match Error "\[-\d*\]"
	:syn match Comment "\[\d*\]"
endfunction

function! FindCurrentLine()
	:let line = getline('.')
	" try to get rid of / in the line, as this causes problems when finding
	" the line in the journal
	" This is done, because I set the search register manually
	" http://vim.wikia.com/wiki/Searching_for_expressions_which_include_slashes
	:let part = strpart( line, 30 )
	""let @/ = line
	" get only a part of the line to work with adjusted todo-waits
	let @/ = part
	:exe 'e ' . g:journal
	:normal n
endfunction

""command! -nargs=1 Todo :call Todo("<args>")  

"relpace @todo wit @done"
function! ToDo( type )
" http://stackoverflow.com/a/26214054/1933185
" function! foo( ... )
" ... means, the function accept variable amount of parameters 0-n
" a:0 is the amount of parameters
" a:1 is the first parameter, a:2 is the second...

	if a:type == "done"
		:s/@todo\%(-\w\+\)* /@done / 
	elseif a:type == "wait"
		:s/@todo\%(-\w\+\)* /@todo-wait / 
		":s/@todo.\{-} /@todo-wait /
	elseif a:type == "todo"
		:s/@todo\%(-\w\+\)* /@todo / 
	elseif a:type == "cancel"
		:s/@todo\%(-\w\+\)* /@canceled / 
	elseif a:type == "postponed"
		:s/@todo\%(-\w\+\)* /@postponed / 
	elseif a:type == "next"
		:s/@todo\%(-\w\+\)* /@todo-next / 
	elseif a:type == "notmybusiness"
		:s/@todo\%(-\w\+\)* /@notmybusiness / 
	elseif a:type == "delegated"
		:s/@todo\%(-\w\+\)* /@delegated / 
	elseif a:type == "past"
		:s/@todo\%(-\w\+\)* /@past / 
	endif
	:w
endfunction
"command! ToDo call ToDo("done")

" Funktion von Nils, toggle damit im nowrap modus beim einfügen von Zeichen,
" die Zeile nicht umbricht
" http://deliberate-software.com/vim-refactoring-patterns/
function! ToggleTextWrap()
    if &fo =~ 't'
        set fo-=t
    else
        set fo+=t
    endif
endfunction
" F10: Highlight too long lines
"map<F10> :call ToggleTextWrap()<CR>
