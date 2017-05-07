" Autor: J. Erik Heinz <develop@jerik.de>
" Date: 2006-10-16 
" Description: 
" With the Keystroke CTRL-j you can execute all scripts that are: 
" a) detected by the filetype 
" b) the filetyp is associated with a interpreter
"
" 20170507 @todo: kollidates with vim-pipe
"
" All output of the script will be redirected to /tmp/vim.debug
" Execute the current script file

" 20170507 does not work to check for allowed filetype and do the stauff
" If none of the allowed filetype exists, the plugin will not be loaded
" This is as well the case if later a know filetype is edited with vim

"@TODO: 
"	allow range, for just run partial code
"	integrate irb, or better breakpointer like in RoR
function! Run()
" if I now the mapping with control-shift-key i will use this"
""function! Run(flag)
	if &ft == 'ruby'
		let interpreter='ruby'
	elseif &ft == 'perl'
		let interpreter='perl'
	elseif &ft == 'sh'
		let interpreter='bash'
	elseif &ft == 'php'
		let interpreter='php'
	elseif &ft == 'tcl'
		let interpreter='tclsh8.4'
	elseif &ft == 'python'
		let interpreter='python'
	else
		echom "filetype is not associated with an interpreter in ~/.vim/plugin/run.vim"
		let interpreter='nil'
	endif

	" if I now the mapping with control-shift-key i will use this"
	""echom a:flag
	if interpreter != 'nil'
		""if a:flag == 'file'
			exe ":w !" . interpreter . " % > /tmp/vim.debug"
		""else
		""	exe ":w !" . interpreter . " % " 
		""endif
	endif
endfunction

command! Run call Run()
"mapping CTRL-ü, <C-Char-252>  does not work. ü = <Char-252>
"run from a keystroke
nmap <silent> <C-j> :call Run()<CR>
"to slow
"imap <silent> <C-j> <ESC>:w <ESC>:call Run()<CR>

" if I now the mapping with control-shift-key i will use this"
""nmap <silent> <CS-j> :call Run("stdout")<CR>
""nmap <silent> <C-j> :call Run("file")<CR>
