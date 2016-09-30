" vim: fdm=marker fmr={{{,}}}

" Basic editor prefs {{{
set clipboard+=unnamedplus
set errorbells
set hidden
set keymodel=startsel,stopsel
set mousemodel=popup
set ruler
set scrolloff=3
set showcmd
set nostartofline
set viewoptions=folds,options,cursor,unix,slash
set whichwrap=b,s,<,>,[,]
" }}}

" Whitespace {{{
let &showbreak = '↳ '

set breakindent
set linebreak
set listchars=eol:$,tab:→\ ,space:·,trail:_,extends:»,precedes:«,nbsp:※
set smartindent
" }}}

" Spaces, no tabs {{{
set expandtab
set shiftround
set shiftwidth=2
set softtabstop=2
set tabstop=2
" }}}

" Searching {{{
set keywordprg=:help
set smartcase

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor\ --vimgrep
endif
" }}}

" Persistent undo {{{
if exists('+undofile')
  set undofile
  set undodir=~/.config/nvim/.cache/undo
endif
" }}}

" Backups and swap {{{
set backup
set backupcopy=auto
set backupdir=~/tmp
set directory=~/.config/nvim/.cache/swap//

call EnsureExists('~/.config/nvim/.cache')
call EnsureExists(&undodir)
call EnsureExists(&backupdir)
call EnsureExists(&directory)
" }}}

" Wildignore {{{
set wildignore+=*.o,*.obj,*.exe,*.so,*.dll
set wildignore+=.git/*,.bzr/*,.hg/*,.svn/*
set wildignore+=.DS_Store,__MACOSX/*,Thumbs.db
set wildignore+=.sass-cache/*,.cache/*,.tmp/*,*.scssc
set wildignore+=node_modules/*,jspm_modules/*,bower_components/*
" }}}

" Leader {{{
let mapleader=","
let g:mapleader=","
" }}}

" Visual config {{{
" let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1

set nocursorcolumn
set nocursorline
set number
set showmatch
set termguicolors
" }}}

" Folds {{{
let g:xml_syntax_folding=1
let g:perl_fold=1

set foldlevelstart=99
" }}}

" General keymaps and custom commands {{{
command! CDhere call ChangeCurrDir()

" Close window or delete buffer
"noremap <silent> <leader>q :call CloseWindowOrKillBuffer()<CR>
noremap <silent> <leader>q <C-W>c
" noremap <silent> <leader>dd :bdelete<CR>

" Backspace in visual mode deletes selection
vnoremap <BS> d

" Duplicate current line
nnoremap <C-D> YPj$

" Open/close folds
nnoremap <silent> + zo
nnoremap <silent> - zc

" Quickly sort selection
vnoremap <leader>s :sort i<CR>
vnoremap <leader>S :sort<CR>

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
nnoremap <leader>l :set list!<CR>

" Clear search highlight
nnoremap <silent> <Esc> :nohlsearch<CR><Esc>

" Saner n/N behaviour
nnoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward]

" Command-line history
cnoremap <C-N> <Down>
cnoremap <C-P> <Up>

" Saner redraw
nnoremap <leader>r :nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><C-L>

" Exit out of terminal mode on double esc
tnoremap <Esc><Esc> <C-\><C-N>

" }}}

" General autocmds {{{

" Easily close HTML tags
" http://vim.wikia.com/wiki/Auto_closing_an_HTML_tag
"autocmd FileType html,xml inoremap <buffer> </ </<C-X><C-O><C-N><Esc>a
"autocmd FileType html,xml inoremap <buffer> <<kDivide> </<C-X><C-O><C-N><Esc>a

" Toggle cursorline on entering insert mode
autocmd InsertEnter * set cursorline
autocmd InsertLeave *  set nocursorline

autocmd FileType coffee setl fdm=indent
autocmd FileType markdown setl nolist textwidth=78
autocmd FileType python setl fdm=indent
autocmd FileType text setl textwidth=78
autocmd FileType vim setl fdm=indent

" Go back to previous cursor position
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe 'normal! g`"zvzz' |
  \ endif

" }}}

" Colorscheme {{{
source ~/.config/nvim/fixcolors.vim

let g:seoul256_background = 235
let g:tender_airline = 1
let g:airline_theme = 'tender'
let g:wwdc16_term_italics = 1
let g:wwdc16_term_trans_bg = 1

set background=dark

colorscheme tender
" }}}

" Plugin settings {{{

" Utilities {{{

" MarcWeber/vim-addon-local-vimrc
let g:local_vimrc = {'names': ['.vimlocal'], 'hash_fun': 'LVRHashOfFile'}

" editorconfig/editorconfig-vim
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*', 'term://.*']
let g:EditorConfig_exec_path = '/usr/bin/editorconfig'

" mhinz/startify
let g:startify_session_dir = '~/.config/nvim/.cache/startify'
let g:startify_list_order = [
  \ ['Sessions'],
  \ 'sessions',
  \ ['Bookmarks'],
  \ 'bookmarks',
  \ ['Recently opened files'],
  \ 'files',
  \ ['Commands'],
  \ 'commands',
  \ ]
let g:startify_bookmarks = ['~/.config/nvim/', '~/.zshrc']
let g:startify_commands = [':PlugUpdate']
let g:startify_update_oldfiles = 1
let g:startify_session_before_save = [
  \ 'echo "Cleaning up before saving..."',
  \ 'silent! NERDTreeTabsClose'
  \ ]
let g:startify_session_persistence = 1
let g:startify_session_delete_buffers = 0
let g:startify_change_to_dir = 1
let g:startify_change_to_vcs_root = 0
let g:startify_enable_special = 0
let g:startify_session_sort = 1
let g:startify_custom_indices = map(range(1,100), 'string(v:val)')
" let g:startify_custom_header = []
let g:startify_show_sessions = 1
" nnoremap <M-F1> :Startify<CR>

" mhinz/vim-grepper
nnoremap <leader>ag :Grepper -tool ag -grepprg ag --vimgrep -G '^.+\.txt'<CR>

" qpkorr/vim-bufkill
nmap <silent> <leader>dd :BD<CR>

" tpope/vim-fugitive
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gp :Git push<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>
nnoremap <silent> <leader>gx :Gremove<CR>
autocmd BufReadPost fugitive://* set bufhidden=delete

" }}}

" Editing {{{

" Raimondi/delimitMate
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
autocmd FileType vim,html let b:delimitMate_matchpairs = "(:),[:],{:}"

" heavenshell/vim-jsdoc
let g:jsdoc_enable_es6 = 1
nnoremap <silent> <C-CR> <Plug>(jsdoc)

" jiangmiao/auto-pairs

" junegunn/goyo.vim

" junegunn/vim-easy-align

" mattn/emmet-vim
let g:user_emmet_install_global = 0
let g:emmet_html5 = 1
let g:user_emmet_expandabbr_key = '<C-E>'
let g:user_emmet_expandword_key = '<C-S-E>'
autocmd FileType html EmmetInstall

" scrooloose/nerdcommenter
let g:NERDSpaceDelims = 1

" shime/vim-livedown
let g:livedown_port = 8999
nnoremap <leader>md :LivedownToggle<CR>

" tpope/vim-repeat

" tpope/vim-speeddating

" tpope/vim-surround

" tpope/vim-unimpaired
nmap <C-S-Up> [e
nmap <C-S-Down> ]e
vmap <C-S-Up> [egv
vmap <C-S-Down> ]egv

" }}}

" Autocomplete {{{

" Shougo/context_filetype.vim

" Shougo/deoplete.nvim
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1

function! s:check_backspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"

call deoplete#custom#set('_', 'matchers', ['matcher_length', 'matcher_full_fuzzy'])

" carlitux/deoplete-ternjs

" ternjs/tern_for_vim
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']

" }}}

" Linting {{{

" neomake/neomake
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_open_list = 2
let g:neomake_list_height = 2
let g:neomake_warning_sign = {
  \ 'text': '',
  \ 'texthl': 'WarningMsg',
  \ }
let g:neomake_error_sign = {
  \ 'text': '',
  \ 'texthl': 'ErrorMsg',
  \ }
autocmd! BufWritePost * Neomake

" }}}

" Navigation {{{

" junegunn/fzf

" junegunn/fzf.vim
let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'
nnoremap <C-P> :FZF<CR>

" scrooloose/nerdtree
let NERDTreeBookmarksFile = '~/.config/nvim/.cache/NERDTreeBookmarks'
let NERDTreeChDirMode = 1
let NERDTreeQuitOnOpen = 0
let NERDTreeShowHidden = 1
let NERDTreeShowBookmarks = 1
nnoremap <F3> :NERDTreeToggle<CR>
nnoremap <S-F3> :NERDTreeFind<CR>
nnoremap <F15> :NERDTreeFind<CR>

" }}}

" Information {{{

" airblade/vim-gitgutter
let g:gitgutter_map_keys = 0
let g:gitgutter_sign_modified = '±'
let g:gitgutter_sign_modified_removed = '∓'

" nathanaelkane/vim-indent-guides
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_color_change_percent = 3

" vim-airline/vim-airline
let g:airline_powerline_fonts = 0
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#hunks#hunk_symbols = ['+', '±', '-']

let g:airline_symbols = {}

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.crypt = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.paste = ''
let g:airline_symbols.spell = ''
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = ''

" let g:airline_section_c = '%{FilenameOrTerm()}'

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

" yggdroot/indentline
let g:indentLine_enabled = 0
let g:indentLine_char = '┊'

nnoremap <leader>il :IndentLinesToggle<CR>

" }}}

" Syntax {{{

" digitaltoad/vim-jade

" docunext/closetag.vim

" gabrielelana/vim-markdown
let g:markdown_enable_spell_checking = 0
let g:markdown_enable_input_abbreviations = 0

" gregsexton/MatchTag

" kchmck/vim-coffee-script

" mxw/vim-jsx
" let g:jsx_ext_required = 0

" othree/yajs.vim

" posva/vim-vue

" }}}

" }}}
