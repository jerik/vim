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

""@done is das was
