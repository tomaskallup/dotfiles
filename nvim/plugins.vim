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
Plug 'tpope/vim-repeat' " Use `.` to repeat surrount and other commands
Plug 'tpope/vim-surround' " (o_o) -> ca([ -> [o_o]
Plug 'scrooloose/nerdcommenter' " Comments
Plug 'jiangmiao/auto-pairs' " Matching parens, quotes etc.

"======================================="
"               UI plugins              "
"======================================="
Plug 'itchyny/lightline.vim' " Nice bar
Plug 'tomaskallup/arcolors' " Colorscheme
Plug 'kyazdani42/nvim-web-devicons' " Icons
Plug 'onsails/lspkind-nvim' " For icons in completion

"======================================="
"             Syntax plugins            "
"======================================="
Plug 'powerman/vim-plugin-AnsiEsc' " Ensure ansi color codes are handled
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " Godly highlight
Plug 'nvim-treesitter/playground'
Plug 'aklt/plantuml-syntax' " Plant uml syntax

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
Plug 'kyazdani42/nvim-tree.lua' " Explorer
Plug 'vimwiki/vimwiki'
Plug 'blindFS/vim-taskwarrior' " Task management
Plug 'tools-life/taskwiki'
Plug 'nvim-telescope/telescope.nvim' " Better than fzf, amazing search
Plug 'nvim-telescope/telescope-dap.nvim' " Dap integration for telescope
Plug 'moll/vim-bbye' " Better buffer management

"======================================="
"    Experimental (testing plugins)     "
"======================================="
"Plug 'junegunn/vim-easy-align' " Align stuff

Plug 'mfussenegger/nvim-dap' " Debugging, not yet ready
"Plug 'erietz/vim-terminator'
Plug 'pwntester/octo.nvim' " Github integration
Plug 'lewis6991/gitsigns.nvim'

call plug#end()
