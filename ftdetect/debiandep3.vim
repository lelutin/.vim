" override the default type for .patch files when in the right directory
au BufNewFile,BufRead */debian/patches/*.patch	if &ft == 'diff' | set ft=debdep3 | endif
