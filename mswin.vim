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

" This check isn't strictly necessary since these keys don't even seem
" available on mac
if !exists("g:onmac")
  " SHIFT-Del is Cut
  vnoremap <S-Del>    "+x

  " CTRL-Insert is Copy
  vnoremap <C-Insert> "+y

  " SHIFT-Insert is Paste
  map <S-Insert>      "+gP
  cmap <S-Insert>     <C-R>+
endif

" restore 'cpoptions'
set cpo&
if 1
  let &cpoptions = s:save_cpo
  unlet s:save_cpo
endif
