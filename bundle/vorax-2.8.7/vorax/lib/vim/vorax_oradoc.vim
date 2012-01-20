" Description: Oracle Documentation for Vorax
" Mainainder: Alexandru Tica <alexandru.tica.at.gmail.com>
" License: Apache License 2.0

" no multiple loads allowed
if exists("s:vorax_oradoc")
  finish
endif

" mark this as loaded
let s:vorax_oradoc = 1

" the default path
let s:default_oradoc_dir = fnamemodify(expand('<sfile>:p:h') . '/../../oradoc/public', ':p:8')
let s:default_oradoc_dir = substitute(s:default_oradoc_dir, '\\\\\|\\', '/', 'g')

" Enable logging
if g:vorax_debug
  silent! call log#init('ALL', ['~/vorax.log'])
  silent! let s:log = log#getLogger(expand('<sfile>:t'))
endif

" oradoc object
let s:oradoc = { 'model' : [] }

" the name of the oradoc buffer
let s:oradoc_bname = '_vorax_oradoc'

" The interface object
let s:interface = Vorax_GetInterface()

" search into the indexes oracledoc for
" the provided pattern
function s:oradoc.Search(pattern) dict
  let swish_cmd = "swish-e -f " . shellescape(s:interface.convert_path(g:vorax_oradoc_index_file)) . 
                \ " -H0 " . 
                \ " -x " . shellescape('|%t| <doctitle> => %p\n') .
                \ " -w " . shellescape(a:pattern)
  let output = system(swish_cmd)
  if v:shell_error == 0
    " remove the redundant Oracle(R)... shrink the line and the output is easier to read
    let output = substitute(output, 'Oracle\%xae', '', 'g')
    " remove \r, if any
    let output = substitute(output, '\r', '', 'g')
    " populate the model with the corresponding doc links
    let output_list = split(output, '\n')
    if len(output_list) > 0
      let self.model = []
      for line in output_list
        let parts = split(line, ' => ')
        if len(parts) == 2
          " two parts are expected
          call add(self.model, parts[1])
        endif
      endfor
      let bufwin_content = []
      for line in output_list
        call add(bufwin_content, substitute(line, ' => .*$', '', 'g'))
      endfor
      call s:ShowOradocWindow()
      setlocal modifiable
      normal ggdG
      call append(0, bufwin_content)
      setlocal nomodifiable
      normal gg
    else
      echo g:vorax_messages['no_help']
    endif
  else
    echo g:vorax_messages['help_search_error']
  endif
endfunction

" indexes the provided oradoc dir.
function s:oradoc.Index(oradoc_dir) dict
  if a:oradoc_dir == ''
    " default location
    let oradoc_dir = s:default_oradoc_dir
  else
    let oradoc_dir = a:oradoc_dir
  endif
  let swish_cmd = "swish-e -f " . shellescape(s:interface.convert_path(g:vorax_oradoc_index_file)) . 
                \ " -c " . shellescape(s:interface.convert_path(g:vorax_oradoc_config_file)) . 
                \ " -i " . shellescape(s:interface.convert_path(oradoc_dir))
  exe "!" . swish_cmd
endfunction

function s:ShowOradocWindow()
  silent! call s:log.trace('start s:oradoc.ShowOradocWindow()')
  let buf_nr = bufnr(s:oradoc_bname)
  silent! call s:log.debug('buf_nr='.buf_nr)
  if buf_nr == -1
    " the result buffer was closed, create a new one
    silent! exec g:vorax_oradoc_geometry . ' new'
    silent! exec "edit " . s:oradoc_bname
  else
    " is the buffer visible?
    let win_nr = bufwinnr(buf_nr)
    silent! call s:log.debug('win_nr='.win_nr)
    if win_nr == -1
      " it is not visible
      silent! exec g:vorax_oradoc_geometry . 'split'
      silent! exec "edit " .s:oradoc_bname
    else
      exec win_nr . "wincmd w"
      return
    endif
  endif
  setlocal winfixwidth
  setlocal noswapfile
  setlocal nowrap
  setlocal foldcolumn=0
  setlocal nospell
  setlocal nonu
  setlocal cursorline
  setlocal buftype=nofile
  setlocal nomodifiable
  setlocal syntax=voraxdoc
  " configure mappings
  nmap <buffer> <cr> :call <SID>OpenLink()<cr>
  nmap <buffer> o :call <SID>OpenLink()<cr>
  nmap <buffer> q :close<cr>
endfunction

" Opens the provided link into the configured browser.
function s:OpenLink()
  if line('.') - 1 <= len(s:oradoc.model)
    let link = s:interface.convert_path(s:oradoc.model[line('.') - 1])
    " no backslashes please
    let link = substitute(link, '\\', '/', 'g')
    let cmd = substitute(g:vorax_oradoc_open_with, '%u', link, 'g')
    exe cmd
    " redraw vim. sometimes the launched external browser mess up vim
    redraw!
    " close oradoc buffer?
    if g:vorax_oradoc_autoclose
      silent! close
    endif
  endif
endfunction

" Get the oradoc object
function Vorax_OradocToolkit()
  return s:oradoc
endfunction
