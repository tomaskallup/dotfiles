call plug#begin()

"======================================="
"     Movement & editation plugins      "
"======================================="
"Plug 'ctrlpvim/ctrlp.vim' " File finder
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/remote', 'do': ':UpdateRemotePlugins' }
Plug 'tpope/vim-surround' " (o_o) -> ca([ -> [o_o]
Plug 'scrooloose/nerdcommenter' " Comments
Plug 'jiangmiao/auto-pairs' " Matching parens, quotes etc.

"======================================="
"               UI plugins              "
"======================================="
Plug 'itchyny/lightline.vim' " Nice bar

"======================================="
"             Syntax plugins            "
"======================================="
"Plug 'tomaskallup/yats.vim' " TS + TSX
Plug 'powerman/vim-plugin-AnsiEsc' " Ensure ansi color codes are handled
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " Godly highlight (not yet)
Plug 'nvim-treesitter/playground'

"======================================="
"      IDE (completion, debugging)      "
"======================================="
"Plug 'puremourning/vimspector'
Plug 'plytophogy/vim-virtualenv' " Virtual env
Plug 'airblade/vim-rooter'
Plug 'neovim/nvim-lspconfig' " LSP configurations for builtin LSP client
Plug 'RishabhRD/popfix'
Plug 'RishabhRD/nvim-lsputils' " Enhance built in LSP functions
Plug 'hrsh7th/nvim-compe' " LSP Completion

if !&diff
    "Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
endif

"======================================="
"           Workflow plugins            "
"======================================="
Plug 'vimwiki/vimwiki'
Plug 'blindFS/vim-taskwarrior' " Task management
Plug 'tools-life/taskwiki'

"======================================="
"    Experimental (testing plugins)     "
"======================================="
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

call plug#end()
