call plug#begin()

" --------------------------------------------------------------------- "
"  Better movement plugins                                              "
" --------------------------------------------------------------------- "
Plug 'Lokaltog/vim-easymotion' " Fast cursor jumping in files
Plug 'scrooloose/nerdtree' " Nice file explorer inside vim
"Plug 'jlanzarotta/bufexplorer' " Better buffer management
Plug 'Xuyuanp/nerdtree-git-plugin' " Show git changes in NERDtree
Plug 'ctrlpvim/ctrlp.vim' " File finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'mileszs/ack.vim' " Grep in vim

" -------------------------------------------------------------------- "
"  Design changing plugins                                             "
" -------------------------------------------------------------------- "
Plug 'itchyny/lightline.vim' " Nice bar
"Plug 'ryanoasis/vim-devicons' " Nice file icons

" -------------------------------------------------------------------- "
"  IDE-like stuff ( Syntax and autocomplete )                          "
" -------------------------------------------------------------------- "
Plug 'JulesWang/css.vim' " Better CSS support (for highlight)
Plug 'othree/html5.vim' " HTML5 tags
Plug 'groenewege/vim-less' " Less syntax
Plug 'elzr/vim-json' " Json syntax fix
Plug 'pangloss/vim-javascript' " Better JS syntax & indent
Plug 'chemzqm/vim-jsx-improve'
Plug 'tomaskallup/yats.vim' " TS + TSX
"Plug 'jasonshell/vim-svg-indent'
"Plug 'PratikBhusal/vim-grip' " Grip integration
Plug 'tpope/vim-markdown'
"Plug 'tpope/vim-endwise' " Autoclose if etc.
"Plug 'tpope/vim-fugitive'
Plug 'baskerville/vim-sxhkdrc'
"Plug 'digitaltoad/vim-pug'
Plug 'puremourning/vimspector'

if !&diff
    Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
endif

" -------------------------------------------------------------------- "
"  Other general stuff                                                 "
" -------------------------------------------------------------------- "
Plug 'scrooloose/nerdcommenter' " Comments
Plug 'tpope/vim-surround' " (o_o)
Plug 'airblade/vim-rooter'
Plug 'editorconfig/editorconfig-vim'
"Plug 'godlygeek/tabular' " Align stuff
Plug 'plytophogy/vim-virtualenv' " Virtual env
Plug 'blindFS/vim-taskwarrior' " Task management

call plug#end()
