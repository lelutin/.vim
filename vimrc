set encoding=utf-8  " No, I don't want to write files as latin1
scriptencoding utf-8

" This is a really cool reference:
" https://github.com/johngrib/vimscript-cheatsheet

" Manage plugins with Vundle. This one has the advantage over pathogen that it
" manages the git repos itself and it'll git pull automatically when running
" :PluginUpdate
" After adding plugins in this list, use :PluginInstall to add the missing
" plugins.
filetype off "required to load vundle plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

" Misc functionality
Plugin 'tpope/vim-commentary' " gcc or gc<movement> to comment out lines
Plugin 'tpope/vim-repeat' " make '.' repeat plugin commands instead of only builtins
Plugin 'tpope/vim-sleuth' " adjust shiftwidth and expandtab according to filetype
Plugin 'tpope/vim-speeddating' " ctrl-x/ctrl-a for dates
Plugin 'tpope/vim-surround' " cs to change surrounding characters
Plugin 'tpope/vim-unimpaired' " set of command mappings
Plugin 'https://sanctum.geek.nz/code/vim-redact-pass.git' " companion to pass. remove all temp files and backups when editing a password file
"Plugin 'SirVer/ultisnips' " Snippet definition plugin
Plugin 'honza/vim-snippets' " set of snippets
Plugin 'farmergreg/vim-lastplace' " restore last known cursor position and open folds to show content (avoid doing it for commit messages)
" Plugin 'junegunn/fzf' " command builder using fzf for fuzzing text
" Plugin 'junegunn/fzf.vim' " set of basic commands using fzf
Plugin 'romainl/vim-cool' " Automatically disable hlsearch to get it out of the way

" Code syntax
Plugin 'rodjek/vim-puppet' " puppet syntax hilighting
Plugin 'plasticboy/vim-markdown' " better markdown syntax hilighting
Plugin 'stephpy/vim-yaml'  " better yaml syntax hilighting
" also see this for potential puppet integration https://github.com/rodjek/vim-puppet/issues/125
Plugin 'noprompt/vim-yardoc'  " colorize YARD tags and directives in ruby code
Plugin 'aliou/bats.vim'  " BATS syntax hilighting
"Plugin 'scrooloose/syntastic' " check syntax for current filetype
" Code formatting
Plugin 'godlygeek/tabular' " align text on a certain pattern
"Plugin 'Chiel92/vim-autoformat' " use autoformatting programs to keep code tidy
" LSP client. for language completion, linting, formatting and syntax checking
"Plugin 'Valloric/YouCompleteMe' " I'm installing this with the debian package to avoid having to compile it
Plugin 'neoclide/coc.nvim', {'branch': 'release'}
" DAP client and interface. Visual debugger for multiple languages
Plugin 'puremourning/vimspector'  " vim debugging IDE

" ctags
" j'utilise vraiment pas les ctags..
"Plugin 'majutsushi/tagbar' " list all ctags and make it easier to navigate through them
" Trop gossant que ca cree tout le temps un fichier tags. si j'utilise ca va
" falloir m'arranger pour que le fichier soit nomme differemment et toujours
" ignore de git.
"Plugin 'ludovicchabant/vim-gutentags' " automatically update tags file

" Git integration
Plugin 'tpope/vim-fugitive' " Interact with git from vim

" Interface additions/changes
Plugin 'bling/vim-airline' " Enhanced statusbar and titlebar
"Plugin 'scrooloose/nerdtree' " Opening a dir shows a file list
"Plugin 'Xuyuanp/nerdtree-git-plugin' " make nerdtree show git status markers on files
Plugin 'nathanaelkane/vim-indent-guides' " colorize indents

"Debug/testing
Plugin 'junegunn/vader.vim' " Used for testing vim-puppet
call vundle#end()
filetype plugin indent on

syntax on
set synmaxcol=1000   " limit syntax highlighting for long lines
set ignorecase      " Do case insensitive matching
set smartcase       " Do smart case matching
set smarttab        " Insert blanks according to shiftwidth
set showcmd         " Show (partial) command in status line.
set showmatch       " Show matching brackets.
set incsearch       " Incremental search
set hlsearch        " Higlight searched term
"set tabstop=8       " Number of spaces for <tab> characters
"set softtabstop=4   " Make backspace delete that many characters
"set shiftwidth=4    " Number of spaces used for automatic indentation
"set expandtab       " Transform <tab> characters into spaces
set autoindent      " always line up with indentation of previous line
set shiftround      " when indenting, always line up with multiples of shiftwidth instead of blindly adding shiftwidth
set showtabline=2   " Always show tabline for window height consistency
set guioptions-=T   " Disable the toolbar in the GUI

set wildmenu        " Show a list of <tab> suggestions while in command mode
set wildmode=list:longest
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.luac                           " Lua byte code
set wildignore+=migrations                       " Django migrations
set wildignore+=*.pyc                            " Python byte code
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

" displace the viminfo file into XDG_DATA_HOME
set viminfofile=~/.local/share/vim/viminfo

" get completion 'info' into a popup instead of the preview window
set completeopt = "menu,popup"

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

" make sure that diffs are performed vertically. without this, Gdiff is split
" horizontally, which looks really bad
set diffopt+=vertical

" Interface color
" note: needs to be before the status line stuff
colorscheme slate
" fix some weaknesses of the slate color scheme. it's all too much the same
" color
hi Comment ctermfg=DarkCyan guifg=Cyan
hi String ctermfg=Green guifg=Green
hi Operator ctermfg=White guifg=Black
hi Delimiter ctermfg=DarkMagenta guifg=Black

" Always show the status line
set laststatus=2

" always set foldlevel to 2 to get meaningful content by default but fold more
" complex blocks of code
set foldlevel=2

" General syntax configuration
"
" see more per-syntax config in after/ftplugin/*.vim
let g:perl_fold = 1
let g:ruby_fold = 1
let g:sh_fold_enabled = 7 " used as a bitfield by the syntax file. 1 = functions, 2 = heredoc, 4 = idofor

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

" Swapping characters is way too useful and there's already <c-i> for indenting
" This swaps the two characters placed before the cursor (e.g. behaves like
" bash's emacs-mode <c-t>
inoremap <silent> <C-t> <C-o>:normal hhxpl<CR>
" Vim doesn't have a shortcut for going to the beginning/end of line while in
" insert mode.. that's annoying.
inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>0
" Similarly, to help avoiding to leave the home keys, it's nicer to be able to
" jump words with h and l
inoremap <C-h> <C-o>b
inoremap <C-l> <C-o>w

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

" I'm always calling this to fix puppet manifests
nnoremap <leader><Tab> :Tabularize /=><CR>

" " Some useful mappings for normal mode fzf commands
" " TODO I never use those.. I should either trash them or make them less
" " "top-level"
" nnoremap <leader>b :Buffers<CR>
" nnoremap <leader>w :Windows<CR>
" nnoremap <leader>g :Ag<CR>
" nnoremap <leader>m :Marks<CR>
" nnoremap <leader>s :Snippets<CR>

" TODO hmm je considere p-e plutôt utiler coc-explorer
" Netrw (builtin file browser) configuration
" show files in a tree
let g:netrw_liststyle = 3
" type I in the browser to bring the banner back
let g:netrw_banner = 0
" not sure which value I prefer here yet (either 1, 3 or 4 see :help netrw_browse_split)
" let's go back to the default and use :Ex for a while to see if it's more
" functional overall
"let g:netrw_browse_split = 1
let g:netrw_winsize = 25

"" NERDTree configuration
"let NERDTreeHighlightCursorline = 1
"let NERDTReeIgnore = ['\.pyc$', '~$', '\.class$', '\.o', '\.so', '\.vagrant', '\.pc' ]

" nnoremap <leader>t :NERDTreeToggle<CR>

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

" Make VimspectorInstall behave in a more predictable way (e.g. only install those builtin gadgets (custom gadgets
" will always be installed)
let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-bash-debug' ]

" Create some mappings for the vimspector debugger. I don't particularly like
" the default mappings since they make you go to the F* keys and that's far
" away from the home position.
"
" Default configurations for running the current file can be found in
" ~/.vim/bundle/vimspector/configurations/linux/$language/*.json
"
" Custom gadgets (vscode plugins) are added via
" ~/.vim/bundle/vimspector/gadgets/custom/cust_$language.json
"
nnoremap <leader>dd :call vimspector#Launch()<CR>
" think: debugger exit
nnoremap <leader>de :call vimspector#Reset()<CR>

" TODO verifier si je peux mapper des trucs un peu plus dans ma face avec une
" autocommand VimspectorUICreated
fun GotoWindow(id)
  call win_gotoid(a:id)
  "MaximizerToggle  "still not sure I want to do this. but it could be worth a try (need to install the plugin
endfun
"nnoremap <leader>m :MaximizeToggle!<CR>  "same as above

" go to window commands. the first letter of their names
nnoremap <leader>dc :call GotoWindow(g:vimspector_session_windows.code)<CR>
nnoremap <leader>dt :call GotoWindow(g:vimspector_session_windows.terminal)<CR>
nnoremap <leader>dv :call GotoWindow(g:vimspector_session_windows.variables)<CR>
nnoremap <leader>dw :call GotoWindow(g:vimspector_session_windows.watches)<CR>
nnoremap <leader>ds :call GotoWindow(g:vimspector_session_windows.stack_trace)<CR>
nnoremap <leader>do :call GotoWindow(g:vimspector_session_windows.output)<CR>

" code movements. movement keys
" go right for a deeper stack (step into)
nmap <leader>dl <Plug>VimspectorStepInto
" go down the current position (step over)
nmap <leader>dj <Plug>VimspectorStepOver
" go left for a shallower stack (step out)
nmap <leader>dh <Plug>VimspectorStepOut
" go up to continue without looking (¯\_(ツ)_/¯)
nmap <leader>dk <Plug>VimspectorContinue
" not really using a movement key, but reset should be out of the way to avoid
" hitting it by mistake
nmap <leader>d_ <Plug>VimspectorRestart
" not really a movement either. it's a common action and I don't want it to
" use similar leading chars to avoid creating delays for other common actions
nmap <leader>d<space> <Plug>VimspectorRunToCursor

" break points
nmap <leader>dpp <Plug>VimspectorToggleBreakpoint
nmap <leader>dpc <Plug>VimspectorToggleConditionalBreakpoint
" This is not supported by a bunch of gadgets (i.e. python and bash don't
" support it).
nmap <leader>dpf <Plug>VimspectorAddFunctionBreakpoint
nnoremap <leader>dpl :call vimspector#ListBreakpoints()<CR>

" watches
nnoremap <leader>dWa :call vimspector#AddWatch()<CR>
" marche juste en etant dans la fenetre des watches. c'est un peu nono
nnoremap <leader>dWd :call vimspector#DeleteWatch()<CR>

" Run autoformat when saving code
" autoformat is doing some serious aweful shit with yaml files.
"if &filetype!="yaml"
"  au BufWrite * :Autoformat
"endif

" Airline configuration
let g:airline#extensions#tabline#enabled = 1    " Show buffers when there's only one tab
let g:airline_powerline_fonts = 1               " use powerline fonts. apparently utf8 symbols don't show up right
let g:airline#extensions#whitespace#enabled = 0 " pesky whitespace detection
let g:airline#extensions#gutentags#enabled = 1  " Show gutentag ctags generation progress

" Add syntax-based matching for %
packadd! matchit

" Make the :Man command available. This one is not in a pack in the default
" setup.
runtime ftplugin/man.vim

if has('autocmd')
  " function! MyLastWindow()
  "   if &filetype ==# 'nerdtree' && winbufnr(2) == -1
  "     quit!
  "   endif
  " endfunction
  augroup vimrc
    " TODO: not sure how to push this out to a plugin in ~/.vim ...
    " Quit if the last window is NERDTree
    "au BufEnter * call MyLastWindow()

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
  augroup END

  " This looks better but it's pretty annoying when copying text since you'll
  " always obtain spaces up to 80 chars
  " set colorcolumn=+1
  hi ColorColumn ctermbg=black guibg=black
endif

" Create new buffer and show it in a new vertical split
nnoremap <C-W>V :vnew<CR>

" Open files located in the same dir in with the current file is edited
nnoremap <leader>ew :tabe <C-R>=expand("%:.:h") . "/"<CR>
nnoremap <leader>Ew :e <C-R>=expand("%:.:h") . "/"<CR>

" See ~/.vim/plugin/strip_trailing_whitespace.vim for function definition
nnoremap <Leader>x :<C-U>call StripTrailingWhitespace()<CR>

" Obscure shortcut, helpful for debugging syntax hilighting.
" Show syntax hilighting group under cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Indent Guides
"
" Enable indentation coloring for easier visual reference
let g:indent_guides_enable_on_vim_startup = 1

" define highlight color for marking certain lines
highlight LineHighlight ctermbg=darkgray guibg=darkgray

" highlight (match) the current line
" Note that this line won't follow changes in the file. If it becomes annoying
" I could always use https://github.com/inkarkat/vim-mark instead
nnoremap ml :call matchadd('LineHighlight', '\%'.line('.').'l')<CR>

" clear all the matches (so also highlighted lines)
nnoremap mc :call clearmatches()<CR>

"" UltiSnips
""
"" Open snippet edition in a new tab instead of current window
"let g:UltiSnipsEditSplit = 'tabdo'
"" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
"" not using YCM anymore.. it's probably ok to keep it as it is
"let g:UltiSnipsExpandTrigger='<c-space>'

" coc.vim configuration
"
" TODO: it might be more insteresting to install the extensions as vim plugins
" Some notes on the extensions:
"  * coc-solargraph requires the solargraph gem (which is not packged in debian)
"  * coc-pyright should be accompanied by python3-flake8 and black
"  * coc-diagnostic makes it possible to run shellcheck and vint
"    * vint is not packaged in debian, so need to install it with pip. @note
"      vint version 0.4a3+ is needed -- so install with `pip install --pre vint`)
let g:coc_global_extensions = [
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
  \ 'coc-snippets',
  \ 'coc-terminal',
  \ 'coc-git',
  \ 'coc-gitignore',
  \ 'coc-explorer',
  \]

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has('patch-8.1.1564')
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Make `<tab>` used for trigger completion, completion confirm, snippet expand and jump like VSCode.
" doesn't work too well with <c-j> and <c-k> for snippet movements
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-@> coc#refresh()

" " Make <CR> auto-select the first completion item and notify coc.nvim to
" " format on enter, <cr> could be remapped by other vim plugin
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
"                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" TODO modifier le hilight CocFloating
" TODO changer le hilight group dans le setting coc
" "list.previewHighlightGroup" -- ou bien ajuster le group Search pour que le
" background ait plus d'allure

" Use K to show documentation in preview window.
" this hides the documentation provided by keywordprg >:[ -- it's weird though,
" the function show_documentation seems to use it as a last effort.
" nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . ' ' . expand('<cword>')
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
" FIXME no a huge fan of the <space> prefix..
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" pas besoin d'un raccourci pour ca..
" Manage extensions.
"nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols.
" nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" coc-snippets mappings
"imap <C-l> <Plug>(coc-snippets-expand)
let g:coc_snippet_next = '<tab>'

" coc-explorer mappings
" je considère ajouter --open-action-strategy sourceWindow
nmap <space>e :CocCommand explorer<CR>

