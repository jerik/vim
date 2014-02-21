" decrypt a PGP enciphered part "on the fly"
" by pressing F7
" R.Wobst, @(#) Feb 28 2005, 10:38:40

function  s:gpg()
  "set mark a at start, mark b at end, evtl. delete trailing blank
  1
  /^-----END PGP MESSAGE-----
  normal YPmb
  ?^-----BEGIN PGP MESSAGE-----
  try
    . s- $--
  catch
  endtry
  normal Ypma

  'a,'b !gpg --decrypt 2>/dev/tty
  call input('Enter drücken:')
  try
    % s---
  catch
  endtry

  try
    1
    /Content-Transfer-Encoding: quoted-printable
    /^$
    normal ma
    /^--
    normal mb
    'a,'b-1 !quopriconv
  catch
  endtry

  redraw
endfunction

function  s:utf()
  "recode UTF-8 to ISO using old labels
  1
  /^-----END PGP MESSAGE-----
  normal mb
  ?^-----BEGIN PGP MESSAGE-----
  normal ma
  'a,'b !recode UTF8..ISO-8859-1
endfunction

map <silent> <F7> :call <SID>gpg()<CR>
map <silent> <F6> :call <SID>utf()<CR>
