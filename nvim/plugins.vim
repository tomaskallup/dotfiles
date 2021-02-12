call plug#begin()

"======================================="
"               Libraries               "
"======================================="
Plug 'nvim-lua/popup.nvim' " Required by telescope
Plug 'nvim-lua/plenary.nvim' " Required by popup.nvim

Plug 'RishabhRD/popfix' " Required by lsputils

"======================================="
"     Movement & editation plugins      "
"======================================="
"Plug 'ctrlpvim/ctrlp.vim' " File finder
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
Plug 'RishabhRD/nvim-lsputils' " Enhance built in LSP functions
Plug 'hrsh7th/nvim-compe' " LSP Completion

if !&diff
    "Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
endif

"======================================="
"           Workflow plugins            "
"======================================="
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'} " Explorer
Plug 'vimwiki/vimwiki'
Plug 'blindFS/vim-taskwarrior' " Task management
Plug 'tools-life/taskwiki'
Plug 'nvim-telescope/telescope.nvim' " Better than fzf, amazing search

"======================================="
"    Experimental (testing plugins)     "
"======================================="
Plug 'tomaskallup/arcolors' " Colorscheme
Plug 'junegunn/vim-easy-align' " Align stuff


call plug#end()
