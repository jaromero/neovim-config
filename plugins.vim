" vim: fdm=marker fmr={{{,}}} fdl=0

" Plugin definitions
" No config here; see settings.vim
call plug#begin()

" Utilities
Plug 'MarcWeber/vim-addon-local-vimrc'
Plug 'editorconfig/editorconfig-vim'
Plug 'mhinz/vim-startify'
Plug 'mhinz/vim-grepper'
Plug 'tpope/vim-fugitive'

" Editing
Plug 'Raimondi/delimitMate'
Plug 'heavenshell/vim-jsdoc'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-easy-align'
Plug 'mattn/emmet-vim'
Plug 'scrooloose/nerdcommenter'
Plug 'shime/vim-livedown', {'for': 'markdown'}
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

" Autocomplete
Plug 'Shougo/context_filetype.vim'
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'carlitux/deoplete-ternjs'
Plug 'ternjs/tern_for_vim'

" Linting
Plug 'neomake/neomake'

" Navigation
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}

" Information
Plug 'airblade/vim-gitgutter'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'vim-airline/vim-airline'

" Syntax
Plug 'othree/yajs.vim', {'for': 'javascript'}
Plug 'kchmck/vim-coffee-script', {'for': ['coffee', 'litcoffee']}
Plug 'gregsexton/MatchTag', {'for': ['html', 'xml']}
Plug 'digitaltoad/vim-jade', {'for': ['jade', 'pug']}
Plug 'gabrielelana/vim-markdown', {'for': 'markdown'}

" Colorschemes
Plug 'cseelus/vim-colors-lucid'
Plug 'jaromero/vim-monokai-refined'
Plug 'junegunn/seoul256.vim'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'rakr/vim-one'
Plug 'raphamorim/lucario'
Plug 'whatyouhide/vim-gotham'

call plug#end()
