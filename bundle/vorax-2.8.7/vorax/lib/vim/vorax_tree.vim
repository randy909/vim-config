" An abstract tree implementation for vim. This is based on the tree plugin
" of Yury Altukhou.

let s:settings = {}

" global functions

" Creates a new Tree.
"   initialPath = the root of the tree
"   title = the title of the tree window
"   vertical = [1|0], if 1 the split is vertical, otherwise is horizontal
"   side = [1|0], if 1 then right/bottom; if 0 then left/top
"   minWidth = the minimum width of the tree window
"   minHeight = the minimum height of the tree window
"   initOptionsFunction = a function name used to specify other custom initialization settings
function! VrxTree_NewTreeWindow (initialPath, title, vertical, side, minWidth, minHeight, initOptionsFunction) "{{{1
  if a:vertical
    let splitcmd = (a:side == 0 ? 'topleft' : 'botright') . ' vertical ' . a:minWidth.'new'
  else
    let splitcmd = (a:side == 0 ? 'topleft' : 'botright') . ' ' . a:minWidth.'new'
  endif
  " save the provided settings, they will be needed when we're about to toggle
  let s:settings[a:title] = {}
  let s:settings[a:title]['root'] = a:initialPath
  let s:settings[a:title]['side'] = a:side
  let s:settings[a:title]['vertical'] = a:vertical
  let s:settings[a:title]['minWidth'] = a:minWidth
  let s:settings[a:title]['minHeight'] = a:minHeight 
  " split in order to make room for the tree
  call s:Split(splitcmd, a:title, a:side, a:minWidth, a:minHeight)
  " the initialization function reference is stored into a buffer variable
  let b:VrxTree_InitOptionsFunction = a:initOptionsFunction
  " init the new buffer
  call s:Init()
  " built the tree with the provided initial path
  call s:BuildTree(a:initialPath)
endfunction "}}}1

function! VrxTree_OpenNode()
  call s:OnDoubleClick()
endfunction

function! VrxTree_RefreshNode()
  let node = VrxTree_GetPathUnderCursor()
	let xpos=col ('.')-1
	let ypos=line ('.')
  if !s:IsLeaf(node) && getline (ypos)[xpos] == '-'
    call s:TreeNodeAction (xpos,ypos)
    call s:TreeNodeAction (xpos,ypos)
  endif
endfunction

function! VrxTree_GetSettings(title)
  if has_key(s:settings, a:title)
    return s:settings[a:title]
  else
    return {}
  endif
endfunction

function! VrxTree_FocusTreeWindow(title, toggle)
  let buf = bufnr('^' . a:title . '$')
  let root = g:vorax_update_title ? &titlestring : '/'
  if buf == -1
    " create new window
    throw 'VRX-2: Tree was not initialized.'
  else
    " is the buffer visible?
    let buf_win_nr = bufwinnr(buf)
    if buf_win_nr == -1
      " not visible
      if s:settings[a:title]['vertical']
        let splitcmd = (s:settings[a:title]['side'] == 0 ? 'topleft' : 'botright') . ' vertical ' . s:settings[a:title]['minWidth'].'new'
      else
        let splitcmd = (s:settings[a:title]['side'] == 0 ? 'topleft' : 'botright') . s:settings[a:title]['minWidth'].'new'
      endif
      call s:Split(splitcmd, 
                \ a:title, 
                \ s:settings[a:title]['side'], 
                \ s:settings[a:title]['minWidth'], 
                \ s:settings[a:title]['minHeight'])
    else
      " is visible, toggling means to close it
      exec buf_win_nr . "wincmd w"
      if a:toggle
        close!
      endif
    endif
    if s:settings[a:title]['root'] != root
      call VrxTree_SetPath(root)
      let s:settings[a:title]['root'] = root
    endif
  endif
endfunction

" Toggle the Tree
"   title = the title of the tree used at the time it was created
function! VrxTree_ToggleTreeWindow(title) "{{{1
  call VrxTree_FocusTreeWindow(a:title, 1)
endfunction "}}}1

function! VrxTree_RebuildTree () "{{{1
	call <SID>BuildTree (getline (1))
endfunction "}}}1

function! VrxTree_SetPath (path) "{{{1
	call <SID>BuildTree (a:path)
endfunction "}}}1

function! VrxTree_GetPathUnderCursor () "{{{1
	normal 1|g^
	let xpos=col ('.')-1
	let ypos=line ('.')
	return <SID>GetPathName (xpos,ypos)
endfunction "}}}1

function! GetNextLine (text) "{{{1
	let pos=match (a:text,"\n")
	return strpart (a:text,0,pos)
endfunction "}}}1

function! CutFirstLine (text) "{{{1
	let pos=match (a:text,"\n")
	return strpart (a:text,pos+1,strlen (a:text))
endfunction "}}}1

function! DummyFunction (...) "{{{1
endfunction "}}}1

" script private functions  

" split the window in order to make room for the tree
function! s:Split(cmd, title, side, minWidth, minHeight) "{{{1
	let SPR=&splitright
	let SPB=&splitbelow
	let &splitright=a:side
	let &splitbelow=a:side
  "exe "setlocal wiw=" . a:minWidth
  "exe "setlocal wh=" . a:minHeight
  exe a:cmd
  let bufnr = bufnr('^' . a:title . '$')
  silent! exec 'edit ' . a:title
  let &splitright = SPR
  let &splitbelow = SPB
	setlocal nowrap
endfunction "}}}1

function! s:Init() "{{{1
	let b:VrxTree_pathSeparator='/'
	let b:VrxTree_ColorFunction="DummyFunction"
	let b:VrxTree_InitMappingsFunction="DummyFunction"
	let b:VrxTree_IsLeafFunction="DummyFunction"
	let b:VrxTree_GetSubNodesFunction="DummyFunction"
	let b:VrxTree_OnLeafClick="DummyFunction"
	let b:VrxTree_OnPathChange="DummyFunction"
	call <SID>InitOptions ()
	call <SID>InitColors ()
	call <SID>InitMappings ()
endfunction "}}}1

function! s:InitMappings () "{{{1
	exec "call ".b:VrxTree_InitMappingsFunction."()"
	noremap <silent> <buffer> <LeftRelease> :call <SID>OnClick ()<CR>
	noremap <silent> <buffer> <CR> :call <SID>OnDoubleClick ()<CR>
	noremap <silent> <buffer> <Down> :call <SID>GotoNextEntry ()<CR>
	noremap <silent> <buffer> <Up> :call <SID>GotoPrevEntry ()<CR>
	noremap <silent> <buffer> <S-Down> :call <SID>GotoNextNode ()<CR>
	noremap <silent> <buffer> <S-Up> :call <SID>GotoPrevNode ()<CR>
	noremap <silent> <buffer> <BS> :call <SID>BuildParentTree ()<CR>
endfunction "}}}1

function! s:InitOptions () "{{{1
	execute "call ".b:VrxTree_InitOptionsFunction."()"
endfunction "}}}1

function! s:InitColors () "{{{1 
	execute "call ".b:VrxTree_ColorFunction."()"
endfunction "}}}1

function! s:BuildTree (initialPath) "{{{1
	let path=a:initialPath
	" unlock bufer
	call <SID>UnLockBuffer()
	" clean up
	normal ggdGd
	call setline (1,path)
	call <SID>LockBuffer()
	call <SID>TreeExpand (-1,1,path)
	" move to first entry
	norm ggj1|g^
	execut 'call '.b:VrxTree_OnPathChange."('".path."')"
endfunction "}}}1

function! s:TreeExpand (xpos,ypos,path) "{{{1
	let path=a:path
	" first get all subdirectories
	let nodelist=s:GetSubNodes (path)."\n"
	call s:AppendSubNodes(a:xpos,a:ypos,nodelist)
endfunction "}}}1

function! s:AppendSubNodes(xpos,ypos,nodeList) "{{{1
	call s:UnLockBuffer()
	" turn + into -
	if a:ypos!=1 "{{{2
		"normal ^
		if getline(a:ypos)[a:xpos]=='+'  "{{{3
			normal r-
		else
			normal hxi-
		endif "}}3
	endif "}}}2
	let nodeList=a:nodeList
	let row=a:ypos
  let parent = VrxTree_GetPathUnderCursor()
	while strlen (nodeList)>0 "{{{2
		" get next line
		let entry=GetNextLine (nodeList)
		let nodeList=CutFirstLine (nodeList)
		" add to tree 
		if entry!="" "{{{3 "spacing acordinally to type of the entry
			if s:IsLeaf(parent . b:VrxTree_pathSeparator . entry) "{{{4
				let entry=s:SpaceString (a:xpos+2).entry
			else
				let entry=s:SpaceString (a:xpos+1)."+".entry
			endif "}}}4
			call append (row,entry)
			let row=row+1
		endif "}}}3
	endw "}}}2
	call s:LockBuffer()
endfunction "}}}1

function! s:LockBuffer() "{{{1
	setlocal nomodifiable nomodified
endfunction "}}}1

function! s:UnLockBuffer() "{{{1
	setlocal modifiable
endfunction "}}}1

function! s:GetSubNodes (path) "{{{1
	execute "return ".b:VrxTree_GetSubNodesFunction.'(a:path)'
endfunction "}}}1

function! s:SpaceString (width) "{{{1
	let spacer=""
	let width=a:width
	while width>0
		let spacer=spacer." "
		let width=width-1
	endwhile
	return spacer
endfunction "}}}1

function! s:IsLeaf (path) "{{{1
	execute "return ".b:VrxTree_IsLeafFunction.'(a:path)'
endfunction "}}}1

function! s:TreeNodeAction (xpos,ypos) "{{{1
	if getline (a:ypos)[a:xpos] == '+'
		call s:TreeExpand (a:xpos,a:ypos, s:GetPathName (a:xpos,a:ypos))
	elseif getline (a:ypos)[a:xpos] == '-'
		call s:TreeCollapse (a:xpos,a:ypos)
	end
endfunction "}}}1

function! s:IsTreeNode (xpos,ypos) "{{{1
	if getline (a:ypos)[a:xpos] =~ '[+-]'
		return 1
	else
		return 0
	end
endfunction "}}}1

function! s:GetPathName (xpos,ypos) "{{{1
	let xpos=a:xpos
	let ypos=a:ypos
	" check for directory..
	if getline (ypos)[xpos]=~"[+-]" "{{{2
		let path=b:VrxTree_pathSeparator.strpart (getline (ypos),xpos+1,col ('$'))
	else
		" otherwise filename
		let path=b:VrxTree_pathSeparator.strpart (getline (ypos),xpos,col ('$'))
		let xpos=xpos-1
	end "}}}2
	" walk up tree and append subpaths
	let row=ypos-1
	let indent=xpos
	while indent>0 "{{{2
		" look for prev ident level
		let indent=indent-1
		while getline (row)[indent] != '-' "{{{3
			let row=row-1
			if row == 0 "{{{4
				return ""
			end "}}}4
		endwhile "}}}3
		" subpath found, append
		let path=b:VrxTree_pathSeparator.strpart (getline (row),indent+1,strlen (getline (row))).path
	endwhile  "}}}2
	" finally add base path
	" not needed, if in root
	"if getline (1)!=b:VrxTree_pathSeparator "{{{2
	if a:ypos>1 "{{{2
		let path=getline (1).path
	end "}}}2
	return path
endfunction "}}}1

function! s:TreeCollapse (xpos,ypos) "{{{1
	call <SID>UnLockBuffer ()
	" turn - into +, go to next line
	let entry=substitute(getline(a:ypos),'^\s*+','','')
	if s:IsLeaf(entry)
		normal ^r j
	else
		normal ^r+j
	end
	" delete lines til next line with same indent
	while (getline ('.')[a:xpos+1] =~ '[ +-]') && (line ('$') != line ('.')) "{{{2
		norm dd
	endwhile "}}}2
	" go up again
	normal k
	call <SID>LockBuffer()
endfunction "}}}1

function! s:CloseExplorer () "{{{1
	wincmd c
endfunction "}}}1

function! s:BuildParentTree () "{{{1
	normal gg$F/
	call <SID>OnDoubleClick ()
endfunction "}}}1

function! s:GotoNextNode () "{{{1
	" in line 1 like next entry
	if line ('.')==1 "{{{2
		call s:GotoNextEntry ()
	else
		normal j1|g^
		while getline ('.')[col ('.')-1] !~ "[+-]" && line ('.')<line ('$') "{{{3
			normal j1|g^
		endwhile "}}}3
	endif "}}}2
endfunction "}}}1

function! s:GotoPrevNode () "{{{1
	" entering base path section?
	if line ('.')<3 "{{{2
		call <SID>GotoPrevEntry ()
	else
		normal k1|g^
		while getline ('.')[col ('.')-1] !~ "[+-]" && line ('.')>1 "{{{3
			normal k1|g^
		endwhile "}}}3
	endif "}}}2
endfunction "}}}1

function! s:GotoNextEntry () "{{{1
	let xpos=col ('.')
	" different movement in line 1
	if line ('.')==1 "{{{2
		" if over slash, move one to right
		if getline ('.')[xpos-1]==b:VrxTree_pathSeparator "{{{3
			normal l
			" only root path there, move down
			if col ('.')==1 "{{{4
				norm j1|g^
			end "}}}4
		else
			" otherwise after next slash
			execute "norm f".b:VrxTree_pathSeparator."l"
			" if already last path, move down
			if col ('.')==xpos "{{{4
				norm j1|g^
			endif "}}}4
		endif "}}}3
	else
		" next line, first nonblank
		normal j1|g^
	endif "}}}2
endf "}}}1

function! s:GotoPrevEntry () "{{{1
	" different movement in line 1
	if line ('.')==1 "{{{2
		" move after prev slash
		exec "norm hF".b:VrxTree_pathSeparator."l"
	else
		" enter line 1 at the end
		if line ('.')==2 "{{{3
			exec 'norm k$F'.b:VrxTree_pathSeparator.'l'
		else
			" prev line, first nonblank
			normal k1|g^
		endif "}}}3
	endif "}}}2
endfunction "}}}1

"

"TODO rewrite this function ( I do not like how it looks like)
function! s:OnDoubleClick () "{{{1
	let xpos=col ('.')-1
	let ypos=line ('.')
	" clicked on node
	if s:IsTreeNode (xpos,ypos) "{{{2
		call s:TreeNodeAction (xpos,ypos)
	else
		" go to first non-blank when line>1
		if ypos>1 "{{{3
			normal 1|g^
			let xpos=col ('.')-1
			" check, if it's a directory
			let path=<SID>GetPathName (xpos,ypos)
			if !<SID>IsLeaf (path) "{{{4
				" build new root structure
				"call <SID>BuildTree (path)
        call s:TreeNodeAction (xpos,ypos)
			else
				" try to resolve filename
				" and open in other window
				let path=<SID>GetPathName(xpos,ypos)
				call <SID>OnLeafClick(path)
			end "}}}4
		else
			" we're on line 1 here! getting new base path now...
			" advance to next slash
			if getline (1)[xpos]!=b:VrxTree_pathSeparator "{{{4
				execute "normal f".b:VrxTree_pathSeparator
				" no next slash -> current directory, just rebuild
				if col ('.')-1==xpos "{{{5
					call <SID>BuildTree (getline (1))
					return
				end "}}}5
			end "}}}4
			" cut ending slash
			normal h
			" rebuild tree with new path
			call <SID>BuildTree (strpart (getline (1),0,col ('.')))
		en "}}}3
	end "}}}2
endfunction "}}}1

function! s:OnClick () "{{{1
	let xpos=col ('.')-1
	let ypos=line ('.')
	if s:IsTreeNode (xpos,ypos) "{{{2
		call s:TreeNodeAction (xpos,ypos)
	endif "}}}2
endfunction "}}}1

function! s:OnLeafClick (path) "{{{1
	execute "call ".b:VrxTree_OnLeafClick."('".a:path."')"
endfunction "}}}1
" vim:fdm=marker:

