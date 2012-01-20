" Description: The VoraX Database Explorer
" Mainainder: Alexandru Tica <alexandru.tica.at.gmail.com>
" License: Apache License 2.0

" no multiple loads allowed
if exists("s:vorax_dbexplorer")
  finish
endif

" Logger reference
silent! let s:log = log#getLogger(expand('<sfile>:t'))

" flag to signal this source was loaded
let s:vorax_dbexplorer = 1

" The title of the vorax db explorer
let s:db_explorer_title = 'Vorax-DbExplorer'

" Initialize the tree
function! Vorax_DbExplorerInit()
  let b:VrxTree_GetSubNodesFunction = 'Vorax_DbExplorerGetNodes'
  let b:VrxTree_IsLeafFunction = 'Vorax_DbExplorerIsLeaf'
  let b:VrxTree_ColorFunction="Vorax_InitColors"  
  let b:VrxTree_OnLeafClick="Vorax_DbExplorerClick"
  let b:VrxTree_InitMappingsFunction="Vorax_InitMappings"
  let b:VrxTree_pathSeparator='"'
  setlocal foldcolumn=0
  setlocal winfixwidth
  setlocal buftype=nofile
  setlocal nobuflisted
  setlocal nospell
  setlocal nonu
  setlocal cursorline
  setlocal noswapfile
  setlocal hid
endfunction

" Toggle on/off the dbexplorer
function Vorax_DbExplorerToggle()
  if !exists('s:utils')
    let s:utils = {}
    let s:utils = Vorax_UtilsToolkit()
  endif
  if !exists('s:db')
    let s:db = {}
    let s:db = Vorax_DbLayerToolkit()
  endif
  let bnr = bufnr('^' . s:db_explorer_title . "$") 
  if bnr == -1
    let root = g:vorax_update_title ? &titlestring : '/'
    call VrxTree_NewTreeWindow(root, 
                            \  s:db_explorer_title, 
                            \  1, 
                            \  g:vorax_dbexplorer_side, 
                            \  g:vorax_dbexplorer_width, 
                            \  30, 
                            \ 'Vorax_DbExplorerInit')
  else
    call VrxTree_ToggleTreeWindow(s:db_explorer_title)
  endif
  redraw!
endfunction

" Rebuild the Vorax DB Explorer. This is needed especially
" after the connection was changed.
function Vorax_RebuildDbExplorer()
  let ts = VrxTree_GetSettings(s:db_explorer_title)
  let root = g:vorax_update_title ? &titlestring : '/'
  if has_key(ts, 'root') && ts['root'] != root
    " is the dbexplorer visible?
    let bnr = bufnr(s:db_explorer_title)
    if bnr != -1  
      " the buffer exists. is in a visible window?
      let wnr = bufwinnr(bnr) 
      if wnr != -1
        " the window is visible... focus it
        call VrxTree_FocusTreeWindow(s:db_explorer_title, 0)
      endif
    endif
  endif
endfunction

" Configures some key mappings
function! Vorax_InitMappings()
	noremap <silent> <buffer> o :call VrxTree_OpenNode()<CR>
	noremap <silent> <buffer> R :call VrxTree_RefreshNode()<CR>
  if g:vorax_key_for_describe != ""
    exe "noremap <silent> <buffer> " . g:vorax_key_for_describe . " :call <SID>DescribeCurrentObject(0)<CR>"
  endif
	if g:vorax_key_for_describe_verbose != ""
    exe "noremap <silent> <buffer>  " . g:vorax_key_for_describe_verbose . " :call <SID>DescribeCurrentObject(1)<CR>"
  endif
  
  " User defined mappings
  let handler = Vorax_GetEventHandler()
  call handler.dbexplorer_register_keys()
endfunction

" Get the nodes corresponding to the provided path
function! Vorax_DbExplorerGetNodes(path)
  if a:path == "" || a:path == "@"
    " no connection available
    return ""
  endif
  let root = g:vorax_update_title ? &titlestring : '/'
  if a:path == root
    return s:GenericCategories(1)
  elseif a:path =~ '^"\?[^"]\+"Users$'
    let result = vorax#Exec("select username from all_users order by 1;", 0, g:vorax_messages['reading'])
    return join(result, "\n")
  elseif a:path =~ '^"\?[^"]\+"Users"[^"]\+$'
    return s:GenericCategories(0)
  elseif a:path =~ '^"\?[^"]\+"[^"]\+$' || a:path =~ '^"\?[^"]\+"Users"[^"]\+"[^"]\+$'
    " a generic category under the current user or another one
    let category = s:ObjectType(a:path)
    if category == "MVIEW"
      let category = "MATERIALIZED VIEW"
    endif
    let user = 'user'
    let parts = split(a:path, b:VrxTree_pathSeparator)
    if len(parts) == 4
      let user = "'" . parts[-2] . "'"
    endif
    let result = vorax#Exec("select object_name from all_objects where owner = " . user . " and object_type = '" . category . "' order by 1;", 0, g:vorax_messages['reading'])
    return join(result, "\n")
  elseif a:path =~ '^"\?[^"]\+"Packages"[^"]\+$' || a:path =~ '^"\?[^"]\+"Users"[^"]\+"Packages"[^"]\+$'
    let user = 'user'
    let parts = split(a:path, b:VrxTree_pathSeparator)
    if len(parts) == 5
      let user = "'" . parts[-3] . "'"
    endif
    let package = s:ObjectName(a:path)
    let result = vorax#Exec("select distinct decode(type, 'PACKAGE', 'Spec', 'Body') from all_source where owner = " . user . " and name = '" . package . "' order by 1 desc;\n", 0, g:vorax_messages['reading'])
    if len(result) >= 1 && result[-1] == 'Body' 
      let result += ['Both']
    endif
    return join(result, "\n")
  endif
endfunction

" Describes the selected object from the DbExplorer
function s:DescribeCurrentObject(verbose)
  let path = VrxTree_GetPathUnderCursor()
  let object_name = s:ObjectName(path)
  if object_name != 'Spec' && object_name != 'Body' && object_name != 'Both'
    let user = ""
    if (path =~ '^"\?[^"]\+"[^"]\+"' && path !~ '^"\?[^"]\+"Users"') || path =~ '^"\?[^"]\+"Users"[^"]\+"[^"]\+"'
      let user = split(&titlestring, '@')[0]
      if path =~ '^"\?[^"]\+"Users'
        let user = split(path, b:VrxTree_pathSeparator)[2]
      endif 
      if !a:verbose
        call vorax#Describe(user . '.' . object_name)
      else
        call vorax#DescribeVerbose(user . '.' . object_name)
      endif
    endif
  endif
endfunction

" Return the generic categories for the DbExplorer tree.
" If a:include_users is 1 then the USERS generic node is
" also returned. Basically, include_users should be 1 if
" the current user is expanded and 0 if object belonging to
" others are browsed.
function s:GenericCategories(include_users)
  let categories = "Tables\n" .
        \  "Views\n" . 
        \  "Procedures\n" .
        \  "Functions\n" . 
        \  "Packages\n" .
        \  "Synonyms\n" .
        \  "Types\n" .
        \  "Triggers\n" .
        \  "Sequences\n" .
        \  "MViews\n"
  if a:include_users
    let categories .= "Users\n" 
  endif
  return categories
endfunction

" Does the provided node has children?
function! Vorax_DbExplorerIsLeaf(path)
  let parts = split(a:path, b:VrxTree_pathSeparator)
  if type(parts) == 3 && len(parts) >= 3
    if ((len(parts) == 3 || len(parts) == 5) && parts[-2] == 'Packages') 
        \ || (parts[-1] == 'Users' && len(parts) == 2) 
        \ || (len(parts) == 3 && parts[-2] == 'Users')
        \ || (len(parts) == 4 && parts[1] == 'Users')
      " the package has spec and body
      return 0
    else
      return 1
    endif
  else
    return 0
  endif
endfunction

" Open the database object on click
function! Vorax_DbExplorerClick(path)
  silent! call s:log.trace('start Vorax_DbExplorerClick(path) => path=' . a:path)
  let object_name = s:ObjectName(a:path)
  let subtype = ""
  if object_name == 'Spec' || object_name == 'Body' || object_name == 'Both'
    let subtype = object_name
    if a:path =~ '^"\?[^"]\+"Packages'
      let object_name = split(a:path, b:VrxTree_pathSeparator)[2]
    elseif a:path =~ '^"\?[^"]\+"Users"[^"]\+"Packages'
      let object_name = split(a:path, b:VrxTree_pathSeparator)[-2]
    endif
  endif
  echon s:utils.Translate(g:vorax_messages['load_wait'], object_name)
  if a:path =~ '^"\?[^"]\+"[^"]\+"'
    let type = s:ObjectType(a:path)
    let user = 'user'
    if a:path =~ '^"\?[^"]\+"Users'
      let user = "'" . split(a:path, b:VrxTree_pathSeparator)[2] . "'"
    endif 
    if a:path =~ '^"\?[^"]\+"Packages' || a:path =~ '^"\?[^"]\+"Users"[^"]\+"Packages'
      if subtype == 'Spec'
        let type = 'PACKAGE_SPEC'
      elseif subtype == 'Body'
        let type = 'PACKAGE_BODY'
      elseif subtype == 'Both'
        let type = 'PACKAGE'
      endif
    elseif a:path =~ '^"\?[^"]\+"Types' || a:path =~ '^"\?[^"]\+"Users"[^"]\+"Types'
      if subtype == 'Spec'
        let type = 'TYPE_SPEC'
      elseif subtype == 'Body'
        let type = 'TYPE_BODY'
      elseif subtype == 'Both'
        let type = 'TYPE'
      endif
    endif
    if type == 'MVIEW'
      let type = "MATERIALIZED_VIEW"
    endif
    let fname = object_name . '.' . s:utils.ExtensionForType(type)
    let tname = substitute(fnamemodify(tempname(), ':h:p:8'), '\\', '/', 'g') . '/' . fname
    let bwn = bufwinnr('^' . fname . '$')
    silent! call s:log.debug('bwn=' . bwn)
    if bwn == -1
      " no buffer with this name
      let response = ''
      if g:vorax_dbexplorer_object_over_file == 2
        if filereadable(fname)
          let response = input(s:utils.Translate(g:vorax_messages['dbexpl_edit_file_confirmation'], fname, 'E'))
          if response !=? 'e'
            " set up a temp file
            let fname = tname
          endif
        else
          " set up a temp file
          let fname = tname
        endif
      elseif g:vorax_dbexplorer_object_over_file == 1
        let response = 'e'
      else
        let fname = tname
      endif
      silent! call s:log.debug('fname=' . fname)
      call s:utils.FocusCandidateWindow()
      silent! call s:log.debug('candidate window focused')
      exe 'edit ' . fname
      call vorax#InitBuffer()
      if response !=? 'e'
        " clear buffer
        normal ggdG
        " get source
        let result = s:db.GetSource(type, object_name, user)
        call append(0, result)
        " delete the leading blanks from the first line... the dbms_metadata.getddl
        " puts some blanks before the CREATE statement
        :1s/^\s*//
        " clear the previous highlight
        :nohlsearch
        " go to the start of the buffer
        normal gg
        silent! exe 'w! ' 
        " update tags on the fly. I know it's stupid but I didn't find any other good 
        " way of refreshing the Tlist window.
        silent! TlistUpdate
        silent! TlistToggle
        silent! TlistToggle
      endif
    else
      " just show the window
      exe bwn . 'wincmd w'
    endif
  endif
  redraw
  echo g:vorax_messages['done']
endfunction

" Nice colors for generic categories
function! Vorax_InitColors () 
  syn match Directory  '\(+\|-\).\+'
  hi link Directory  Comment
endfunction 

" Get the object type for the provided path.
function s:ObjectType(path)
  let parts = split(a:path, b:VrxTree_pathSeparator)
  if len(parts) >= 2 && parts[1] != 'Users'
    " under the user tree
    let type = parts[1]
  else
    " under the other users tree
    let type = parts[3]
  endif
  " get rid of the final 's'
  let type = strpart(type, -1, strlen(type))
  let type = toupper(type)
  return type
endfunction

" Get the object name corresponding to the provide path
function s:ObjectName(path)
  return substitute(a:path, '.*"', '', 'g')
endfunction

