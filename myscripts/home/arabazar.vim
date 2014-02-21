function s:IsArabazar(sPath)
	let sFile = '/home/jerik/workspace/projects/arabazar/dev/confs/arabazar.coding.vim'
	if a:sPath !~ 'arabazar'
		:!echo 'toll'
		:source sFile
	else 
		:!echo 'nichttoll'
	endif
endfunction
" Das will alles nocht nicht so wie ich will
" command -nargs=1 IsArabazar call s:IsArabazar("$PWD")
source /home/jerik/workspace/projects/arabazar/dev/confs/arabazar.coding.vim
