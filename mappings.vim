" This file contains mappings that don't depend on plugins

let mapleader = ","

" use ; for : too so I don't have to hit <shift>
nnoremap ; :
vnoremap ; :
nnoremap q; q:

" replace ; and , because i reused those for other stuff
nnoremap <space> ;
" I can't find a good shortcut for this. buffergator takes this one.
" I don't think i ever really use it.
" nnoremap <leader><space> ,
" This doesn't work in the terminal
" nnoremap <S-space> ,

" make alt-j/k go up/down by screen line instead of file line
nnoremap <A-j> gj
nnoremap <A-k> gk

" Map <C-hjkl> to move between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Map <C-l> to complete line (workaround for YouCompleteMe always having
" completion started)
inoremap <C-l> <C-x><C-l>

" Clear search highlighting
nnoremap <silent> <leader>/ :noh<cr>

" Give Textmate's indentation commands a whirl
if has("gui_running")
  nmap <A-[> <<
  nmap <A-]> >>
  vmap <A-[> <gv
  vmap <A-]> >gv
endif

" Put search item at the top of the screen
nnoremap <A-n>   nzt
nnoremap <A-S-n> Nzt

" command-<num> jumps to tab just like chrome, iterm, etc.
nnoremap <D-1> 1gt
nnoremap <D-2> 2gt
nnoremap <D-3> 3gt
nnoremap <D-4> 4gt
nnoremap <D-5> 5gt
nnoremap <D-6> 6gt
nnoremap <D-7> 7gt
nnoremap <D-8> 8gt
nnoremap <D-9> 9gt

" Use ctrl-j/k for up/down in autocomplete menu
" Unfortunately there are no direct mappings for just autocomplete menu mode
" These seem to be squashed by YouCompleteMe or Ultisnips for some reason
" inoremap <C-j> <C-n>
" inoremap <C-k> <C-p>

" leader-c is copy to clipboard
" leader-c is copy to clipboard (<leader>y is used for yankstack)
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

" Paste from buffer zero which allows pasting the same buffer repeatedly
vnoremap <leader>0 "0p

" Q normally goes into the frustrating ex mode
" Repurpose to apply the 'q' macro
nnoremap Q @q
vnoremap Q :norm @q<cr>

" Y normally is the same as yy
" Make it behave similarly to D and C
" The yankstack docs say you should put 'call yankstack#setup()' in the vimrc
" before you do this, not sure the order here...
nmap Y y$

" TODO: put this somewhere shared. Maybe set it globally.
if has("unix")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    let g:onmac = 1
  endif
endif

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

