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
Plug 'tpope/vim-sensible' " Set a bunch of default options that make [n]vim better by default
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

set synmaxcol=1000   " limit syntax highlighting for long lines
set ignorecase      " Do case insensitive matching
set smartcase       " Do smart case matching
set showcmd         " Show (partial) command in status line.
set showmatch       " Show matching brackets.
set hlsearch        " Higlight searched term
set autoindent      " always line up with indentation of previous line
set shiftround      " when indenting, always line up with multiples of shiftwidth instead of blindly adding shiftwidth
set showtabline=2   " Always show tabline for window height consistency
set guioptions-=T   " Disable the toolbar in the GUI

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
set splitbelow      " create new splits below the current window
set splitright      " create new vsplits to the right of the current window
set title           " set window title to filename

" set shorter updatetime to make CursorHold happen quicker, for coc's hilight
" feature (see aucmd below).
set updatetime=2500

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
set textwidth=80

set number          " Display current line number. Without this relativenumber shows an offset of 0 which is not useful
set relativenumber  " Display line offsets. This makes it easier to use line movements
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,InsertEnter,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,WinLeave   * if &nu                  | set nornu | endif
augroup END

" make sure that diffs are performed vertically. without this, Gdiff is split
" horizontally, which looks really bad
set diffopt+=vertical
" ignore whitespace changes in diff mode
set diffopt+=iwhite
" use smarter diff algorithm. that's only visible in some circumstances
set diffopt+=algorithm:histogram

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
hi LineNr term=bold ctermfg=White gui=bold guifg=Yellow

" vim-rsi avoids remapping i_CTRL-T since it's deemed too important, but I
" don't use it and I prefer to have this functunality available in insert mode
" as well.
"
" Swapping characters is way too useful and there's already <c-i> for indenting
" This swaps the two characters placed before the cursor (e.g. behaves like
" bash's emacs-mode <c-t>
" TODO vim-rsi's s:transpose() function is script-local but also it's not
" formatted for use with an <expr> mapping in i mode. I could possibly reuse
" the structure though
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

" Additional character replacements for surround.vim
augroup vimrc_surround
  au FileType embeddedpuppet let b:surround_45 = "<%- \r -%>"
  au FileType embeddedpuppet let b:surround_37 = "<% \r %>"
  au FileType embeddedpuppet let b:surround_61 = "<%= \r %>"
augroup END

" activate some more markdown features
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_new_list_item_indent = 2

" Airline configuration
set noshowmode  " airline already shows the mode in the statusbar
let g:airline#extensions#tabline#enabled = 1    " Show buffers when there's only one tab
let g:airline_powerline_fonts = 1               " use powerline fonts. apparently utf8 symbols don't show up right
let g:airline#extensions#whitespace#enabled = 0 " pesky whitespace detection

augroup vimrc
  " Show trailing whitepaces and leading mixed tabs + spaces:
  autocmd Syntax * syn match ErrorMsg /\s\+$\|^ \+\ze\t\|^\t\+\ze / containedin=ALL

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

" Open files located in the same dir in with the current file is edited
nnoremap <leader>tw :tabe <C-R>=expand("%:.:h") . "/"<CR>
nnoremap <leader>ew :e <C-R>=expand("%:.:h") . "/"<CR>
nnoremap <leader>vw :vsplit <C-R>=expand("%:.:h") . "/"<CR>

" Obscure shortcut, helpful for debugging syntax hilighting.
" Show syntax hilighting group under cursor
map <F10> :echo 'hi<' . synIDattr(synID(line('.'),col('.'),1),'name') . '> trans<'
\ . synIDattr(synID(line('.'),col('.'),0),'name') . '> lo<'
\ . synIDattr(synIDtrans(synID(line('.'),col('.'),1)),'name') . '>'<CR>

" Indent Guides
"
" Enable indentation coloring for easier visual reference
let g:indent_guides_enable_on_vim_startup = 1

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
  \ 'coc-git',
  \ 'coc-sh',
  \ 'coc-json',
  \ 'coc-yaml',
  \ 'coc-solargraph',
  \ 'coc-pyright',
  \ 'coc-perl',
  \ 'coc-markdownlint',
  \ 'coc-vimlsp',
  \ 'coc-diagnostic',
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

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

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
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" coc-explorer mappings
nmap <space>e :CocCommand explorer<CR>

" only display alphabetic marks a-i and A-I
let g:markbar_marks_to_display = 'abcdefghiABCDEFGHI'
let g:markbar_peekaboo_marks_to_display = 'abcdefghiABCDEFGHI'
" when marks are set to be persistent, vim-markbar reopens the buffers that have
" marks in them which becomes annoying real fast since I'm always getting errors
" about setting those buffers as readonly since they're already opened
" elsewhere. I personnally don't have a strong use case for persisting marks
let g:markbar_persist_mark_names = v:false

" Initial setup for nvim-autopairs
" Weirdly, I can't indent the block inside the if or the vimrc parsing crashes
if has('nvim')
lua << EOF
require('nvim-autopairs').setup {}
EOF
endif
