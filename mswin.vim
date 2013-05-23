" Set options and add mapping such that Vim behaves a lot like MS-Windows
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2006 Apr 02

" bail out if this isn't wanted (mrsvim.vim uses this).
if exists("g:skip_loading_mswin") && g:skip_loading_mswin
  finish
endif

" set the 'cpoptions' to its Vim default
if 1	" only do this when compiled with expression evaluation
  let s:save_cpo = &cpoptions
endif
set cpo&vim

" My own halfway point between behave mswin and xterm
set mousemodel=popup " right click should popup not extend
set keymodel=startsel,stopsel " allow shift-<end> style selection
set selection=inclusive " include last char on line when mouse selecting

" backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start whichwrap+=<,>,[,]

" TODO: put this somewhere shared. Maybe set it globally.
if has("unix")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    let g:onmac = 1
  endif
endif

" leader-c is copy to clipboard
nmap <leader>c "+y
vmap <leader>c "+y

" leader-v is paste from clipboard
nmap <leader>v "+gP
vmap <leader>v "+gP

" leader-x is cut to clipboard
nmap <leader>x "+x
vmap <leader>x "+x

" leader-A is Select all
noremap  <leader>a ggVG
vnoremap <leader>a <C-C>ggVG

if exists("g:onmac")
  cmap     <M-V>      <C-R>+
else
  " SHIFT-Del is Cut
  vnoremap <S-Del>    "+x

  " CTRL-Insert is Copy
  vnoremap <C-Insert> "+y

  " SHIFT-Insert is Paste
  map <S-Insert>      "+gP
  cmap <S-Insert>     <C-R>+

  " Pasting blockwise and linewise selections is not possible in Insert and
  " Visual mode without the +virtualedit feature.  They are pasted as if they
  " were characterwise instead.
  " Uses the paste.vim autoload script.
  " This doesn't appear to be necessary on mac. Check the new mswin.vim file
  " to see if it's still there?

  exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
  exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']
endif

" restore 'cpoptions'
set cpo&
if 1
  let &cpoptions = s:save_cpo
  unlet s:save_cpo
endif
