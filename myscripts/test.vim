
function! TestAbc()
tcl <<.
	set 	lComment " "
	lappend lComment "\t# abcdefghijklmnopqrstuvw see: ~/.vim/plugin/test.vim"

	set iLine [lindex [[$vim::current(buffer) win] cursor] 1]
	foreach sLine $lComment {
		$vim::current(buffer) insert $iLine $sLine
		incr iLine
	}
.
endfunction
command! TestAbc call TestAbc()


imap <F99> <ESC>:TestAbc<CR>

iab abc <F99>
imap <F100> <ESC>:set paste<ESC>:normal a'' => ''<ESC>:set nopaste<CR>:normal 3F'<CR>
iab => <F100>

