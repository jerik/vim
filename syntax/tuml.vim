" Vim syntax file
" Language:	Apache log files
" Maintainer:	Ignacio Javier (ignacio.javier.igjav@gmail.com)
" Last change:	2008 May 12

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif


" shut case off
syn case ignore

" jerik creation "
syn match	Comment	  	"(\*.*" 
syn match	Comment	  	"^\*)*"
syn match   String   	"class\|end;\|state"
syn match   Keyword   	"specializes"
syn match   Special   	"attribute\|package\|primitive\|navigable"
syn match   Identifier  "composition\|aggregation\|association\|operation\|transition"
syn match   Underlined  "enumeration\|datatype"
syn match   Type   	"abstract\|interface"
syn match   embraced  	"\".*\"" contains=ip,time
syn match   cancel   	"^.canceled.*"
syn match   postponed  	"^.postponed.*"
syn match   postponed  	"^.notmybusiness.*"
syn match   postponed  	"^.delegated.*"
syn match   todo   		"^.todo.*"
syn match   back   		"^.back"
syn match   vorschlag	"^.decision"
""syn match   url     	"http:.*"
""syn match   urls     	"https:.*"
syn match   errorlver   "^!!.*"
syn match   cancel   	"^??.*"
syn match   postponed  	"^::.*"

""syn match   embraced  "\[[^\]]*\]" contains=ip,time
syn match   errorlv   "\[error\]\|\[warn\]\|\[notice\]"
syn match   errorlver "\[error\]"
syn match   time      contained "[^0-9a-z]\([0-9]\{2}:\)\{2}[0-9]\{2}[^0-9a-z]" 
syn match   ip        contained "[^0-9a-z]\([0-9]\{1,3}\.\)\{3}[0-9]\{1,3}[^0-9a-z]"
syn match   refer     "referer: http://.*"


" Classes
syntax keyword jsClassKeyword           contained class

if version >= 508 || !exists("did_apachelogs_syntax_inits")
  if version < 508
    let did_apachelogs_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink embraced   String
  HiLink errorlv    Comment 
  HiLink errorlver  Error
  HiLink time       Identifier
  HiLink ip         Special 
  HiLink refer      Keyword 

" jerik creation "
  HiLink pcom		Comment
  HiLink done  		Special
  HiLink cancel  	Special
  HiLink postponed  Folded
  HiLink todo   	Todo
  HiLink back   	Type
  HiLink vorschlag	String
  HiLink url   		Underlined
  HiLink urls  		Underlined

  HiLink jsClassKeyword         Keyword

  delcommand HiLink
endif


let b:current_syntax = "tuml"

" vim: ts=8 sw=2

