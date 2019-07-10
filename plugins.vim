" vim: fdm=marker fmr={{{,}}}

" Plugin definitions
" No config here; see settings.vim
call plug#begin()

" Utilities
Plug 'editorconfig/editorconfig-vim'
Plug 'kana/vim-operator-user'
Plug 'lambdalisue/suda.vim'
Plug 'MarcWeber/vim-addon-local-vimrc'
Plug 'mhinz/vim-grepper'
Plug 'mhinz/vim-startify'
Plug 'qpkorr/vim-bufkill'
Plug 'Shougo/context_filetype.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" Editing
Plug 'Raimondi/delimitMate'
Plug 'heavenshell/vim-jsdoc', {'for': ['javascript', 'javascript.jsx', 'typescript', 'vue', 'html', 'pug']}
" Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-easy-align'
" Plug 'mattn/emmet-vim', {'for': ['html', 'vue']}
Plug 'shime/vim-livedown', {'for': ['markdown', 'pandoc']}
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tyru/caw.vim'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Autocomplete
" Plug 'ncm2/ncm2'
" Plug 'roxma/nvim-yarp'
"
" Plug 'ncm2/ncm2-bufword'
" Plug 'ncm2/ncm2-cssomni'
" Plug 'ncm2/ncm2-path'
" Plug 'ncm2/ncm2-tern', {'do': 'yarn'}
" Plug 'ncm2/ncm2-ultisnips'
" Plug 'ncm2/ncm2-vim'
" Plug 'wellle/tmux-complete.vim'
"
" Plug 'ncm2/ncm2-html-subscope', {'for': ['javascript', 'vue', 'pug']}
" Plug 'ncm2/ncm2-markdown-subscope', {'for': ['markdown', 'pandoc']}
"
" Plug 'ternjs/tern_for_vim', {'for': ['javascript', 'javascript.jsx', 'vue', 'html', 'pug']}

" Language servers
" Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}

" coc.vim
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

Plug 'Shougo/neco-vim'
Plug 'neoclide/coc-neco'

" Linting
Plug 'w0rp/ale'

" Navigation
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
Plug 'Lokaltog/neoranger', {'branch': 'develop'}
Plug 'wesQ3/vim-windowswap'

" Information
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'yggdroot/indentline'

" Syntax
Plug 'ap/vim-css-color'
Plug 'cakebaker/scss-syntax.vim'
Plug 'dag/vim-fish'
Plug 'digitaltoad/vim-jade', {'for': ['jade', 'pug']}
Plug 'docunext/closetag.vim', {'for': ['html', 'xml']}
Plug 'elzr/vim-json', {'for': 'json'}
Plug 'fleischie/vim-styled-components', {'for': ['javascript', 'javascript.jsx', 'vue', 'typescript']}
" Plug 'gabrielelana/vim-markdown', {'for': 'markdown'}
Plug 'gregsexton/MatchTag', {'for': ['html', 'xml']}
Plug 'hail2u/vim-css3-syntax'
" Plug 'jelera/vim-javascript-syntax'
Plug 'kchmck/vim-coffee-script', {'for': ['coffee', 'litcoffee']}
Plug 'leafgarland/typescript-vim'
" Plug 'pangloss/vim-javascript' | Plug 'mxw/vim-jsx'
Plug 'MaxMEllon/vim-jsx-pretty', {'for': ['javascript.jsx', 'html']}
Plug 'mboughaba/i3config.vim'
" Plug 'mxw/vim-jsx', {'for': ['javascript', 'javascript.jsx', 'html']}
Plug 'othree/html5.vim', {'for': 'html'}
" Plug 'othree/javascript-libraries-syntax.vim', {'for': 'javascript'}
" Plug 'othree/yajs.vim', {'for': ['javascript', 'javascript.jsx', 'html']}
Plug 'pangloss/vim-javascript'
Plug 'posva/vim-vue', {'for': ['javascript', 'html', 'vue']}
Plug 'Quramy/tsuquyomi'
Plug 'Quramy/vim-js-pretty-template', {'for': ['javascript', 'vue', 'typescript']}
Plug 'tpope/vim-jdaddy', {'for': 'json'}
" Plug 'tpope/vim-markdown', {'for': 'markdown'}
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

" Colorschemes
Plug 'ajh17/Spacegray.vim'
Plug 'chriskempson/base16-vim'
Plug 'cseelus/vim-colors-lucid'
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'drewtempelmeyer/palenight.vim'
Plug 'jacoborus/tender'
Plug 'jaromero/vim-monokai-refined'
Plug 'jnurmine/zenburn'
Plug 'junegunn/seoul256.vim'
Plug 'KeitaNakamura/neodark.vim'
Plug 'koirand/tokyo-metro.vim'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'lifepillar/vim-wwdc16-theme'
Plug 'mbbill/vim-seattle'
Plug 'mhartington/oceanic-next'
Plug 'morhetz/gruvbox'
Plug 'muellan/am-colors'
Plug 'nanotech/jellybeans.vim'
Plug 'nlknguyen/papercolor-theme'
Plug 'philpl/vim-adventurous'
Plug 'Pychimp/vim-luna'
Plug 'rakr/vim-one'
Plug 'romainl/Apprentice', {'branch': 'fancylines-and-neovim'}
Plug 'sjl/badwolf'
Plug 'tomasr/molokai'
Plug 'trevordmiller/nova-vim'
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'tyrannicaltoucan/vim-quantum'
Plug 'whatyouhide/vim-gotham'
Plug 'zeis/vim-kolor'

Plug 'tsiemens/vim-aftercolors'

call plug#end()
