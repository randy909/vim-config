" Description: Overwrite settings for plsql file type
" Mainainder: Alexandru Tica <alexandru.tica.at.gmail.com>
" License: Apache License 2.0

" switch to vorax completion
setlocal omnifunc=Vorax_Complete

" defines vorax mappings for the current buffer
" defines vorax mappings for the current buffer
if !exists('*Vorax_UtilsToolkit')
  runtime! vorax/lib/vim/vorax_utils.vim
endif

let utils = Vorax_UtilsToolkit()
call utils.CreateBufferMappings()

" we don't have indenting for plsql therefore indent 
" like an sql file please
exec 'runtime indent/sql.vim'

" tag plsql files as sqls
if exists('loaded_taglist')
  let tlist_plsql_settings='sql;c:cursor;F:field;P:package;r:record;' .
        \ 's:subtype;t:table;T:trigger;v:variable;f:function;p:procedure'
endif

" take $# as word characters
setlocal isk+=$
setlocal isk+=#

" matchit functionality 
" Some standard expressions for use with the matchit strings
let s:notend = '\%(\<end\s\+\)\@<!'
let s:when_no_matched_or_others = '\%(\<when\>\%(\s\+\%(\%(\<not\>\s\+\)\?<matched\>\)\|\<others\>\)\@!\)'
let s:or_replace = '\%(or\s\+replace\s\+\)\?'

" Define patterns for the matchit macro
let b:match_words =
                \ '\(^\s*\)\@<=\(\<\%(for\|while\|loop\)\>.*\):'.
                \ '\%(\<exit\>\|\<leave\>\|\<break\>\|\<continue\>\):'.
                \ '\%(\<end\s\+\<loop\>\),' .
                \ s:notend . '\<if\>:'.
                \ '\<elsif\>\|\<elseif\>\|\<else\>:'.
                \ '\<end\s\+if\>,'.
                \ '\<begin\>:'.
                \ '\%(\<end\>\s*\(\(\<if\>\|\<loop\>\)\@!.\)*$\),' 

