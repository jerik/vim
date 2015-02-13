" Vim syntax file
" Language:	Project
" Maintainer:	Abhijit Nadgouda (http://ifacethoughts.net/)

syntax clear

syn match projTag            "\*[a-zA-z]*\*"
syn match projJump           "|[a-zA-z]*|"

syn match projDate           "=\d\d\d\d\d\d\d\d" contained
syn match projDone           "=done" contained
syn match projHigh           "=high" contained

syn match projKeyword        ":phone" contained
syn match projKeyword        ":email" contained
syn match projKeyword        ":chat" contained
syn match projKeyword        ":meet" contained

syn match projTask      "\-\s.*" contains=projDate,projDone,projHigh,projKeyword
syn match projTaskH     "\-\s.*=high" contains=projDate,projHigh,projKeyword
syn match projTaskD     "\-\s.*=done$" contains=projDate,projDone,projKeyword
syn region projTaskDoc  matchgroup=Comment start=/\[/ end=/\]/

hi def link projTag          String
hi def link projJump         String

hi def link projDate         Constant
hi def link projDone         SpecialChar
hi def link projHigh         SpecialChar
hi def link projKeyword      SpecialChar

hi def link projTask         Statement
hi def link projTaskDoc      Comment
hi def link projTaskD        Comment
hi def link projTaskH        Special

