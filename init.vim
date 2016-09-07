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
  if matchstr(expand("%"), 'NERD') === 'NERD'
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
let &showbreak = '↲ '

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

" Folds
set foldlevelstart=99

let g:xml_syntax_folding=1
let g:perl_fold=1

if has('conceal')
  set conceallevel=1
  set listchars+=conceal:△
endif

" Plugins
call plug#begin()

" Utilities
Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
let g:EditorConfig_exec_path = '/usr/bin/editorconfig'

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
" Plug 'mattn/emmet-vim'
" let g:user_emmet_expandabbr_key = '<C-E>'
" let g:user_emmet_expandword_key = '<C-S-E>'
" let g:user_emmet_settings = {
"   \ 'html' : {
"   \   'empty_element_suffix' : '>'
"   \   }
"   \ }

Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-repeat'
" Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'

Plug 'tpope/vim-unimpaired'
nmap <C-S-Up> [e
nmap <C-S-Down> ]e
vmap <C-S-Up> [egv
vmap <C-S-Down> ]egv

Plug 'junegunn/vim-easy-align'

" Navigation
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
let NERDTreeShowHidden = 1
let NERDTreeQuitOnOpen = 0
let NERDTreeShowBookmarks = 1
let NERDTreeBookmarksFile = '~/.config/nvim/.cache/NERDTreeBookmarks'
nnoremap <F3> :NERDTreeToggle<CR>
nnoremap <S-F3> :NERDTreeFind<CR>

Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'

" Information
Plug 'bling/vim-airline'
let g:airline_poewrline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#whitespace#enabled = 0

function! AirlineBranchName(name)
  return '→ ' . a:name
endfunction

Plug 'nathanaelkane/vim-indent-guides'
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_color_change_percent = 3

" Sessions
" Plug 'xolox/vim-misc' | Plug 'xolox/vim-session'
" set sessionoptions-=help
" set sessionoptions-=tabpages
" let g:session_autosave = 'no'
" let g:session_autoload = 'no'
" let g:session_verbose_messages = 0
" let g:session_directory = '~/.config/nvim/.cache/sessions'

" Syntax

" End plugins

" Keymaps and commands
command! CDhere call ChangeCurrDir()

" Close window or delete buffer
noremap <leader>q :call CloseWindowOrKillBuffer()<CR>

" Duplicate current line
nmap <C-D> YPj$

" Quickly sort selection
vmap <leader>s :sort<CR>

" Smart home
" http://vim.wikia.com/wiki/Smart_home
noremap <expr> <Home> (col('.') == matchend(getline('.'), '^\s*')+1 ? '0' : '^')
imap <Home> <C-O><Home>

" Quickly toggle list
nmap <leader>l :set list!<CR>

" autocmds

" Go back to previous cursor position
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe 'normal! g`"zvzz' |
  \ endif

" Finish loading
call plug#end()

colorscheme zellner
