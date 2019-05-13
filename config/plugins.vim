call plug#begin()

" --------------------------------------------------------------------- "
"  Better movement plugins                                              "
" --------------------------------------------------------------------- "
Plug 'Lokaltog/vim-easymotion' " Fast cursor jumping in files
Plug 'scrooloose/nerdtree' " Nice file explorer inside vim
Plug 'jlanzarotta/bufexplorer' " Better buffer management
Plug 'Xuyuanp/nerdtree-git-plugin' " Show git changes in NERDtree
Plug 'ctrlpvim/ctrlp.vim' " File finder

" -------------------------------------------------------------------- "
"  Design changing plugins                                             "
" -------------------------------------------------------------------- "
Plug 'itchyny/lightline.vim' " Nice bar
Plug 'ryanoasis/vim-devicons' " Nice file icons

" -------------------------------------------------------------------- "
"  Syntax and autocomplete                                             "
" -------------------------------------------------------------------- "
Plug 'JulesWang/css.vim' " Better CSS support (for highlight)
Plug 'othree/html5.vim' " HTML5 tags
Plug 'groenewege/vim-less' " Less syntax
Plug 'elzr/vim-json' " Json syntax fix
Plug 'pangloss/vim-javascript' " Better JS syntax & indent
Plug 'chemzqm/vim-jsx-improve'
Plug 'HerringtonDarkholme/yats.vim' " TS + TSX
Plug 'mustache/vim-mustache-handlebars'
Plug 'jasonshell/vim-svg-indent'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-endwise' " Autoclose if etc.
Plug 'tpope/vim-rails', {'for': 'ruby'}

if !&diff
    Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
    "Plug 'prabirshrestha/asyncomplete.vim'
    "Plug 'prabirshrestha/async.vim'
    "Plug 'prabirshrestha/vim-lsp'
    "Plug 'prabirshrestha/asyncomplete-lsp.vim'
    "Plug 'prabirshrestha/asyncomplete-file.vim'
    "Plug 'prabirshrestha/asyncomplete-buffer.vim'
    "Plug 'w0rp/ale'
endif

" -------------------------------------------------------------------- "
"  Other general stuff                                                 "
" -------------------------------------------------------------------- "
Plug 'scrooloose/nerdcommenter' " Comments
Plug 'tpope/vim-surround' " (o_o)
Plug 'airblade/vim-rooter'
Plug 'editorconfig/editorconfig-vim'

call plug#end()

" -------------------------------------------------------------------- "
"  Default vim stuff                                                   "
" -------------------------------------------------------------------- "
packadd! matchit
