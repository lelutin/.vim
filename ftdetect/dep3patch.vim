" override the default type for .patch files when in the right directory
augroup vimdebian
  au BufNewFile,BufRead */debian/patches/*.patch	if &ft == 'diff' | set ft=dep3patch | endif
augroup END
