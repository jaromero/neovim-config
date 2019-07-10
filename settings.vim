" vim: fdm=marker fmr={{{,}}}

" Basic editor prefs {{{
set clipboard+=unnamedplus
set errorbells
set diffopt+=vertical
set hidden
set inccommand=nosplit
set keymodel=startsel,stopsel
set mousemodel=popup
set ruler
set scrolloff=3
set showcmd
set nostartofline
set viewoptions=folds,options,cursor,unix,slash
set whichwrap=b,s,<,>,[,]
set updatetime=300
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
set backupcopy=yes
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
if has("nvim")
  set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
    \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
    \,sm:block-blinkwait175-blinkoff150-blinkon175

  autocmd VimLeave * set guicursor=a:block-blinkon0
endif

if has("conceal")
  set conceallevel=2
  set concealcursor=niv
endif

set mouse=a
set nocursorcolumn
set cursorline
set number
set showmatch
set signcolumn=yes

set termguicolors

if ($TERMINOLOGY == 1 || $TERM =~ "rxvt")
  set notermguicolors
endif
" }}}

" Folds {{{
let g:xml_syntax_folding=1
let g:perl_fold=1

set foldlevelstart=99
" }}}

" Utility functions {{{

function! s:check_backspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

" }}}

" General keymaps and custom commands {{{
command! CDhere call ChangeCurrDir()

" Close window or delete buffer
noremap <silent> <leader>qq <C-W>c

" Backspace in visual mode deletes selection
vnoremap <BS> d

" Duplicate current line
nnoremap <M-d> YPj$

" Open/close folds
nnoremap <silent> + zo
nnoremap <silent> - zc

" Quickly sort selection
vnoremap <leader>s :sort i<CR>
vnoremap <leader>S :sort<CR>

" Buffers - previous/next: S-F12, F12
nnoremap <silent> <leader>{ :bp<CR>
nnoremap <silent> <leader>} :bn<CR>

" Reselect block after indenting
vnoremap < <gv
vnoremap > >gv

" Smart home
" http://vim.wikia.com/wiki/Smart_home
noremap <expr> <Home> (col('.') == matchend(getline('.'), '^\s*')+1 ? '0' : '^')
imap <Home> <C-O><Home>

" Quickly toggle visuals
nnoremap <silent> <leader>ll :set list!<CR>
nnoremap <silent> <leader>lc :set cursorline!<CR>
nnoremap <silent> <leader>lv :set cursorcolumn!<CR>

" Clear search highlight
nnoremap <silent> <Esc> :nohlsearch<CR><Esc>

" Saner n/N behaviour
nnoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward]

" Command-line history
cnoremap <C-N> <Down>
cnoremap <C-P> <Up>

" Saner redraw
nnoremap <leader>R :nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><C-L>

" Exit out of terminal mode on double esc
if has("nvim")
  tnoremap <Esc><Esc> <C-\><C-N>
endif

" Show syntax highlighting group for word under cursor
function! <SID>SynStack()
    if !exists('*synstack')
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction
nnoremap <M-u> :call <SID>SynStack()<CR>

" }}}

" General autocmds {{{

" Easily close HTML tags
" http://vim.wikia.com/wiki/Auto_closing_an_HTML_tag
"autocmd FileType html,xml inoremap <buffer> </ </<C-X><C-O><C-N><Esc>a
"autocmd FileType html,xml inoremap <buffer> <<kDivide> </<C-X><C-O><C-N><Esc>a

" Toggle cursorline on entering insert mode
autocmd InsertEnter * set cursorline
autocmd InsertLeave *  set nocursorline

autocmd FileType coffee setl foldmethod=indent
autocmd FileType markdown setl nolist textwidth=0
autocmd FileType python setl foldmethod=indent
autocmd FileType text setl textwidth=78
autocmd FileType vim setl foldmethod=indent

" Set *.vue files as html
" autocmd BufRead,BufNewFile *.vue set filetype=html

" Hopefully fix syntax highlighting for *.vue files
autocmd FileType vue syntax sync fromstart

" Set *scss files as scss.css
" autocmd BufRead,BufNewFile *.scss set filetype=scss.css

" Go back to previous cursor position
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe 'normal! g`"zvzz' |
  \ endif

" }}}

" Colorscheme {{{
" source ~/.config/nvim/fixcolors.vim

let g:seoul256_background = 235

let g:wwdc16_term_italics = 1
let g:wwdc16_term_trans_bg = 1

let g:gruvbox_italic = 1
let g:gruvbox_italicize_comments = 0

let g:neodark#use_256color = 1
let g:neodark#terminal_transparent = 1

let g:deepspace_italics = 1

let g:quantum_black = 1
let g:quantum_italics = 1

let g:spacegray_use_italics = 1
let g:spacegray_low_contrast = 1

let g:one_allow_italics = 1

let g:palenight_terminal_italics = 1

" let g:tender_airline = 1
" let g:airline_theme = 'deep_space'
" let g:airline_theme = 'quantum'
let g:airline_theme = 'one'

set background=dark

colorscheme one
" }}}

" Plugin settings {{{

" Utilities {{{

" lambdalisue/suda.vim
let g:suda#prefix = 'sudo://'

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
let g:startify_bookmarks = ['~/.config/nvim/', '~/.zshrc', '~/.config/alacritty/alacritty.yml']
let g:startify_commands = [':PlugUpdate']
let g:startify_update_oldfiles = 0
let g:startify_session_before_save = [
  \ 'echo "Cleaning up before saving..."',
  \ 'silent! NERDTreeTabsClose'
  \ ]
let g:startify_session_persistence = 1
let g:startify_session_delete_buffers = 0
let g:startify_change_to_dir = 1
let g:startify_change_to_vcs_root = 1
let g:startify_fortune_use_unicode = 1
let g:startify_skiplist = [
  \ '^/media/',
  \ '^man:',
  \ '^/tmp/',
  \ '^/var/tmp/',
  \ ]
let g:startify_enable_special = 0
let g:startify_enable_unsafe = 0
let g:startify_session_sort = 1
let g:startify_custom_indices = map(range(1,100), 'string(v:val)')
" let g:startify_custom_header = []
let g:startify_show_sessions = 1
let g:startify_disable_at_vimenter = 0
" nnoremap <M-F1> :Startify<CR>

" mhinz/vim-grepper
let g:grepper = {}
let g:grepper.dir = 'repo,cwd'
nnoremap <leader>ag :Grepper -tool ag -grepprg ag --vimgrep --ignore \(node_modules\\|bower_components\)<CR>
nnoremap <leader>af :Grepper -buffers<CR>

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

" tpope/vim-rhubarb

" }}}

" Editing {{{

" Raimondi/delimitMate
let delimitMate_expand_cr = 2
let delimitMate_expand_space = 1
autocmd FileType vim,html let b:delimitMate_matchpairs = "(:),[:],{:}"

" heavenshell/vim-jsdoc
let g:jsdoc_enable_es6 = 1
nnoremap <silent> <C-CR> :JsDoc<CR>

" jiangmiao/auto-pairs
let g:AutoPairsShortcutToggle = ''

" junegunn/goyo.vim

" junegunn/vim-easy-align

" mattn/emmet-vim
" let g:user_emmet_install_global = 0
" let g:emmet_html5 = 1
" let g:user_emmet_expandabbr_key = '<C-E>'
" let g:user_emmet_expandword_key = '<C-S-E>'
" autocmd FileType html EmmetInstall

" shime/vim-livedown
let g:livedown_autorun = 1
let g:livedown_port = 8999
let g:livedown_open = 0
nnoremap <leader>md :LivedownToggle<CR>

" tpope/vim-repeat

" tpope/vim-speeddating

" tpope/vim-surround

" tpope/vim-unimpaired
nmap <M-S-Up> [e
nmap <M-S-K> [e
nmap <M-S-Down> ]e
nmap <M-S-J> ]e
vmap <M-S-Up> [egv
vmap <M-S-K> [egv
vmap <M-S-Down> ]egv
vmap <M-S-J> ]egv

" tyru/caw.vim
" g:caw_operator_keymappings = 0
nmap <Leader>c <Plug>(caw:prefix)
xmap <Leader>c <Plug>(caw:prefix)

" }}}

" Snippets {{{

" SirVer/ultisnips
" let g:UltiSnipsSnippetsDir="~/.config/nvim/snippets"
let g:UltiSnipsEnableSnipMate = 0
let g:UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)"
let g:UltiSnipsJumpForwardTrigger = "<Tab>"
let g:UltiSnipsJumpBackwardTrigger = "<S-Tab>"
" inoremap <silent> <C-E> <C-R>=cm#sources#ultisnips#trigger_or_popup("\<Plug>(ultisnips_expand)")<CR>

" }}}

" Autocomplete {{{

" Shougo/context_filetype.vim

" Shougo/deoplete.nvim
" Shougo/neosnippet.vim
" Shougo/neosnippet-snippets

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1

" let g:deoplete#sources = {}
" let g:deoplete#sources._ = ['buffer', 'tag', 'ultisnips']

" function! s:neosnippet_complete()
"   if pumvisible()
"     if neosnippet#expandable_or_jumpable()
"       return deoplete#close_popup() . "\<Plug>(neosnippet_expand_or_jump)"
"     endif
"
"     return deoplete#close_popup()
"   endif
"
"   if neosnippet#expandable_or_jumpable()
"     return "\<Plug>(neosnippet_expand_or_jump)"
"   endif
"
"   return "\<Tab>"
" endfunction

" imap <expr><Tab> <SID>neosnippet_complete()

" inoremap <expr><Down> pumvisible() ? "\<C-n>" : "\<Down>"
" inoremap <expr><Up> pumvisible() ? "\<C-p>" : "\<Up>"

" imap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
" imap <expr><BS> deoplete#smart_close_popup()."\<C-h>"

" call deoplete#custom#set('_', 'matchers', ['matcher_length', 'matcher_full_fuzzy'])

" let g:neosnippet#snippets_directory=['~/.config/nvim/snippets']

" carlitux/deoplete-ternjs

" ncm2/ncm2
set shortmess+=c
set completeopt=noinsert,menuone,noselect

" autocmd BufEnter * call ncm2#enable_for_buffer()

" inoremap <C-C> <Esc>
" inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
" inoremap <expr> <Up> pumvisible() ? "\<C-p>" : "\<Up>"

" let g:cm_matcher = {'module': 'cm_matchers.abbrev_matcher', 'case': 'smartcase'}
" let g:cm_completekeys = "\<Plug>(cm_omnifunc)"

" ternjs/tern_for_vim
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']

" }}}

" Language servers {{{

" autozimu/LanguageClient-neovim

" }}}

" coc.vim {{{

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_backspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <Tab> <Plug>(coc-range-select)
xmap <silent> <Tab> <Plug>(coc-range-select)
xmap <silent> <S-Tab> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" }}}

" Linting {{{

" w0rp/ale

" Standard glyphs/emojis
" let g:ale_sign_warning = '?'
" let g:ale_sign_error = '!'
" let g:ale_echo_msg_warning_str = 'W'
" let g:ale_echo_msg_error_str = 'E'

" When using FontAwesome
let g:ale_sign_warning = ''
let g:ale_sign_error = ''
let g:ale_echo_msg_warning_str = ''
let g:ale_echo_msg_error_str = ''

let g:ale_echo_msg_format = '[%severity%][%linter%] %s'
" let g:ale_set_quickfix = 1
" let g:ale_open_list = 0

let g:ale_linters = {
  \ 'css': ['stylelint'],
  \ 'html': [],
  \ 'sass': ['stylelint'],
  \ 'scss': ['stylelint'],
  \ 'vue': [],
  \ 'typescript': ['tslint']
  \ }

let g:ale_linter_aliases = {'vue': ['vue', 'html', 'css', 'javascript']}

" }}}

" Navigation {{{

" junegunn/fzf

" junegunn/fzf.vim
let $FZF_DEFAULT_COMMAND = 'ag -l --hidden --ignore .git -g ""'
nmap <M-p> :FZF<CR>
nmap <M-P> :Buffers<CR>
nmap <M-o> :Buffers<CR>

" Lokaltog/neoranger
" nnoremap <silent> <leader>f :Ranger<CR>
" nnoremap <silent> <leader>F :RangerCurrentFile<CR>
nnoremap <silent> <M-f> :Ranger<CR>
nnoremap <silent> <M-S-f> :RangerCurrentFile<CR>

" wesQ3/vim-windowswap

" }}}

" Information {{{

" airblade/vim-gitgutter
let g:gitgutter_map_keys = 0
let g:gitgutter_sign_modified = '±'
let g:gitgutter_sign_modified_removed = '∓'

" vim-airline/vim-airline
let g:airline_powerline_fonts = 0
let g:airline_symbols_ascii = 0
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffers_label = 'bufs'
let g:airline#extensions#tabline#tabs_label = 'tabs'
let g:airline#extensions#tabline#buffer_idx_mode = 0
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#buffer_nr_format = '%s┆'
let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#hunks#hunk_symbols = ['+', '±', '-']
" let g:airline#extensions#ale#warning_symbol = '?'
" let g:airline#extensions#ale#error_symbol = '!'

" When using FontAwesome
let g:airline#extensions#ale#warning_symbol = ' '
let g:airline#extensions#ale#error_symbol = ' '

" Replace all symbols
let g:airline_symbols = {}

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''

" Standard glyphs/emojis
" let g:airline_symbols.crypt = '🔑'
" let g:airline_symbols.readonly = '⛔'
" let g:airline_symbols.linenr = '📄'
" let g:airline_symbols.maxlinenr = ''
" let g:airline_symbols.branch = '🔀'
" let g:airline_symbols.paste = '📋'
" let g:airline_symbols.spell = '🔤'
" let g:airline_symbols.notexists = '❎'
" let g:airline_symbols.whitespace = '⚪'

" When using FontAwesome
let g:airline_symbols.crypt = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.paste = ''
let g:airline_symbols.spell = ''
let g:airline_symbols.notexists = ''
let g:airline_symbols.whitespace = ''

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

" yggdroot/indentline
let g:indentLine_enabled = 0
let g:indentLine_char = '┊'

nnoremap <leader>il :IndentLinesToggle<CR>

" }}}

" Syntax {{{

" ap/vim-css-color

" dag/vim-fish
autocmd FileType fish compiler fish
autocmd FileType fish setl textwidth=79
autocmd FileType fish setl foldmethod=expr

" digitaltoad/vim-jade

" docunext/closetag.vim

" gabrielelana/vim-markdown
let g:markdown_include_jekyll_support = 1
let g:markdown_enable_spell_checking = 0
let g:markdown_enable_input_abbreviations = 0

" gregsexton/MatchTag

" jelera/vim-javascript-syntax

" kchmck/vim-coffee-script

" leafgarland/typescript-vim

" mxw/vim-jsx
" let g:jsx_ext_required = 0

" MaxMEllon/vim-jsx-pretty
let g:vim_jsx_pretty_colorful_config = 1

"othree/html5.vim

"othree/javascript-libraries-syntax
" let g:used_javascript_libs = 'jquery,underscore,angularjs,angularui,angularuirouter,jasmine,ramda'

" othree/yajs.vim

" pangloss/vim-javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1

" posva/vim-vue
let g:vue_disable_pre_processors = 1

" Quramy/tsuquyomi

" Quramy/vim-js-pretty-template

" vim-pandoc/vim-pandoc
let g:pandoc#spell#enabled = 0

let g:pandoc#command#custom_open = "PandocOpen"

function! PandocOpen(file)
  return 'open ' . shellescape(expand(a:file, ':p'))
endfunction

" }}}

" }}}
