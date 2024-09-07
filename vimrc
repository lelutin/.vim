" This is going to be buggy until https://github.com/Vimjas/vint/issues/363 is
" fixed. Once it is, I can remove this test disabling
" vint: -ProhibitEncodingOptionAfterScriptEncoding
set encoding=utf-8
scriptencoding utf-8
" vint: +ProhibitEncodingOptionAfterScriptEncoding

" This is a really cool reference:
" https://github.com/johngrib/vimscript-cheatsheet

" Manage plugins with vim-plug
call plug#begin('~/.vim/bundle')

" ---- Misc functionality
Plug 'tpope/vim-rsi' " GNU Readline-style key bindings in insert and command mode
Plug 'tpope/vim-commentary' " gcc or gc<movement> to comment out lines
Plug 'tpope/vim-repeat' " make '.' repeat plugin commands instead of only builtins
Plug 'tpope/vim-sleuth' " adjust shiftwidth and expandtab according to filetype
Plug 'tpope/vim-speeddating' " ctrl-x/ctrl-a for dates
Plug 'tpope/vim-surround' " cs to change surrounding characters
Plug 'tpope/vim-unimpaired' " set of command mappings
Plug 'farmergreg/vim-lastplace' " restore last known cursor position and open folds to show content (avoid doing it for commit messages)
" Plug 'junegunn/fzf' " command builder using fzf for fuzzing text
" Plug 'junegunn/fzf.vim' " set of basic commands using fzf
Plug 'romainl/vim-cool' " Automatically disable hlsearch to get it out of the way

" ---- Code formatting
" LSP client: for language completion, linting, formatting, syntax checking and
" automatic fixes
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': {-> coc#util#update_extensions()()} }
Plug 'windwp/nvim-autopairs'

" ---- Code syntax
Plug 'rodjek/vim-puppet' " puppet syntax hilighting
Plug 'noprompt/vim-yardoc'  " colorize YARD tags and directives in ruby and puppet code
Plug 'pearofducks/ansible-vim' " Make ansible playbooks look less like a bunch of all the same thing
Plug 'preservim/vim-markdown' " better markdown syntax hilighting
Plug 'stephpy/vim-yaml'  " better yaml syntax hilighting
Plug 'cespare/vim-toml'  " TOML syntax highlighting
Plug 'aliou/bats.vim'  " BATS syntax hilighting

" Interface additions/changes
Plug 'tpope/vim-fugitive' " Interact with git from vim
Plug 'bling/vim-airline' " Enhanced statusbar and titlebar
Plug 'nathanaelkane/vim-indent-guides' " colorize indents
Plug 'junegunn/vim-peekaboo'  " Display registers when typing <quote> or @ commands to make it easier to choose
Plug 'Yilin-Yang/vim-markbar'  " Display list of marks with context around them when typing ` or '
call plug#end()

syntax on
set synmaxcol=1000   " limit syntax highlighting for long lines
set ignorecase      " Do case insensitive matching
set smartcase       " Do smart case matching
set smarttab        " Insert blanks according to shiftwidth
set showcmd         " Show (partial) command in status line.
set showmatch       " Show matching brackets.
set incsearch       " Incremental search
set hlsearch        " Higlight searched term
set autoindent      " always line up with indentation of previous line
set shiftround      " when indenting, always line up with multiples of shiftwidth instead of blindly adding shiftwidth
set showtabline=2   " Always show tabline for window height consistency
set guioptions-=T   " Disable the toolbar in the GUI

set wildmenu        " Show a list of <tab> suggestions while in command mode
set wildmode=list:longest
set wildoptions=fuzzy
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.luac                           " Lua byte code
set wildignore+=migrations                       " Django migrations
set wildignore+=*.pyc,__pycache__,*.egg-info     " Python byte code and packaging
set wildignore+=.venv,.pytest_cache              " Python virtualenv and testing cache
set wildignore+=*.orig                           " Merge resolution files
set wildignore+=*.fasl                           " Lisp FASLs
set wildignore+=*.dx64fsl                        " CCL
set wildignore+=*.lx64fsl                        " CCL

set mouse=          " Disable mouse
set nrformats-=octal " Don't auto-increment numbers in octal mode if prefixed with a 0
set autoread
set tabpagemax=50   " Let me open more than 10 tabs gahdamit
set sessionoptions-=options
"set backspace=indent,eol,start
set splitbelow      " create new splits below the current window
set splitright      " create new vsplits to the right of the current window
set title           " set window title to filename

set ttimeout
set ttimeoutlen=100
" set shorter updatetime to make CursorHold happen quicker, for coc's hilight
" feature (see aucmd below).
set updatetime=2500

" Keep some visible text "outside" of the cursor
set scrolloff=1
set sidescrolloff=5

" better display if last line doesn't fit
set display+=lastline

" better indicators for :set list
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+

if v:version > 703 || v:version == 703 && has('patch541')
  set formatoptions+=j " Delete comment character when joining commented lines
endif
" disable auto-wrap for normal text. it's very annoying for most source files.
set formatoptions-=t
" format numbered lists correctly
set formatoptions+=n
" format comments correctly in all cases
set formatoptions+=cro
" don't break lines automatically if they were already longer than textwidth
" when going to insert mode
set formatoptions+=l

" remember more commands and search patterns
set history=1000

" displace the shada/viminfo file into XDG_DATA_HOME
if has('nvim')
  set shadafile=~/.local/share/nvim/shadafile
else
  set viminfofile=~/.local/share/vim/viminfo
endif

" change leader character to comma so that it's more accessible
let mapleader = ','

" Generally nice to have text automatically wrapped around some length (80
" seems to be very common, even though it's really short)... but: triggers some
" super annoying behavior when reaching 120 chars that interacts badly with
" puppet formatting (e.g. there's a bug in vim-puppet) -- the cursor is sent
" back to the begining of the same line, not a new one, so you have to do
" contortions to actually get a new line.
" I'm trying to fix that in the "file_include" branch on the vim-puppet
" plugin
set textwidth=79

set number          " Display current line number. Without this relativenumber shows an offset of 0 which is not useful
set relativenumber  " Display line offsets. This makes it easier to use line movements
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

" make sure that diffs are performed vertically. without this, Gdiff is split
" horizontally, which looks really bad
set diffopt+=vertical

" default to french dictionary
set spelllang=fr

" Interface color
" note: needs to be before the status line stuff
colorscheme slate
" fix some weaknesses of the slate color scheme. it's all too much the same
" color
" since vim 9.0 all schemes have a background color, which I don't want
hi Normal ctermbg=None
hi Comment ctermfg=DarkCyan guifg=Cyan
hi String ctermfg=Green guifg=Green
hi Operator ctermfg=White guifg=Black
hi Delimiter ctermfg=DarkMagenta guifg=Black
hi LineNrAbove ctermfg=DarkGray
hi LineNrBelow ctermfg=DarkGray
hi LineNr term=bold ctermfg=Yellow gui=bold guifg=Yellow

" Always show the status line
set laststatus=2

" Override the builtin gx command since it's doing nonsense.
function! OpenURLUnderCursor()
  let s:uri = expand('<cWORD>')
  let s:uri = substitute(s:uri, '?', '\\?', '')
  let s:uri = shellescape(s:uri, 1)
  if s:uri != ''
    silent exec "!gio open '".s:uri."'"
    :redraw!
  endif
endfunction
nnoremap gx :call OpenURLUnderCursor()<CR>

" vim-rsi avoids remapping i_CTRL-T since it's deemed too important, but I
" don't use it and I prefer to have this functunality available in insert mode
" as well.
" TODO figure out if I can reuse vim-rsi's transpose() (but it's declared as
" s:transpose() :(
"
" Swapping characters is way too useful and there's already <c-i> for indenting
" This swaps the two characters placed before the cursor (e.g. behaves like
" bash's emacs-mode <c-t>
" XXX This is buggy at the end of line (c-o goes back one character)
inoremap <silent> <C-t> <C-o>:normal hhxpl<CR>

if has('nvim')
  augroup terminal
    " The default nvim binding of <C-\><C-N> is a PITA for non-us keyboard.
    " <C-n> is not meaningfully mapped for bash so we won't be overshadowing
    " something useful with this mapping.
    tnoremap <C-n> <C-\><C-N>
    " nvim doesn't enter insert mode automatically which is annoying
    autocmd TermOpen * startinsert
  augroup END
else
  tnoremap <C-n> <C-w>N
endif

" Create undo break point for c-u and c-w. this way it's possible to undo when
" I make a mistake. Without this, undo would remove everything that was typed
" while in insert mode!
if empty(mapcheck('<C-U>', 'i'))
  inoremap <C-U> <C-G>u<C-U>
endif
if empty(mapcheck('<C-W>', 'i'))
  inoremap <C-W> <C-G>u<C-W>
endif

" Additional character replacements for surround.vim
augroup vimrc_surround
  au FileType embeddedpuppet let b:surround_45 = "<%- \r -%>"
  au FileType embeddedpuppet let b:surround_37 = "<% \r %>"
  au FileType embeddedpuppet let b:surround_61 = "<%= \r %>"
augroup END

" Make vim-cool show number of search matches
let g:CoolTotalMatches = 1

" activate some more markdown features
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_new_list_item_indent = 2

" Location list navigation
"
" Use mappings from plugin/location_wrap to make it easier to move in the
" location list while wrapping around the edges
"
" See ~/.vim/plugin/location_wrap.vim
"
nmap <silent> <leader>É  <Plug>LocationPrevious
nmap <silent> <leader>é  <Plug>LocationNext

" Syntastic configuration
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1 " This one's annoying when opening a large file like koumbit's nodes.pp
"let g:syntastic_check_on_wq = 0
" check python syntax with py3. this will become useless once py3 becomes
" default
"let g:syntastic_python_python_exec = 'python3'

" why is this necessary.. couldn't it just figure out that I have yamllint
" installed?
"let g:syntastic_yaml_checkers = ['yamllint']

" Airline configuration
let g:airline#extensions#tabline#enabled = 1    " Show buffers when there's only one tab
let g:airline_powerline_fonts = 1               " use powerline fonts. apparently utf8 symbols don't show up right
let g:airline#extensions#whitespace#enabled = 0 " pesky whitespace detection

" Add syntax-based matching for %
packadd! matchit

" Make the :Man command available. This one is not in a pack in the default
" setup.
runtime ftplugin/man.vim

augroup vimrc
  " TODO: not sure how to push this out to a plugin in ~/.vim ...
  " Show trailing whitepaces and leading mixed tabs + spaces:
  autocmd Syntax * syn match ErrorMsg /\s\+$\|^ \+\ze\t\|^\t\+\ze / containedin=ALL

  " TODO: not sure how to push this out to a plugin in ~/.vim ...
  " Cleanup fugitive buffers as I leave them to avoid clutter.
  autocmd BufReadPost fugitive://* set bufhidden=delete

  " TODO: not sure how to push this out to a plugin in ~/.vim ...
  " Highlight first column beyond the 120th one (hilighting more columns is
  " disruptive). 80 is short and I can deal with cases that complain about
  " lines longer than 80 when it happens. I randomly chose 120 to have more
  " space and to just see when a line is really getting out of hands.
  "
  " @note syn match [...] breaks syntactic contexts (e.g. strings everywhere)
  " @note Files that get no type recognized such as empty buffers or
  "   terminals will not get this command run.
  let non_interactive_filetypes = ['coc-explorer']
  au FileType * if index(non_interactive_filetypes, &ft) < 0 | let w:m2=matchadd('ErrorMsg', '\%120v', -1) | endif

  " Templates for some default content for certain files
  " this file was adapted from https://github.com/puppetlabs/pdk-templates/blob/master/moduleroot_init/README.md.erb
  autocmd BufNewFile README.md 0r ~/.vim/templates/README.md
  autocmd BufNewFile CHANGELOG.md 0r ~/.vim/templates/CHANGELOG.md
  autocmd BufNewFile *.sh 0r ~/.vim/templates/bash.sh
  autocmd BufNewFile *.pp 0r ~/.vim/templates/puppet.pp
  autocmd BufNewFile *.py 0r ~/.vim/templates/python.py
augroup END

" Detect playbooks properly to highlight certain ansible keywords in them.
augroup ansible
  au BufRead,BufNewFile */playbooks/*.yml set filetype=yaml.ansible
augroup END

" This looks better but it's pretty annoying when copying text since you'll
" always obtain spaces up to 80 chars
" set colorcolumn=+1
"hi ColorColumn ctermbg=black guibg=black

" Open files located in the same dir in with the current file is edited
nnoremap <leader>tw :tabe <C-R>=expand("%:.:h") . "/"<CR>
nnoremap <leader>ew :e <C-R>=expand("%:.:h") . "/"<CR>
nnoremap <leader>vw :vsplit <C-R>=expand("%:.:h") . "/"<CR>

" See ~/.vim/plugin/strip_trailing_whitespace.vim for function definition
nnoremap <Leader>x :<C-U>call StripTrailingWhitespace()<CR>

" Obscure shortcut, helpful for debugging syntax hilighting.
" Show syntax hilighting group under cursor
map <F10> :echo 'hi<' . synIDattr(synID(line('.'),col('.'),1),'name') . '> trans<'
\ . synIDattr(synID(line('.'),col('.'),0),'name') . '> lo<'
\ . synIDattr(synIDtrans(synID(line('.'),col('.'),1)),'name') . '>'<CR>

" Indent Guides
"
" Enable indentation coloring for easier visual reference
let g:indent_guides_enable_on_vim_startup = 1

" define highlight color for marking certain lines
highlight LineHighlight ctermbg=darkgray guibg=darkgray

" highlight (match) the current line
" Note that this line won't follow changes in the file. If it becomes annoying
" I could always use https://github.com/inkarkat/vim-mark instead
nnoremap <leader>ml :call matchadd('LineHighlight', '\%'.line('.').'l')<CR>

" clear all the matches (so also highlighted lines)
nnoremap <leader>mc :call clearmatches()<CR>

" coc.vim configuration
"
" TODO: it might be more insteresting to install the extensions as vim plugins
" Some notes on the extensions:
"  * coc-solargraph requires the solargraph gem (which is not packged in debian)
"  * coc-pyright should be accompanied by python3-flake8 and black
"  * coc-diagnostic makes it possible to run shellcheck and vint
"    * vint is not packaged in debian, so need to install it with pip. @note
"      vint version 0.4a3+ is needed -- so install with
"      `pip install --pre vim-vint`)
let g:coc_global_extensions = [
  \ 'coc-explorer',
  \ 'coc-lists',
  \ 'coc-terminal',
  \ 'coc-sh',
  \ 'coc-json',
  \ 'coc-yaml',
  \ 'coc-solargraph',
  \ 'coc-pyright',
  \ 'coc-phpls',
  \ 'coc-perl',
  \ 'coc-markdownlint',
  \ 'coc-vimlsp',
  \ 'coc-sql',
  \ 'coc-diagnostic',
  \ 'coc-git',
  \ 'coc-gitignore',
  \ '@yaegassy/coc-ansible',
  \ 'coc-rust-analyzer',
  \]

" This is required for coc-ansible
let g:coc_filetype_map = {
  \ 'yaml.ansible': 'ansible',
  \ }

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has('patch-8.1.1564')
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=auto
endif

" Make `<tab>` used for trigger completion, completion confirm, snippet expand and jump like VSCode.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
" this hides the documentation provided by keywordprg >:[ -- it's weird though,
" the function show_documentation seems to use it as a last effort.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
augroup coc
  autocmd CursorHold * silent call CocActionAsync('highlight')
augroup END

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
" XXX I'm not sure there's any language server that supports this :\
nmap <leader>qf  <Plug>(coc-fix-current)

" " Remap <C-f> and <C-b> for scroll float windows/popups.
" if has('nvim-0.4.0') || has('patch-8.2.0750')
"   nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"   nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"   inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
"   inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
"   vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"   vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
" endif

" Mappings for CoCList
" Show all lists
nnoremap <silent><nowait> <space>l  :<C-u>CocList<CR>
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document. e.g. all definitions
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Fuzzy-find window and jump to it. This requires coc-lists
nnoremap <silent><nowait> <space>w  :<C-u>CocList windows<CR>
" Git commit graph for whole repository
nnoremap <silent><nowait> <space>gc :<C-u>CocList commits<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" coc-explorer mappings
nmap <space>e :CocCommand explorer<CR>

" only display alphabetic marks a-i and A-I
let g:markbar_marks_to_display = 'abcdefghiABCDEFGHI'
let g:markbar_peekaboo_marks_to_display = 'abcdefghiABCDEFGHI'

" Initial setup for nvim-autopairs
" Weirdly, I can't indent the block inside the if or the vimrc parsing crashes
if has('nvim')
lua << EOF
require('nvim-autopairs').setup {}
EOF
endif
