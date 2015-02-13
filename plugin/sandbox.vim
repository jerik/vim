" file for testing vim configurations"

" reload configurations with :so %
function! Foo(  )
	"echo "Foo'ing around :)"
	let line=getline('.')
	let newline = substitute(line, "@todo", "@done", "")
	call setline('.', newline)
	:w
endfunction
command! Foo call Foo()

""@todo-next iasdfadf asdf

function! TTest( ... )
	if a:0 > 0
		if a:1 == ""
			echom "leer"
		else
			let type = a:1
			echom type
		endif
	else
		echom "kein parameter übergeben"
	endif
endfunction

function! Tfoo( foo )
	echom a:foo
endfunction
