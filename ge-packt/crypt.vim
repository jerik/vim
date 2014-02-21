" Vim personal plugin for editing gpg (symmetrically) enciphered files
" Last Change:	2003 Dec 14
" Maintainer:	Reinhard Wobst <r.wobst@gmx.de>
" License:      This file is placed in the public domain.

"usage: put it in $HOME/.vim/plugin/
"files with names *.gpg and encrypted with "gpg -c ..." can be edited
"directly after entering a password; don't save them before closing
"the session!
"WARNING: security is not perfect, the password is temporarily put
"to environment by exec(), and swapping is also a risk.
"cf. 7.3 in "vim ge-packt" (mitp)

augroup gpg
  au!
  autocmd BufReadPre *.gpg set binary noswapfile
  autocmd BufRead *.gpg call s:Decrypt()
  autocmd BufWrite *.gpg call s:Encrypt()
augroup END

function s:Decrypt()
  set shell=ksh
  "if !exists("s:mykey")
    let s:mykey = inputsecret("Enter passphrase:")
  "endif
  exe "%! { echo " . escape(s:mykey, "!\"|") . "|& }; 
  	\ gpg -q --no-mdc-warning --passphrase-fd 3 3<&p --decrypt 2>/dev/tty"
  set nobin
  if !nextnonblank(1)
    echohl ErrorMsg
    call input("type ENTER to exit")
    :q!
  endif
endf

function s:Encrypt()
  exe "%! { echo " . escape(s:mykey, "!\"|") . "|& };
  	\ gpg -q --passphrase-fd 3 3<&p -c -"
endf
"gpg -q --no-mdc-warning --decrypt --passphrase-fd 3 3< <(echo a)
