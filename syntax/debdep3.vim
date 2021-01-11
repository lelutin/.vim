" Vim syntax file
" Language:    Debian DEP3 Patch headers
" Maintainer:  Gabriel Filion <gabster@lelutin.ca>
" Last Change: 2021-01-09
"
" Specification of the DEP3 patch header format is available at:
"   https://dep-team.pages.debian.net/deps/dep3/

" Standard syntax initialization
if exists('b:current_syntax')
  finish
endif

runtime! syntax/diff.vim
unlet! b:current_syntax

let s:cpo_save = &cpo
set cpo&vim

syn region debdep3Headers start="\%^" end="^\(---\)\@=" contains=debdep3Key,debdep3MultiField

syn case ignore

syn region debdep3MultiField matchgroup=debdep3Key start="^\(Description\|Subject\)\ze: *" skip="^[ \t]" end="^$"me=s-1 end="^[^ \t#]"me=s-1 contained contains=@Spell
syn region debdep3MultiField matchgroup=debdep3Key start="^Origin\ze: *" end="$" contained contains=debdep3HTTPUrl,debdep3CommitID,debdep3OriginCategory oneline keepend
syn region debdep3MultiField matchgroup=debdep3Key start="^Bug\%(-[[:graph:]]\+\)\?\ze: *" end="$" contained contains=debdep3HTTPUrl oneline keepend
syn region debdep3MultiField matchgroup=debdep3Key start="^Forwarded\ze: *" end="$" contained contains=debdep3HTTPUrl,debdep3ForwardedShort oneline keepend
syn region debdep3MultiField matchgroup=debdep3Key start="^\(Author\|From\)\ze: *" end="$" contained contains=debdep3Email oneline keepend
syn region debdep3MultiField matchgroup=debdep3Key start="^\(Reviewed-by\|Acked-by\)\ze: *" end="$" contained contains=debdep3Email oneline keepend
syn region debdep3MultiField matchgroup=debdep3Key start="^Last-Updated\ze: *" end="$" contained contains=debdep3ISODate oneline keepend
syn region debdep3MultiField matchgroup=debdep3Key start="^Applied-Upstream\ze: *" end="$" contained contains=debdep3HTTPUrl,debdep3CommitID oneline keepend

syn match debdep3HTTPUrl contained "\vhttps?://[[:alnum:]][-[:alnum:]]*[[:alnum:]]?(\.[[:alnum:]][-[:alnum:]]*[[:alnum:]]?)*\.[[:alpha:]][-[:alnum:]]*[[:alpha:]]?(:\d+)?(/[^[:space:]]*)?$"
syn match debdep3CommitID contained "commit:[[:alnum:]]\+"
syn match debdep3OriginCategory contained "\(upstream\|backport\|vendor\|other\), "
syn match debdep3ForwardedShort contained "\(yes\|no\|not-needed\), "
syn match debdep3Email "[_=[:alnum:]\.+-]\+@[[:alnum:]\./\-]\+"
syn match debdep3Email "<.\{-}>"
syn match debdep3ISODate "[[:digit:]]\{4}-[[:digit:]]\{2}-[[:digit:]]\{2}"

" Associate our matches and regions with pretty colours
hi def link debdep3Key            Keyword
hi def link debdep3OriginCategory Keyword
hi def link debdep3ForwardedShort Keyword
hi def link debdep3MultiField     Normal
hi def link debdep3HTTPUrl        Identifier
hi def link debdep3CommitID       Identifier
hi def link debdep3Email          Identifier
hi def link debdep3ISODate        Identifier

let b:current_syntax = 'debdep3'

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: ts=8 sw=2
