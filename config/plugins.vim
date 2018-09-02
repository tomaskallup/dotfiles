call plug#begin()

" --------------------------------------------------------------------- "
"  Better movement plugins                                              "
" --------------------------------------------------------------------- "
Plug 'Lokaltog/vim-easymotion' " Fast cursor jumping in files
Plug 'scrooloose/nerdtree' " Nice file explorer inside vim
Plug 'jlanzarotta/bufexplorer' " Better buffer management
Plug 'Xuyuanp/nerdtree-git-plugin' " Show git changes in NERDtree
Plug 'ctrlpvim/ctrlp.vim' " File finder
Plug 'xolox/vim-easytags' " OPOP
Plug 'xolox/vim-misc' " ^ He needs it

" -------------------------------------------------------------------- "
"  Design changing plugins                                             "
" -------------------------------------------------------------------- "
"Plug 'itchyny/lightline.vim' " Nice bar
Plug 'ryanoasis/vim-devicons' " Nice file icons
Plug 'mhinz/vim-startify' " Cool startup screen

" -------------------------------------------------------------------- "
"  Syntax and autocomplete                                             "
" -------------------------------------------------------------------- "
Plug 'JulesWang/css.vim' " Better CSS support (for highlight)
Plug 'othree/html5.vim' " HTML5 tags
Plug 'groenewege/vim-less' " Less syntax
Plug 'elzr/vim-json' " Json syntax fix
Plug 'pangloss/vim-javascript' " Better JS syntax & indent
Plug 'mxw/vim-jsx' " JSX syntax
Plug 'HerringtonDarkholme/yats.vim' " TS + TSX
Plug 'digitaltoad/vim-pug'

if !&diff
    Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
endif

" -------------------------------------------------------------------- "
"  Other general stuff                                                 "
" -------------------------------------------------------------------- "
Plug 'scrooloose/nerdcommenter' " Comments
Plug 'mattn/emmet-vim' " Html godlike
Plug 'sjl/gundo.vim' " Better undo
Plug 'tpope/vim-surround' " (o_o)
Plug 'airblade/vim-rooter'

if !&diff
    Plug 'w0rp/ale' " Linter lul
endif

call plug#end()

" -------------------------------------------------------------------- "
"  Default vim stuff                                                   "
" -------------------------------------------------------------------- "
packadd! matchit
