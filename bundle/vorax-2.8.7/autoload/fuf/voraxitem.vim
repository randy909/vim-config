if exists('g:loaded_autoload_fuf_voraxitem') || v:version < 702
  finish
endif

let g:loaded_autoload_fuf_voraxitem = 1

let s:sql_dir = fnamemodify(expand('<sfile>:p:h') . '/../../vorax/sql/', ':p:8')
let s:sql_dir = substitute(s:sql_dir, '\\\\\|\\', '/', 'g')

function fuf#voraxitem#createHandler(base)
  return a:base.concretize(copy(s:handler))
endfunction

function fuf#voraxitem#getSwitchOrder()
  return -1
endfunction

function fuf#voraxitem#renewCache()
endfunction

function fuf#voraxitem#requiresOnCommandPre()
  return 0
endfunction

function fuf#voraxitem#onInit()
endfunction

function fuf#voraxitem#launch(initialPattern, partialMatching, prompt, listener)
  let s:interface = Vorax_GetInterface()
  let s:prompt = (empty(a:prompt) ? '>' : a:prompt)
  let s:listener = a:listener
  if exists('s:items')
    unlet s:items
  endif
  call fuf#launch(s:MODE_NAME, a:initialPattern, a:partialMatching)
endfunction

let s:MODE_NAME = expand('<sfile>:t:r')

let s:handler = {}

function s:handler.getModeName()
  return s:MODE_NAME
endfunction

function s:handler.getPrompt()
  if exists('*fuf#addMode')
    " for the new 4.2.x version
    return fuf#formatPrompt(s:prompt, self.partialMatching, '')
  else
    " for the old version
    return fuf#formatPrompt(s:prompt, self.partialMatching)
  endif
endfunction

function s:handler.getPreviewHeight()
  return 0
endfunction

function s:handler.targetsPath()
  return 0
endfunction

function s:handler.isOpenable(enteredPattern)
  return 1
endfunction

function s:handler.makePatternSet(patternBase)
  let parser = 's:interpretPrimaryPatternForNonPath'
  return fuf#makePatternSet(a:patternBase, parser, self.partialMatching)
endfunction

function s:handler.makePreviewLines(word, count)
  return []
endfunction

function s:handler.getCompleteItems(patternPrimary)
  if g:vorax_min_fuzzy_chars < 3
    " the minumum typed chars must not be lower than 3
    let g:vorax_min_fuzzy_chars = 3
  endif
  if len(a:patternPrimary) == g:vorax_min_fuzzy_chars && !exists('s:items')
    " escape special LIKE chars
    let pattern = substitute(a:patternPrimary, '\(%\|_\)', '`\1', 'g')
    echo g:vorax_messages['fuzzy_build'] . pattern  
    let vrx_script = s:interface.convert_path(s:sql_dir. "/search.sql")
    let s:items = vorax#Exec('@' . vrx_script . "  " .shellescape(toupper(pattern)), 'Loading items...', 0)
    call map(s:items, 'fuf#makeNonPathItem(v:val, "")')
    call fuf#mapToSetSerialIndex(s:items, 1)
    echo 'Done'
    return s:items
  else
    if exists('s:items') && len(a:patternPrimary) < g:vorax_min_fuzzy_chars 
      unlet s:items
    elseif exists('s:items') && len(a:patternPrimary) > g:vorax_min_fuzzy_chars 
      return s:items
    endif
  endif
  return []
endfunction

function s:handler.onOpen(word, mode)
  call s:listener.onComplete(a:word, a:mode)
endfunction

function s:handler.onModeEnterPre()
endfunction

function s:handler.onModeEnterPost()
endfunction

function s:handler.onModeLeavePost(opened)
  if !a:opened && exists('s:listener.onAbort()')
    call s:listener.onAbort()
  endif
endfunction

