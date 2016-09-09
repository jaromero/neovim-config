" vim: fdm=marker fmr={{{,}}} fdl=0

" Helpers
function! Preserve(cmd)
  " preparation: save last search and cursor position
  let _s=@/
  let l = line(".")
  let c = col(".")
  " do the business:
  execute a:cmd
  " clean up: restore previous search history and cursor pos
  let @/=_s
  call cursor(l, c)
endfunction

function! StripTrailingWhitespace()
  call Preserve("$s/\\s\\+$//e")
endfunction

function! EnsureExists(path)
  if !isdirectory(expand(a:path))
    call mkdir(expand(a:path))
  endif
endfunction

function! CloseWindowOrKillBuffer()
  let number_of_windows_to_this_buffer = len(filter(range(1, winnr('$')), "winbufnr(v:val) == bufnr('%')"))

  " never bdelete a nerd tree
  if match(expand('%'), 'NERD')
    wincmd c
    return
  endif

  " if term window, close gracefully
  if match(expand('%'), 'term://')
    wincmd c
    return
  endif

  if number_of_windows_to_this_buffer > 1
    wincmd c
  else
    bdelete
  endif
endfunction

function! ChangeCurrDir()
  let _dir = expand("%:p:h")
  exec "cd " . escape(_dir, ' ')
  unlet _dir
endfunction

" Basic editor prefs
set errorbells
set hidden
set keymodel=startsel,stopsel
set mousemodel=popup
set clipboard+=unnamedplus
set nosol
set ruler
set scrolloff=3
set showcmd
set viewoptions=folds,options,cursor,unix,slash
set whichwrap=b,s,<,>,[,]

" Whitespace
set smartindent
set listchars=eol:$,tab:→\ ,trail:_,extends:»,precedes:«,nbsp:·
set linebreak
let &showbreak = '↳ '

set breakindent

" Spaces, no tabs
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround

" searching
set smartcase
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor\ --vimgrep
endif

" Persistent undo
if exists('+undofile')
  set undofile
  set undodir=~/.config/nvim/.cache/undo
endif

" Backups and swap
set backup
set backupcopy=auto

set backupdir=~/tmp
set directory=~/.config/nvim/.cache/swap//

call EnsureExists('~/.config/nvim/cache')
call EnsureExists(&undodir)
call EnsureExists(&backupdir)
call EnsureExists(&directory)

" Wildignore
set wildignore+=*.o,*.obj,*.exe,*.so,*.dll
set wildignore+=.git/*,.bzr/*,.hg/*,.svn/*
set wildignore+=.DS_Store,__MACOSX/*,Thumbs.db
set wildignore+=.sass-cache/*,.cache/*,.tmp/*,*.scssc
set wildignore+=node_modules/*,jspm_modules/*,bower_components/*

" Leader
let mapleader=","
let g:mapleader=","

" Visual config
set showmatch
set number
set cul
set nocuc
set termguicolors

" Folds
set foldlevelstart=99

let g:xml_syntax_folding=1
let g:perl_fold=1

" Plugins
call plug#begin()

" Utilities
Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*', 'term://.*']
let g:EditorConfig_exec_path = '/usr/bin/editorconfig'

Plug 'mhinz/vim-grepper'
nnoremap <leader>ag :Grepper -tool ag -grepprg ag --vimgrep -G '^.+\.txt'<CR>

Plug 'tpope/vim-fugitive'
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gp :Git push<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>
nnoremap <silent> <leader>gx :Gremove<CR>
au BufReadPost fugitive://* set bufhidden=delete

Plug 'mhinz/vim-startify'
let g:startify_session_dir = '~/.config/nvim/.cache/startify'
let g:startify_show_sessions = 1
" nnoremap <M-F1> :Startify<CR>

" Plug 'mileszs/ack.vim'
" if executable('ag')
"   let g:ackprg = 'ag --nogroup --nocolor --column'
" endif

" Plug 'Konfekt/FastFold'

" Edition
Plug 'mattn/emmet-vim'
let g:user_emmet_install_global = 0
let g:emmet_html5 = 1
let g:user_emmet_expandabbr_key = '<C-E>'
let g:user_emmet_expandword_key = '<C-S-E>'
autocmd FileType html EmmetInstall

Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'

Plug 'tpope/vim-unimpaired'
nmap <C-S-Up> [e
nmap <C-S-Down> ]e
vmap <C-S-Up> [egv
vmap <C-S-Down> ]egv

Plug 'junegunn/vim-easy-align'

Plug 'Raimondi/delimitMate'
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
au FileType vim,html let b:delimitMate_matchpairs = "(:),[:],{:}"

Plug 'heavenshell/vim-jsdoc'
let g:jsdoc_enable_es6 = 1
nmap <silent> <C-L> <Plug>(jsdoc)

" Autocomplete

Plug 'ternjs/tern_for_vim'
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']

Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1

"inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : <SID>check_backspace() ? "\<Tab>" : deoplete#mappings#manual_complete()

function! s:check_backspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"

Plug 'carlitux/deoplete-ternjs'

" Linting
Plug 'neomake/neomake'
let g:neomake_javascript_enabled_makers = ['eslint']
autocmd! BufWritePost * Neomake

" Navigation
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
let NERDTreeShowHidden = 1
let NERDTreeQuitOnOpen = 0
let NERDTreeShowBookmarks = 1
let NERDTreeBookmarksFile = '~/.config/nvim/.cache/NERDTreeBookmarks'
nnoremap <F3> :NERDTreeToggle<CR>
nnoremap <S-F3> :NERDTreeFind<CR>
nnoremap <F15> :NERDTreeFind<CR>

"Plug 'vifm/neovim-vifm'
"let g:vifmUseLcd = 1

Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'
nnoremap <C-P> :FZF<CR>

" Information
Plug 'vim-airline/vim-airline'
let g:airline_powerline_fonts = 0
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#hunks#hunk_symbols = ['+', '±', '-']

let g:airline_symbols = {}

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.crypt = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.paste = ''
let g:airline_symbols.spell = ''
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = ''

let g:airline_section_c = '%{FilenameOrTerm()}'

function! FilenameOrTerm()
  return exists('b:term_title') ? b:term_title : expand('%:t')
endfunction

let g:airline_mode_map = {
  \ '__' : '-',
  \ 'n'  : 'N',
  \ 'i'  : 'I',
  \ 'R'  : 'R',
  \ 'c'  : 'C',
  \ 'v'  : 'V',
  \ 'V'  : 'V',
  \ '' : 'V',
  \ 's'  : 'S',
  \ 'S'  : 'S',
  \ '' : 'S',
  \ }

Plug 'nathanaelkane/vim-indent-guides'
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_color_change_percent = 3

Plug 'airblade/vim-gitgutter'
let g:gitgutter_map_keys = 0

" Sessions
" Plug 'xolox/vim-misc' | Plug 'xolox/vim-session'
" set sessionoptions-=help
" set sessionoptions-=tabpages
" let g:session_autosave = 'no'
" let g:session_autoload = 'no'
" let g:session_verbose_messages = 0
" let g:session_directory = '~/.config/nvim/.cache/sessions'

" Syntax
Plug 'othree/yajs.vim', {'for': 'javascript'}
Plug 'kchmck/vim-coffee-script', {'for': ['coffee', 'litcoffee']}
Plug 'gregsexton/MatchTag', {'for': ['html', 'xml']}
Plug 'digitaltoad/vim-jade', {'for': ['jade', 'pug']}

" End plugins

" Keymaps and commands
command! CDhere call ChangeCurrDir()

" Close window or delete buffer
"noremap <silent> <leader>q :call CloseWindowOrKillBuffer()<CR>
noremap <silent> <leader>q <C-W>c
noremap <silent> <leader>dd :bdelete<CR>

" Backspace in visual mode deletes selection
vnoremap <BS> d

" Duplicate current line
nmap <C-D> YPj$

" Open/close folds
nnoremap <silent> + zo
nnoremap <silent> - zc

" Quickly sort selection
vmap <leader>s :sort<CR>

" Buffers - previous/next: S-F12, F12
nnoremap <silent> <S-F12> :bp<CR>
nnoremap <silent> <F24> :bp<CR>
nnoremap <silent> <F12> :bn<CR>

" Reselect block after indenting
vnoremap < <gv
vnoremap > >gv

" Smart home
" http://vim.wikia.com/wiki/Smart_home
noremap <expr> <Home> (col('.') == matchend(getline('.'), '^\s*')+1 ? '0' : '^')
imap <Home> <C-O><Home>

" Quickly toggle list
nmap <leader>l :set list!<CR>

" Clear search hilite
nnoremap <silent> <Esc> :nohlsearch<CR><Esc>

" Exit out of terminal mode on double esc
tnoremap <Esc><Esc> <C-\><C-n>

" autocmds

" Easily close HTML tags
" http://vim.wikia.com/wiki/Auto_closing_an_HTML_tag
"autocmd FileType html,xml inoremap <buffer> </ </<C-X><C-O><C-N><Esc>a
"autocmd FileType html,xml inoremap <buffer> <<kDivide> </<C-X><C-O><C-N><Esc>a

autocmd FileType coffee setl fdm=indent
autocmd FileType markdown setl nolist
autocmd FileType python setl fdm=indent
autocmd FileType text setl textwidth=78
autocmd FileType vim setl fdm=indent keywordprg=:help

" Go back to previous cursor position
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe 'normal! g`"zvzz' |
  \ endif

" Colorschemes
Plug 'whatyouhide/vim-gotham'
Plug 'raphamorim/lucario'
Plug 'jaromero/vim-monokai-refined'
Plug 'cseelus/vim-colors-lucid'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'rakr/vim-one'

" Finish loading
call plug#end()

" Possibly fix colors?
source ~/.config/nvim/fixcolors.vim

set background=dark
colorscheme lucario
