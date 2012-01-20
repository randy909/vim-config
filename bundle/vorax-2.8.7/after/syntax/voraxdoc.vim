" Vim syntax file
" Language:   Voraxdoc
" Author:   Alexandru Tica

" Some Clean-keywords
syn region helpKey start="|"  end="|"

if !exists("did_voraxdoc_syntax_init")
  let did_voraxdoc_syntax_init = 1
  hi link helpKey Keyword
endif

let b:current_syntax = "voraxdoc"

