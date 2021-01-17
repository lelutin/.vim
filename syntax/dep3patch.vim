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

syn region dep3patchHeaders start="\%^" end="^\%(---\)\@=" contains=dep3patchKey,dep3patchMultiField

syn case ignore

syn region dep3patchMultiField matchgroup=dep3patchKey start="^\z(#\s\)\?\zs\%(Description\|Subject\)\ze:\s*" skip="^\z1\s" end="^$"me=s-1 end="^"me=s-1 contained contains=@Spell
syn region dep3patchMultiField matchgroup=dep3patchKey start="^\%(#\s\)\?\zsOrigin\ze:\s*" end="$" contained contains=dep3patchHTTPUrl,dep3patchCommitID,dep3patchOriginCategory oneline keepend
syn region dep3patchMultiField matchgroup=dep3patchKey start="^\%(#\s\)\?\zsBug\%(-[[:graph:]]\+\)\?\ze:\s*" end="$" contained contains=dep3patchHTTPUrl oneline keepend
syn region dep3patchMultiField matchgroup=dep3patchKey start="^\%(#\s\)\?\zsForwarded\ze:\s*" end="$" contained contains=dep3patchHTTPUrl,dep3patchForwardedShort oneline keepend
syn region dep3patchMultiField matchgroup=dep3patchKey start="^\%(#\s\)\?\zs\%(Author\|From\)\ze:\s*" end="$" contained contains=dep3patchEmail oneline keepend
syn region dep3patchMultiField matchgroup=dep3patchKey start="^\%(#\s\)\?\zs\%(Reviewed-by\|Acked-by\)\ze:\s*" end="$" contained contains=dep3patchEmail oneline keepend
syn region dep3patchMultiField matchgroup=dep3patchKey start="^\%(#\s\)\?\zsLast-Updated\ze:\s*" end="$" contained contains=dep3patchISODate oneline keepend
syn region dep3patchMultiField matchgroup=dep3patchKey start="^\%(#\s\)\?\zsApplied-Upstream\ze:\s*" end="$" contained contains=dep3patchHTTPUrl,dep3patchCommitID oneline keepend

syn match dep3patchHTTPUrl contained "\vhttps?://[[:alnum:]][-[:alnum:]]*[[:alnum:]]?(\.[[:alnum:]][-[:alnum:]]*[[:alnum:]]?)*\.[[:alpha:]][-[:alnum:]]*[[:alpha:]]?(:\d+)?(/[^[:space:]]*)?$"
syn match dep3patchCommitID contained "commit:[[:alnum:]]\+"
syn match dep3patchOriginCategory contained "\%(upstream\|backport\|vendor\|other\), "
syn match dep3patchForwardedShort contained "\%(yes\|no\|not-needed\), "
syn match dep3patchEmail "[_=[:alnum:]\.+-]\+@[[:alnum:]\./\-]\+"
syn match dep3patchEmail "<.\{-}>"
syn match dep3patchISODate "[[:digit:]]\{4}-[[:digit:]]\{2}-[[:digit:]]\{2}"

" Associate our matches and regions with pretty colours
hi def link dep3patchKey            Keyword
hi def link dep3patchOriginCategory Keyword
hi def link dep3patchForwardedShort Keyword
hi def link dep3patchMultiField     Normal
hi def link dep3patchHTTPUrl        Identifier
hi def link dep3patchCommitID       Identifier
hi def link dep3patchEmail          Identifier
hi def link dep3patchISODate        Identifier

let b:current_syntax = 'dep3patch'

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: ts=8 sw=2
