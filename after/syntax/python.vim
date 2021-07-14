" To load the syntax file we need b:current_syntax to be empty. We'll restore
" the current value after we've injected it into python strings
let s:cur_syn = b:current_syntax
unlet! b:current_syntax
" Avoid loading more sub-language syntax files. Loading them causes lots of
" errors and makes vim super slow
let g:rst_syntax_code_list = {}
syn include @pythonRst syntax/rst.vim

" Copied from vim's builtin python syntax file. make sure to keep up to date
syn region  pythonString matchgroup=pythonTripleQuotes
      \ start=+[uU]\=\z('''\|"""\)+ end="\z1" keepend
      \ contains=pythonEscape,pythonSpaceError,pythonDoctest,@pythonRst,@Spell
syn region  pythonRawString matchgroup=pythonTripleQuotes
      \ start=+[uU]\=[rR]\z('''\|"""\)+ end="\z1" keepend
      \ contains=pythonSpaceError,pythonDoctest,@pythonRst,@Spell

let b:current_syntax = s:cur_syn
