runtime! after/ftplugin/line_numbers.vim

setlocal foldmethod=indent

" after line_numbers I know there must be a value for b:undo_ftplugin
let b:undo_ftplugin .= ' | setlocal foldmethod<'
