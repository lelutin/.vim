scriptencoding utf-8

" TODO find out how get first occurrence of a substring and then toggle
" between two chars
" TODO when it's working, move this out to autoload
"fun ToggleCheckmark()
"  " find × on line
"  let x_pos = getpos('×')
"  " change to ✓
"  " if not found:
"  "   find ✓ on line
"  "   change to ×
"  " endif
"endfun

augroup writeups
  " This is probably going to break apart if I end up moving the "writeups"
  " directory.
  " But it's always better to have templates and avoid having to think about
  " how other files are structured.
  " To mitigate the problem, the templates will be fetched from the same
  " directory. This way if I move the "writeups" directory I'll get errors that
  " show me what I done broke.
  autocmd BufNewFile ~/writeups/ressources/*.md 0r ~/writeups/templates/ressource.md
  autocmd BufNewFile ~/writeups/idées/*.md 0r ~/writeups/templates/idée.md
  autocmd BufNewFile ~/recettes/*.md 0r ~/recettes/archetypes/default.md
  autocmd BufNewFile ~/writeups/checklists/*.md 0r ~/writeups/templates/checklist.md

  " To make it easier to manage checklists, it's fun to be able to toggle
  " between checked and unchecked
  "autocmd BufEnter ~/writeups/checklists/*.md nnoremap <silent> <c-c> :call ToggleCheckmark()<CR>
  " this doesn't toggle, but at least it lets me change an entry into a checked
  " one
  autocmd BufEnter ~/writeups/checklists/*.md nnoremap <silent> <c-c> :s/\[×\]/[✓]/<CR>
augroup END
