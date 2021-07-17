" override the default type for .patch files when in the right directory
fun s:DetectDep3Patch()
  if expand('%:t') ==# 'series'
    return
  endif

  let lnum = 1
  while lnum < 100 && lnum < line('$')
    let ltext = getline(lnum)
    if ltext =~# '^\%(Description\|Subject\|Origin\|Bug\|Forwarded\|Author\|From\|Reviewed-by\|Acked-by\|Last-Updated\|Applied-Upstream\):'
      set filetype=dep3patch
      return
    elseif ltext =~# '^---'
      " end of headers found. stop processing
      return
    endif
    let lnum += 1
  endwhile
endfun

augroup vimdebian
  au BufNewFile,BufRead */debian/patches/* call s:DetectDep3Patch()
augroup END
