" evironment varilabel $jodo_path must be set to the directory where jodo.rb
" is located
function! JodoList(  ) 
    let jodo = tempname(  )
    execute "badd" . jodo
    normal ggdG
    "":r ! w3m -dump -cols 200 http://localhost:3000/todos/list
    "" Productive
    "":r ! /usr/bin/ruby /home/jerik/.jodo/jodo.rb
    "" Development
    :r ! /usr/bin/ruby $jodo_path/jodo.rb
    normal ggdd
endfunction
command! Jla call JodoList(  )

function! JodoListNext(  ) 
    let jodo = tempname(  )
    execute "badd" . jodo
    normal ggdG
    "":r ! w3m -dump -cols 200 http://localhost:3000/todos/list
    "" Productive
    "":r ! /usr/bin/ruby /home/jerik/.jodo/jodo.rb --nextaction
    "" Development
    :r ! /usr/bin/ruby $jodo_path/jodo.rb --nextaction
    normal ggdd
endfunction
command! Jln call JodoListNext(  )

" http://vim.wikia.com/wiki/Launch_lynx_to_get_info_for_the_current_word"
" nmap ^L :!lynx -accept_all_cookies http://us2.php.net/^R^W\#function.^R^W<CR>
" http://vim.wikia.com/wiki/Open_a_web-browser_with_the_URL_in_the_current_line
" exec "!netscape ".line
function! JodoDone(  )
    let start=line( '.' )
    let line=getline( start )
    let delimiter=stridx( line, ':' )
    let id=strpart( line, 0, delimiter )
    ""exec ":! ./foo.sh " . id
    "" Productive
    ""exec ":r ! /usr/bin/ruby $jodo_path/jodo.rb --done " . id
    "" Development
    exec ":r ! /usr/bin/ruby $jodo_path/jodo.rb --done " . id
endfunction
command! Jdone call JodoDone(  )
command! Jd call JodoDone(  )

function! JodoNext(  )
    let start=line( '.' )
    let line=getline( start )
    let delimiter=stridx( line, ':' )
    let id=strpart( line, 0, delimiter )
    "" Productive
    ""exec ":r ! /usr/bin/ruby $jodo_path/jodo.rb --next " . id
    "" Development
    exec ":r ! /usr/bin/ruby $jodo_path/jodo.rb --next " . id
endfunction
command! Jnext call JodoNext(  )
command! Jn call JodoNext(  )

function! JodoComment( message )
    let start=line( '.' )
    let line=getline( start )
    let delimiter=stridx( line, ':' )
    let id=strpart( line, 0, delimiter )
	"exec ":echo " . a:message
    exec ":r ! /usr/bin/ruby $jodo_path/jodo.rb --comment " . id . ',' . a:message
endfunction
"command -nargs=* DoIt :call AFunction(<f-args>)
" :DoIt a b c
" Aufrufen mit :Jc 'irgendwas' 
command! -nargs=1 Jc call JodoComment("<args>") 

function! JodoCommentDone( message )
    let start=line( '.' )
    let line=getline( start )
    let delimiter=stridx( line, ':' )
    let id=strpart( line, 0, delimiter )
	"exec ":echo " . a:message
    exec ":r ! /usr/bin/ruby $jodo_path/jodo.rb --commentdone " . id . ',' . a:message
endfunction
command! -nargs=1 Jcd call JodoCommentDone("<args>") 

"" @TODO JodoNext, JodoPast, JodoToday, JodoTomorrow, 
"" J*, der stern wird dann weitergetragen an das skript und fürhrt dann das entsprechende aus
"" Muss ja kein HTML sein was rails anzeigt, kann ja zeilenbasierter Text sein, ist wahrscheinlich das beste, dann erspare ich mir das striptags

