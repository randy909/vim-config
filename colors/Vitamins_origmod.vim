" Maintainer:	Henrique C. Alves (hcarvalhoalves@gmail.com)
" Version:      1.1
" Last Change:	September 23 2008

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "vitamins"

" Vim >= 7.0 specific colors
if version >= 700
  hi CursorLine guibg=#232323 ctermbg=236
  hi CursorColumn guibg=#232323 ctermbg=236
  hi MatchParen guifg=#f6f3e8 guibg=#857b6f gui=bold ctermbg=59
  hi Pmenu 		guifg=#f6f3e8 guibg=#444444 ctermbg=242
  hi PmenuSel 	guifg=#000000 guibg=#cdd129 ctermfg=0 ctermbg=184
endif


" General colors
hi Cursor 		guifg=NONE    guibg=#353535 gui=none ctermbg=0x241
hi Normal 		guifg=#f6f3f0 guibg=#282828 gui=none ctermfg=254 ctermbg=235
hi NonText 		guifg=#808080 guibg=#292929 gui=none ctermfg=242 ctermbg=237
hi LineNr 		guifg=#5c5a4f guibg=#282828 gui=none ctermfg=239 ctermbg=232
hi StatusLine 	guifg=#d6d3c8 guibg=#202020 gui=italic
hi StatusLineNC guifg=#453b2f guibg=#202020  gui=none
hi VertSplit 	guifg=#202020 guibg=#202020 gui=none 
hi Folded 		guibg=#384048 guifg=#a0a8b0 gui=none
hi Title		guifg=#f6f3e8 guibg=NONE	gui=bold 
hi Visual		guifg=#ffffd7 guibg=#444444 gui=none ctermfg=186 ctermbg=238
hi SpecialKey	guifg=#808080 guibg=#343434 gui=none

" Syntax highlighting
hi Comment 		guifg=#3c3c3c gui=italic ctermfg=244
hi Todo 		guifg=#8f8f8f guibg=#444444 gui=italic ctermfg=245
hi Constant 	guifg=#acf0f2 gui=none ctermfg=159
hi String 		guifg=#598584 gui=italic ctermfg=202
hi Identifier 	guifg=#c2d400 gui=none ctermfg=202
hi Function 	guifg=#c2d400 gui=bold ctermfg=184
hi Type 		guifg=#cdd129 gui=none ctermfg=184
hi Statement 	guifg=#f2782e gui=bold ctermfg=131
hi Keyword		guifg=#cdd129 gui=none ctermfg=184
hi PreProc 		guifg=#C8341C gui=none ctermfg=187
hi Number		guifg=#0959ff gui=none ctermfg=187
hi Special		guifg=#205251 gui=none ctermfg=159

hi! perlHereDoc guifg=#000000 gui=underline
hi! perlVarPlain guifg=#C8341C gui=none
hi! perlStatementFileDesc guifg=#c2d400 gui=none

