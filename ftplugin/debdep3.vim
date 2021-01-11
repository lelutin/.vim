" Vim filetype plugin file (Omni completion)
" Language:     Debian DEP3 Patch Headers
" Maintainer:   Gabriel Filion <gabster@lelutin.ca>
" Last Change:  2021-01-10
" License:      Vim License

" Do these settings once per buffer
if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin=1

fun! Dep3Headers(findstart, base)
  if a:findstart
    let line = getline('.')
  else  " find and return completion matches
    let completions = []
    " include in matches: 'word', 'menu' (relations to other fields), 'info' (definition text
    " from the DEP3 page), 'icase'
    return completions
  endif
endfun

set omnifunc=Dep3Headers

