local packer = require 'packer'
local use = packer.use
return packer.startup(function()
    use 'wbthomason/packer.nvim'

    -- =======================================--
    --     Movement & editation plugins      --
    -- =======================================--
    use 'tpope/vim-repeat' -- Use `.` to repeat surrount and other commands
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
        config = function()
            vim.g.material_style = 'deep ocean'
            require'material'.set()
        end
    }
    use 'kyazdani42/nvim-web-devicons' -- Icons
    use 'onsails/lspkind-nvim' -- For icons in completion

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
    use 'aklt/plantuml-syntax' -- Plant uml syntax

    -- =======================================--
    --      IDE (completion, debugging)      --
    -- =======================================--
    -- use 'puremourning/vimspector'
    use {
        'mfussenegger/nvim-dap',
        config = function() require 'plugins.nvim-dap' end
    } -- Debugging, not yet ready
    use 'plytophogy/vim-virtualenv' -- Virtual env

    use {
        'airblade/vim-rooter',
        config = function() -- Automatically set pwd when opening a file
            vim.g.rooter_patterns = {'.venv', '.git/', '.vim/'}
        end
    }

    use { -- LSP configurations for builtin LSP client
        'neovim/nvim-lspconfig',
        config = function() require 'plugins.nvim-lspconfig' end
    }
    use { -- Enhance built in LSP functions
        'RishabhRD/nvim-lsputils',
        requires = {'RishabhRD/popfix'}
    }
    use { -- LSP Completion
        'hrsh7th/nvim-compe',
        config = function() require 'plugins.nvim-compe' end
    }
    use "rafamadriz/friendly-snippets" -- Some nice snippets
    use "hrsh7th/vim-vsnip" -- Snippets framework
    use { -- Typescript LSP enhancements (configured in LSP)
        'jose-elias-alvarez/nvim-lsp-ts-utils',
        branch = 'develop'
    }

    -- =======================================--
    --           Workflow plugins            --
    -- =======================================--
    use { -- File explorer
        'kyazdani42/nvim-tree.lua',
        confing = function() require 'plugins.nvim-tree' end
    }
    use {
        'vimwiki/vimwiki',
        config = function()
            vim.g.vimwiki_list = {{path = '/home/armeeh/vimwiki'}}
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
    use {
        'nvim-telescope/telescope-dap.nvim',
        requires = {'mfussenegger/nvim-dap', 'nvim-telescope/telescope.nvim'}
    } -- Dap integration for telescope
    use 'moll/vim-bbye' -- Better buffer management

    -- =======================================--
    --    Experimental (testing plugins)     --
    -- =======================================--
    use 'pwntester/octo.nvim' -- Github integration, with telescope support!
    use {
        -- 'lewis6991/gitsigns.nvim',
        '~/Pkg/gitsigns.nvim',
        config = function() require 'plugins.gitsigns' end
    }
    use 'teal-language/vim-teal' -- Teal language support
    use 'rust-lang/rust.vim' -- Rust support

    -- use 'junegunn/vim-easy-align' -- Align stuff
    -- use 'erietz/vim-terminator'
    use 'ron-rs/ron.vim' -- Ron syntax
    use { -- Show colors in neovim (Red, Green, Blue, etc.)
        'norcalli/nvim-colorizer.lua',
        config = function() require'colorizer'.setup() end
    }
end)
