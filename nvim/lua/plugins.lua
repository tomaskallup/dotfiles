local packer = require 'packer'
local use = packer.use
return packer.startup(function()
    use 'wbthomason/packer.nvim'

    -- =======================================--
    --     Movement & editation plugins      --
    -- =======================================--
    use 'tpope/vim-repeat' -- Use `.` to repeat surround and other commands
    use 'tpope/vim-surround' -- (o_o) -> ca([ -> [o_o]
    use 'scrooloose/nerdcommenter' -- Comments
    use 'jiangmiao/auto-pairs' -- Matching parens, quotes etc.
    use { -- Add matching HTML tag
        'windwp/nvim-ts-autotag',
        config = function() require'nvim-ts-autotag'.setup() end
    }

    -- =======================================--
    --               UI plugins              --
    -- =======================================--
    use { -- Nice bar
        'hoob3rt/lualine.nvim',
        config = function() require 'plugins.lualine' end
    }
    -- use 'tomaskallup/arcolors' -- Colorscheme
    use { -- Colorscheme
        'marko-cerovac/material.nvim',
        branch = 'main',
        config = function()
            vim.g.material_borders = true
            vim.g.material_style = 'deep ocean'
            require'material'.set()
            vim.cmd([[
              hi DiffAdd guibg=#002500 guifg=None gui=None
              hi DiffDelete guibg=#250000 guifg=None gui=None
            ]])
        end
    }
    use 'kyazdani42/nvim-web-devicons' -- Icons
    use { -- For icons in completion
        'onsails/lspkind-nvim',
        config = function() require 'plugins.lspkind-nvim' end
    }

    -- =======================================--
    --             Syntax plugins            --
    -- =======================================--
    use { -- Ensure ansi color codes are handled
        'powerman/vim-plugin-AnsiEsc',
        config = function() vim.g.no_cecutil_maps = 1 end
    }
    use { -- Unified highlight for all filetypes
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function() require 'plugins.treesitter' end
    }
    use 'nvim-treesitter/playground'
    use {'aklt/plantuml-syntax'} -- Plant uml syntax
    use { -- Show colors in neovim (Red, Green, Blue, etc.)
        'norcalli/nvim-colorizer.lua',
        config = function() require'colorizer'.setup() end
    }
    use 'pantharshit00/vim-prisma'

    -- =======================================--
    --      IDE (completion, debugging)      --
    -- =======================================--
    use { -- Debugging, not yet ready
        'mfussenegger/nvim-dap',
        config = function() require 'plugins.nvim-dap' end
    }
    use { -- UI for DAP
        'rcarriga/nvim-dap-ui',
        config = function() require'dapui'.setup() end
    }
    use 'plytophogy/vim-virtualenv' -- Virtual env

    use {
        'airblade/vim-rooter',
        config = function() -- Automatically set pwd when opening a file
            vim.g.rooter_patterns = {'.venv', '.git/', '.nvim/'}
        end
    }

    use { -- LSP configurations for builtin LSP client
        'neovim/nvim-lspconfig',
        config = function() require 'plugins.nvim-lspconfig' end
    }
    -- use { -- Enhance built in LSP functions
    -- 'RishabhRD/nvim-lsputils',
    -- requires = {'RishabhRD/popfix'},
    -- config = function() require 'plugins.nvim-lsputils' end
    -- }
    use { -- LSP Completion
        'hrsh7th/nvim-compe',
        config = function() require 'plugins.nvim-compe' end
    }
    use "rafamadriz/friendly-snippets" -- Some nice snippets
    use "hrsh7th/vim-vsnip" -- Snippets framework
    use { -- Typescript LSP enhancements (configured in LSP)
        'jose-elias-alvarez/nvim-lsp-ts-utils',
        branch = 'main'
    }
    use { -- Support for non-LSP stuff via LSP (configured in LSP)
        'jose-elias-alvarez/null-ls.nvim',
        branch = 'main'
    }
    use { -- Show signature help when typing
        'ray-x/lsp_signature.nvim'
    }
    use { -- Simple lsp enhancements
        'nvim-lua/lsp_extensions.nvim',
        config = function() require 'plugins.lsp_extensions' end
    }
    use { -- Spell checking!
        'kamykn/spelunker.vim'
    }

    -- =======================================--
    --           Workflow plugins            --
    -- =======================================--
    use {'ms-jpq/chadtree', branch = 'chad', run = 'python3 -m chadtree deps'}
    use {
        'vimwiki/vimwiki',
        config = function()
            vim.g.vimwiki_list = {
                {path = '/home/armeeh/vimwiki', syntax = 'markdown'}
            }
            vim.g.vimwiki_map_prefix = '<leader>e'
        end
    }
    use 'blindFS/vim-taskwarrior' -- Task management
    use 'tools-life/taskwiki'

    use { -- Better than fzf, amazing search
        'nvim-telescope/telescope.nvim',
        requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'},
        config = function() require 'plugins.telescope' end
    }
    use { -- Dap integration for telescope
        'nvim-telescope/telescope-dap.nvim'
    }
    use {
        'nvim-telescope/telescope-project.nvim',
        requires = {'nvim-telescope/telescope.nvim'}
    }
    use { -- Better sorting in telescope
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
    }

    use 'moll/vim-bbye' -- Better buffer management

    -- =======================================--
    --    Experimental (testing plugins)     --
    -- =======================================--
    use {
        'lewis6991/gitsigns.nvim',
        config = function() require 'plugins.gitsigns' end
    }
    use {
        'TimUntersberger/neogit',
        config = function() require 'plugins.neogit' end
    }
    use {'folke/lua-dev.nvim'}
    use {
        'folke/trouble.nvim',
        config = function() require'trouble'.setup {} end
    }
    use 'kevinhwang91/nvim-bqf'

    use '~/Pkg/nvim-lsp-ui'
end)
