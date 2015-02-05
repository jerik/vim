"inoremap { {  }<LEFT><LEFT>
inoremap [ []<LEFT>
inoremap ( (  )<LEFT><LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
inoremap \| \|\|<LEFT>

" Zusaetzliche Dateien einbinden
:command! Soxml :so /home/jerik/.vim/myscripts/global/xml.vim

"ruby support"
inoremap <% <%=   %> <LEFT><LEFT><LEFT><LEFT><LEFT>
inoremap ,end <% end  %> 
inoremap ,if <% if   %> <LEFT><LEFT><LEFT><LEFT><LEFT>

""" http://pmade.com/articles/2006/vim_mapping_for_ruby"
""" error message with vimproc, disabled this function
"function RubyEndToken ()
"    let current_line = getline( '.' )
"    let braces_at_end = '{\s*\(|\(,\|\s\|\w\)*|\s*\)\?$'
"    let stuff_without_do = '^\s*\(class\|if\|unless\|begin\|case\|for\|module\|while\|until\|def\)'
"    let with_do = 'do\s*\(|\(,\|\s\|\w\)*|\s*\)\?$'
"
"    if match(current_line, braces_at_end) >= 0
"        return "\<CR>}\<C-O>O"
"    elseif match(current_line, stuff_without_do) >= 0
"        return "\<CR>end\<C-O>O"
"    elseif match(current_line, with_do) >= 0
"        return "\<CR>end\<C-O>O"
"    else
"        return "\<CR>"
"    endif
"endfunction

"function UseRubyIndent ()
"    setlocal tabstop=8
"    setlocal softtabstop=2
"    setlocal shiftwidth=2
"    setlocal expandtab
"
"    imap <buffer> <CR> <C-R>=RubyEndToken()<CR>
"endfunction

autocmd FileType ruby,eruby call UseRubyIndent()
