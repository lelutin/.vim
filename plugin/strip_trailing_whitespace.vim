" death to trailing spaces
function ShowSpaces(...)
  let @/='\v(\s+$)|( +\ze\t)'
  let oldhlsearch=&hlsearch
  if !a:0
    let &hlsearch=!&hlsearch
  else
    let &hlsearch=a:1
  end
  return oldhlsearch
endfunction

function StripTrailingWhitespace() range
  let oldhlsearch=ShowSpaces(1)
  execute a:firstline.','.a:lastline.'substitute ///ge'
  let &hlsearch=oldhlsearch
endfunction
