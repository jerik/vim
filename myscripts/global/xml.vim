so $VIMRUNTIME/macros/matchit.vim
set ft=xml
set ts=2
set sw=2

imap <F2> <Esc>:call <SID>MakeTag()<CR>a
nmap <F2> :call <SID>MakeTag()<CR>a
nmap <F3> :call <SID>Xmlwf()<CR>

function s:MakeTag()
  exe "normal a\ >\<Esc>"
  normal T<yEf>
  exe "normal a</\<Esc>"
  exe "normal pa>\<Esc>"
  normal F>X
endfunction

function s:Xmlwf()
  "save to tempfile and parse it
  let omod=&modified
  let tmp=tempname()
  echo tmp
  exe "silent w!" . tmp
  let err = system('xmlwf -x ' . tmp)
  call delete(tmp)
  let &modified=omod

  let n = stridx(err, ':')
  if n < 0
    echom expand("%") . " is well-formed"
    return
  endif

  let err = strpart(err, n+1)
  let line = err + 0
  let n = stridx(err, ':')
  let err = strpart(err, n+1)
  let col = err + 0
  let n = stridx(err, ':')
  let err = strpart(err, n+1)
  let err = substitute(err, "\n", '', '')
  call cursor(line, col)
  echohl ErrorMsg
  echo err
  echohl None
  return
endf
