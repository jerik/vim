" Datei zum eserv schieben:
nmap <F1> <ESC>:!scp % jerik@iserv:$PWD/% && sleep 1 && ssh jerik@iserv "/home/rdemeo/bin/ncp $PWD/% set"<CR>
" Datei vom eserv holen:
nmap <F2> <ESC>:!ssh jerik@iserv "/home/rdemeo/bin/ncp $PWD/% get" && sleep 1 && scp jerik@iserv:$PWD/% %<CR>

" IDEHELPER:
" Datei in RAM laden
nmap <F3> <ESC>:!IDEHelper 101 %<CR>
" Datei in den RAM laden und Ausführen
"nmap <F4> <ESC>:!IDEHelper 100 %<CR>

"" livehtml
""nmap <F4> <ESC>:!IDEHelper 100 "/home/jerik/fts/beaker/templ/sandbox/index.html"<CR>
"" livehtml
""nmap <F4> <ESC>:!IDEHelper 100 "/home/jerik/fts/stsshow/templ/lhtml/jerik/index.html"<CR>
" xml/index.html benutzen - Postbank XML
""nmap <F4> <ESC>:!IDEHelper 100 "/home/jerik/fts/easytrade/templ/xml/index.html"<CR>
" index.tcl für parser
nmap <F4> <ESC>:!IDEHelper 100 "~/fts/beaker/templ/plugins/xml/parser/index.html"<CR>
" FTS restart
nmap <F5> <ESC>:!IDEHelper 500 %<CR>
" Restart
" 	<F5>

" Automatisches holen der neusten Dateiversion vim fts"
function GetRemoteFiles(file)
""	echo a:file
	execute "edit " a:file
	execute "!scp % jerik@iserv:$PWD/% && sleep 1 && ssh jerik@iserv '/home/rdemeo/bin/ncp $PWD/% set'"
endfunction

command -nargs=1 G call GetRemoteFiles("<args>")

" Andere Dateien einbinden
:command Solhmtl :so /home/jerik/.vim/myscripts/sts/lhtml.vim
