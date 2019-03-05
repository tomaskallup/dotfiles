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
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'janiczek/vim-latte' " I don't like where this is going

if !&diff
    "Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}, 'tag': '*'} " YCM, your demise is getting close!
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/async.vim'
    Plug 'prabirshrestha/vim-lsp'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
    Plug 'prabirshrestha/asyncomplete-file.vim'
    Plug 'prabirshrestha/asyncomplete-buffer.vim'
    Plug 'w0rp/ale'
endif

" -------------------------------------------------------------------- "
"  Other general stuff                                                 "
" -------------------------------------------------------------------- "
Plug 'scrooloose/nerdcommenter' " Comments
"Plug 'mattn/emmet-vim' " Html godlike
"Plug 'sjl/gundo.vim' " Better undo
Plug 'tpope/vim-surround' " (o_o)
Plug 'airblade/vim-rooter'
Plug 'editorconfig/editorconfig-vim'

call plug#end()

" -------------------------------------------------------------------- "
"  Default vim stuff                                                   "
" -------------------------------------------------------------------- "
packadd! matchit
